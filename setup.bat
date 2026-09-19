@echo off
setlocal enabledelayedexpansion
title Karyana Khata - Setup

echo.
echo ================================================
echo   KARYANA KHATA - AUTO SETUP
echo ================================================
echo.

cd /d "%~dp0"
echo [1/6] Folder: %CD%
echo.

REM ===== 1. Create folders =====
echo [2/6] Folders bana rahe hain...
if not exist "www" mkdir "www"
if not exist "www\khata" mkdir "www\khata"
if not exist ".github" mkdir ".github"
if not exist ".github\workflows" mkdir ".github\workflows"

REM Move index.html to www\khata if it exists in root
if exist "index.html" (
    if not exist "www\khata\index.html" (
        echo       index.html ko www\khata mein move kar rahe hain...
        move "index.html" "www\khata\index.html" >nul
    )
)

echo       Done!
echo.

REM ===== 2. package.json =====
echo [3/6] package.json bana rahe hain...
(
echo {
echo   "name": "fawad-karyana-store",
echo   "version": "1.0.0",
echo   "description": "Fawad Karyana Store - Digital Khata",
echo   "author": "Yasir Khan",
echo   "license": "MIT",
echo   "dependencies": {
echo     "@capacitor/android": "^6.0.0",
echo     "@capacitor/cli": "^6.0.0",
echo     "@capacitor/core": "^6.0.0"
echo   }
echo }
) > "package.json"
echo       Done!
echo.

REM ===== 3. khata.capacitor.config.json =====
echo [4/6] khata.capacitor.config.json bana rahe hain...
(
echo {
echo   "appId": "com.fawad.karyana",
echo   "appName": "Fawad Karyana Store",
echo   "webDir": "www/khata",
echo   "server": {
echo     "androidScheme": "https"
echo   }
echo }
) > "khata.capacitor.config.json"
echo       Done!
echo.

REM ===== 4. GitHub Actions workflow =====
echo [5/6] GitHub Actions workflow bana rahe hain...
(
echo name: Build Fawad Karyana APK
echo.
echo on:
echo   push:
echo     paths:
echo       - 'www/khata/**'
echo       - 'khata.capacitor.config.json'
echo       - 'package.json'
echo       - '.github/workflows/khata.yml'
echo   workflow_dispatch:
echo.
echo jobs:
echo   build:
echo     runs-on: ubuntu-latest
echo     steps:
echo       - name: Checkout
echo         uses: actions/checkout@v4
echo.
echo       - name: Setup Node
echo         uses: actions/setup-node@v4
echo         with:
echo           node-version: '20'
echo.
echo       - name: Setup Java
echo         uses: actions/setup-java@v4
echo         with:
echo           distribution: 'temurin'
echo           java-version: '17'
echo.
echo       - name: Install dependencies
echo         run: npm install
echo.
echo       - name: Capacitor init
echo         run: npx cap init "Fawad Karyana Store" "com.fawad.karyana" --web-dir=www/khata
echo.
echo       - name: Copy capacitor config
echo         run: cp khata.capacitor.config.json capacitor.config.json
echo.
echo       - name: Add Android platform
echo         run: npx cap add android
echo.
echo       - name: Sync
echo         run: npx cap sync android
echo.
echo       - name: Build APK
echo         run: |
echo           cd android
echo           chmod +x gradlew
echo           ./gradlew assembleDebug
echo.
echo       - name: Upload APK
echo         uses: actions/upload-artifact@v4
echo         with:
echo           name: fawad-karyana-apk
echo           path: android/app/build/outputs/apk/debug/app-debug.apk
) > ".github\workflows\khata.yml"
echo       Done!
echo.

REM ===== 5. .gitignore =====
echo [6/6] .gitignore bana rahe hain...
(
echo node_modules/
echo android/
echo .gradle/
echo *.log
echo .DS_Store
echo Thumbs.db
echo build/
echo dist/
) > ".gitignore"
echo       Done!
echo.

echo ================================================
echo   SETUP COMPLETE! ✅
echo ================================================
echo.
echo Ab aap ke folder mein yeh files hain:
echo.
dir /b
echo.
echo.
echo ================================================
echo   NEXT STEPS:
echo ================================================
echo.
echo   1. Agli baar "build-khata.bat" chalayein
echo      (GitHub par push karne ke liye)
echo.
echo   2. Agar Git setup nahi hai to pehle yeh karein:
echo      git init
echo      git remote add origin https://github.com/bubbleew22/Kashmir-Stoppage-App.git
echo.
echo ================================================
echo.

pause