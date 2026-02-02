---
trigger: always_on
---

# Google Antigravity Node.js Standards (Deep Dive)

> **Purpose**: Technical specification for Node.js development in Antigravity ecosystem.  
> **Ref Rule**: [core-nodejs-global.md](core-nodejs-global.md)

## 📋 Table of Contents
1. [Workspace Metadata & Scaffolding](#1-workspace-metadata--scaffolding)
2. [TypeScript Configuration](#2-typescript-configuration)
3. [Code Style & Linting](#3-code-style--linting)
4. [Error Handling Patterns](#4-error-handling-patterns)
5. [Security Best Practices](#5-security-best-practices)
6. [Tech Stack Recommendations](#6-tech-stack-recommendations)

---

## 1. Workspace Metadata & Scaffolding

This section defines the **Project Specific** standards. Modify this checklist for each new project.

### 1.1 Project Metadata
- **Type**: (e.g., Backend API, Frontend App, Fullstack)
- **Package Manager**: `pnpm` (Recommended) or `npm`. (Lock file mandatory)
- **Node Engine**: `>= 18.x` (LTS)

### 1.2 Folder Structure Standard
Follow this structure unless the framework (NestJS, Next.js) dictates otherwise.

```
/src
  ├── config/        # Environment config & loaders
  ├── api/           # Controllers, Routers
  ├── services/      # Business Logic
  ├── models/        # DB Models, DTOs
  ├── utils/         # Shared Utilities
  └── app.ts         # Entry Point
/tests               # Test Code (Unit, E2E)
/documents           # Documentation (ref: simple-documentation.md)
```

### 1.3 Environment Management
- **Development**: `.env.development` (Local)
- **Production**: Environment Variables Injection (No file committed)
- **Git Ignore**: `.env`, `node_modules`, `dist`, `coverage` MUST be ignored.

---

## 2. TypeScript Configuration

**Standard `tsconfig.json`**:
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "lib": ["ES2022"],
    "strict": true,               // MUST BE TRUE
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "resolveJsonModule": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.spec.ts"]
}
```

---

## 3. Code Style & Linting

**Standard `.eslintrc.js`**:
```javascript
module.exports = {
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint/eslint-plugin'],
  extends: [
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended', // Prettier last!
  ],
  root: true,
  env: {
    node: true,
    jest: true,
  },
  rules: {
    '@typescript-eslint/interface-name-prefix': 'off',
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-explicit-any': 'warn', // Warn only, but avoid
  },
};
```

---

## 4. Error Handling Patterns

### Bad Practice ❌
```typescript
try {
  await database.save(data);
} catch (e) {
  console.log(e); // Swallowing context
}
```

### Best Practice ✅
Use a custom Error class and centralized middleware.

```typescript
// 1. Custom Error
export class AppError extends Error {
  constructor(public statusCode: number, public message: string) {
    super(message);
  }
}

// 2. Service Layer
if (!user) {
  throw new AppError(404, 'User not found'); // Clean throw
}

// 3. Central Middleware
app.use((err, req, res, next) => {
  const status = err.statusCode || 500;
  // Log strictly
  logger.error({ 
    message: err.message, 
    stack: err.stack, 
    path: req.path 
  });
  res.status(status).json({ success: false, error: err.message });
});
```

---

## 5. Security Best Practices

### Input Validation (Zod Example)
Never trust user input. Validate at the controller level.

```typescript
import { z } from 'zod';

const UserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  role: z.enum(['ADMIN', 'USER']).optional(),
});

// Middleware
const validate = (schema) => (req, res, next) => {
  try {
    schema.parse(req.body);
    next();
  } catch (e) {
    next(new AppError(400, 'Validation Failed'));
  }
};
```

---

## 6. Tech Stack Recommendations

| Category | Recommendation | Notes |
| :--- | :--- | :--- |
| **Framework** | Express (Simple) or NestJS (Enterprise) | Based on scale |
| **Database** | PostgreSQL / MySQL | Main RDBMS |
| **ORM** | Prisma or TypeORM | Type-safe preferred |
| **Test** | Jest or Vitest | Unit/Integration |
| **Validation** | Zod | Runtime validation |
| **Scripts** | `npm run start`, `dev`, `lint` | Standardize via package.json |
