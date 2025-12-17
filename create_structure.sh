#!/bin/bash

echo "🚀 Criando estrutura Flutter"

# ===== ASSETS =====
mkdir -p assets

# ===== LIB =====
mkdir -p lib/app

# Main fora do app
touch lib/main.dart

# App
touch lib/app/app.dart
touch lib/app/locator_config.dart

# Config
mkdir -p lib/app/config/routes

# Theme
mkdir -p lib/app/theme

# Core
mkdir -p lib/app/core/{api,storage,utils}

# Features
mkdir -p lib/app/features/auth/{repositories,view,view_model}
touch lib/app/features/auth/auth_module.dart
mkdir -p lib/app/features/splash

# Models
mkdir -p lib/app/model
touch lib/app/model/respond_http_model.dart
touch lib/app/model/session_model.dart

# Shared
mkdir -p lib/app/shared/{template,views,widgets}

echo ""
echo "📂 Estrutura criada:"
echo ""
cat << 'EOF'
lib/
├── main.dart
└── app/
    ├── app.dart
    ├── locator_config.dart
    ├── config/
    │   └── routes/
    ├── theme/
    ├── core/
    │   ├── api/
    │   ├── storage/
    │   └── utils/
    ├── features/
    │   ├── auth/
    │   │   ├── repositories/
    │   │   ├── view/
    │   │   ├── view_model/
    │   │   └── auth_module.dart
    │   └── splash/
    ├── model/
    │   ├── respond_http_model.dart
    │   └── session_model.dart
    └── shared/
        ├── template/
        ├── views/
        └── widgets/
EOF

echo ""
echo "✅ Tudo pronto!"

