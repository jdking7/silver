import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  
  final AuthService _authService = AuthService();
  final DatabaseService _dbService = DatabaseService();

  bool _isLoading = false;
  String? _errorMessage;
  
  // 추가 정보
  int _selectedBirthYear = 1960;
  String _selectedGender = 'male';
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('약관에 동의해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Firebase Auth 계정 생성
      final user = await _authService.signUpWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );

      if (user != null) {
        // 2. Firestore에 사용자 정보 저장
        final newUser = UserModel(
          uid: user.uid,
          email: user.email!,
          displayName: _nameController.text.trim(),
          birthYear: _selectedBirthYear,
          gender: _selectedGender,
          role: 'user',
          createdAt: DateTime.now(),
        );

        await _dbService.createUser(newUser);

        if (mounted) {
          // 성공 팝업
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('환영합니다!'),
              content: const Text('회원가입이 완료되었습니다.\n로그인 화면으로 이동합니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    Navigator.of(context).pop(); // 로그인 화면으로 돌아가기
                  },
                  child: const Text('확인', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 생년월일 목록 생성 (1930 ~ 1980)
    final years = List.generate(51, (index) => 1930 + index);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. 기본 정보 섹션
                const Text(
                  '기본 정보',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // 이름 입력
                _buildTextField(
                  controller: _nameController,
                  label: '이름 (별명)',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return '이름을 입력해주세요';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 이메일 입력
                _buildTextField(
                  controller: _emailController,
                  label: '이메일',
                  icon: Icons.email_outlined,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return '이메일을 입력해주세요';
                    if (!value.contains('@')) return '올바른 이메일 형식이 아닙니다';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 비밀번호 입력
                _buildTextField(
                  controller: _passwordController,
                  label: '비밀번호 (6자 이상)',
                  icon: Icons.lock_outline,
                  isObscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return '비밀번호를 입력해주세요';
                    if (value.length < 6) return '6자 이상 입력해주세요';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 비밀번호 확인
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: '비밀번호 확인',
                  icon: Icons.verified_user_outlined,
                  isObscure: true,
                  validator: (value) {
                    if (value != _passwordController.text) return '비밀번호가 일치하지 않습니다';
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // 2. 추가 정보 섹션
                const Text(
                  '맞춤 정보',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '어르신 맞춤 서비스를 위해 필요한 정보입니다.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // 생년월일 & 성별
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<int>(
                        value: _selectedBirthYear,
                        decoration: InputDecoration(
                          labelText: '출생년도',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        items: years.map((year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text('$year년', style: const TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedBirthYear = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGender,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(value: 'male', child: Text('남성', style: TextStyle(fontSize: 18))),
                              DropdownMenuItem(value: 'female', child: Text('여성', style: TextStyle(fontSize: 18))),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 3. 약관 동의
                CheckboxListTile(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                  },
                  title: const Text(
                    '서비스 이용약관 및 개인정보 처리방침에 동의합니다. (필수)',
                    style: TextStyle(fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),

                // 에러 메시지
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // 가입하기 버튼
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('가입하기', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: inputType,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: validator,
    );
  }
}
