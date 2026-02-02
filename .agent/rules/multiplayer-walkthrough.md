# Godot 4 Multiplayer Implementation Walkthrough

> **Project**: Duo Guardians (2인 협동 뱀서라이크)  
> **Engine**: Godot 4.5  
> **Date**: 2026-01-27

---

## 1. 아키텍처 개요

### 1.1 네트워크 모델
- **Server Authority**: 모든 게임 로직(이동, 전투, 경험치)은 **호스트(Server)**에서만 실행.
- **Client Role**: 입력(Input)을 서버로 전송하고, 동기화된 상태를 수신/표시.
- **Synchronization**: `MultiplayerSynchronizer` 노드로 Position, Velocity, HP 등을 자동 복제.

### 1.2 핵심 Autoload 싱글톤
| Singleton | 역할 |
|-----------|------|
| `SteamManager` | Steam 로비 생성/참여, LAN(ENet) 호스팅/조인, 씬 전환 RPC |
| `GameManager` | 게임 타이머, 레벨/경험치, 스킬 선택, 페이즈 관리 |
| `LobbyManager` | 영구 업그레이드(메타 진행), 크레딧 |
| `InventoryManager` | 인벤토리 (미구현) |

---

## 2. 주요 스크립트 구조

### 2.1 `SteamManager.gd`
```gdscript
# LAN 호스팅
func create_lan_host() -> void:
    enet_peer = ENetMultiplayerPeer.new()
    enet_peer.create_server(DEFAULT_PORT, LOBBY_MAX_MEMBERS)
    multiplayer.multiplayer_peer = enet_peer

# LAN 참여
func join_lan_game(ip: String) -> void:
    enet_peer = ENetMultiplayerPeer.new()
    enet_peer.create_client(ip, DEFAULT_PORT)
    multiplayer.multiplayer_peer = enet_peer

# 게임 시작 요청 (모든 피어 가능)
func start_game_request() -> void:
    rpc("request_start_game_rpc")

@rpc("any_peer", "call_local", "reliable")
func request_start_game_rpc() -> void:
    if multiplayer.is_server():
        rpc("load_test_scene")

@rpc("call_local", "reliable")
func load_test_scene() -> void:
    get_tree().change_scene_to_file("res://src/scenes/MultiplayerTest.tscn")
```

**핵심 포인트**:
- Steam 싱글톤은 `Engine.get_singleton("Steam")`으로 동적 접근 (확장 미설치 시 오류 방지).
- `SteamMultiplayerPeer`는 `ClassDB.instantiate()`로 생성.

---

### 2.2 `player_controller.gd`
```gdscript
func _enter_tree():
    set_multiplayer_authority(name.to_int())

func _physics_process(delta):
    if not multiplayer.has_multiplayer_peer(): return
    if multiplayer.multiplayer_peer.get_connection_status() != MultiplayerPeer.CONNECTION_CONNECTED: return

    if is_multiplayer_authority():
        _process_local_input()
    
    if multiplayer.is_server():
        _apply_movement(delta)

func _process_local_input():
    var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if not multiplayer.is_server():
        rpc_id(1, "server_receive_input", input_vector)
    else:
        current_input_vector = input_vector

@rpc("any_peer", "call_local", "unreliable_ordered")
func server_receive_input(input_vec: Vector2):
    if multiplayer.is_server():
        current_input_vector = input_vec

func _apply_movement(_delta):
    velocity = current_input_vector * movement_speed
    move_and_slide()
```

**핵심 포인트**:
- Authority는 노드 이름(Peer ID)으로 설정: `set_multiplayer_authority(name.to_int())`.
- 입력은 Client → Server로 RPC 전송, Server가 물리 적용, `MultiplayerSynchronizer`가 결과 동기화.

---

### 2.3 `multiplayer_test.gd` (게임 씬 컨트롤러)
```gdscript
func _ready():
    get_tree().paused = true  # 로딩 동기화 전 일시정지
    rpc_id(1, "notify_scene_loaded")

@rpc("any_peer", "call_local", "reliable")
func notify_scene_loaded():
    if not multiplayer.is_server(): return
    loaded_peers_count += 1
    if loaded_peers_count >= multiplayer.get_peers().size() + 1:
        _spawn_existing_players()
        rpc("start_match_rpc")

@rpc("call_local", "authority", "reliable")
func start_match_rpc():
    get_tree().paused = false

func _spawn_player(id: int):
    var player = player_scene.instantiate()
    player.name = str(id)  # Authority 매핑용
    players_node.add_child(player)
```

**핵심 포인트**:
- 씬 로딩 후 `paused = true`로 대기.
- 모든 피어가 `notify_scene_loaded` 신호를 보내면 스폰 + 게임 재개.
- `MultiplayerSpawner`가 `Players` 노드를 감시하여 자동 복제.

---

## 3. 씬 구조 (MultiplayerTest.tscn)

```
MultiplayerTest (Control)
├── MapBackground (ColorRect, 5000x5000)
├── Players (Node2D) ← MultiplayerSpawner가 감시
├── MultiplayerSpawner (spawn_path="../Players")
├── Enemies (Node2D) ← EnemySpawner 스크립트
├── EnemySpawner (MultiplayerSpawner, spawn_path="../Enemies")
├── Projectiles (Node2D)
├── ProjectileSpawner (MultiplayerSpawner, spawn_path="../Projectiles")
├── BondLink (인스턴스)
└── UI (CanvasLayer)
    ├── DuoControlUI
    └── LevelUpUI
```

**TSCN 작성 규칙**:
- 외부 리소스는 반드시 `[ext_resource]` 헤더에 선언 후 ID로 참조.
- `instance=ExtResource("id")` 문법 사용.

---

## 4. Entity 동기화 패턴

### 4.1 Player.tscn
```gdscript
[sub_resource type="SceneReplicationConfig" id="sync"]
properties/0/path = NodePath(".:position")
properties/0/spawn = true
properties/0/replication_mode = 1  # Always
properties/1/path = NodePath(".:velocity")
properties/1/spawn = true
properties/1/replication_mode = 1
```

### 4.2 Enemy/Gem 스폰 시 이름 지정 (필수!)
```gdscript
# base_enemy.gd -> drop_gem()
gem.name = "ExpGem_" + str(randi())
get_parent().add_child(gem)

# enemy_spawner.gd -> _spawn_wave()
enemy.name = "Enemy_" + str(randi())
add_child(enemy)
```
> `MultiplayerSpawner`는 `@Node@123` 형태의 자동 생성 이름을 거부합니다.

---

## 5. 흔한 오류 및 해결

| 오류 메시지 | 원인 | 해결 |
|------------|------|------|
| `Parser Error: Could not find type "SteamMultiplayerPeer"` | GodotSteam 확장 미설치 | `ClassDB.instantiate()` 동적 생성 사용 |
| `Node not found: "MultiplayerTest/MultiplayerSpawner"` | 클라이언트 씬 로딩 전 스폰 패킷 도착 | `notify_scene_loaded` 핸드셰이크 구현 |
| `Unable to auto-spawn node with reserved name: @Area2D@...` | 노드 이름 미지정 | 스폰 전 `node.name = "Unique_" + str(randi())` |
| `Flushing queries` 에러 | 물리 스텝 중 노드 추가/제거 | `call_deferred("_deferred_die")` 사용 |
| `Multiplayer instance isn't currently active` | 연결 전 `is_multiplayer_authority()` 호출 | `has_multiplayer_peer()` + `CONNECTION_CONNECTED` 체크 |

---

## 6. 디버깅 전략

### 6.1 역할 구분 로그
```gdscript
func get_net_role() -> String:
    return "[Server]" if multiplayer.is_server() else "[Client]"
```

### 6.2 물리 이동 디버그
```gdscript
func _apply_movement(_delta):
    var old_pos = global_position
    velocity = current_input_vector * movement_speed
    move_and_slide()
    if current_input_vector != Vector2.ZERO:
        print("[Server] Move " + name + " | Vel: " + str(velocity) + " | Dist: " + str(global_position.distance_to(old_pos)))
```

### 6.3 입력 확인
```gdscript
# Client
print("[Client] Sending Input: " + str(input_vector))

# Server
print("[Server] Received Input for " + name + " from PEER " + str(sender_id) + ": " + str(input_vec))
```

---

## 7. 현재 알려진 이슈

| 이슈 | 상태 | 추정 원인 |
|------|------|----------|
| Join Player 이동 불가 | 🔴 디버깅 중 | 서버 물리 적용 확인 필요 (`_apply_movement` 로그 분석) |

---

## 8. 참고 파일 목록

| 파일 | 역할 |
|------|------|
| `src/scripts/global/SteamManager.gd` | 네트워크 매니저 |
| `src/scripts/global/GameManager.gd` | 게임 상태 관리 |
| `src/scripts/player_controller.gd` | 플레이어 입력/이동 |
| `src/scripts/logic/multiplayer_test.gd` | 게임 씬 초기화 |
| `src/scripts/logic/base_weapon.gd` | 무기 베이스 클래스 |
| `src/scripts/logic/base_enemy.gd` | 적 베이스 클래스 |
| `src/scripts/logic/experience_gem.gd` | 경험치 젬 |
| `src/entities/player/Player.tscn` | 플레이어 씬 (Sync 설정 포함) |
| `src/scenes/MultiplayerTest.tscn` | 멀티플레이 게임 씬 |
| `src/scenes/Lobby.tscn` | 로비 씬 |

---

## 9. 체크리스트 (다른 프로젝트 적용 시)

- [ ] `project.godot`에 Autoload 등록 (SteamManager, GameManager 등)
- [ ] Input Map 설정 (`move_left`, `move_right`, `move_up`, `move_down`)
- [ ] `MultiplayerSpawner` 노드 배치 및 `spawn_path` 설정
- [ ] `MultiplayerSynchronizer` 노드에 동기화할 속성 등록
- [ ] 스폰되는 노드에 고유 이름 부여 로직 추가
- [ ] 씬 로딩 핸드셰이크 구현 (`notify_scene_loaded` 패턴)
- [ ] Steam 확장 유무에 따른 분기 처리 (`Engine.has_singleton("Steam")`)
