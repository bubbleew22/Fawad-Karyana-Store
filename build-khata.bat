@echo off
setlocal enabledelayedexpansion
title Karyana Khata - Auto Build

echo.
echo ================================================
echo   KARYANA KHATA - AUTO BUILD AND PUSH
echo ================================================
echo.

cd /d "%~dp0"

REM ===== Check Git =====
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git installed nahi hai!
    echo.
    echo Download karein: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)
echo [1/6] Git mil gaya
echo.

REM ===== Check Git repo =====
if not exist ".git" (
    echo [2/6] Git repo nahi hai - init kar rahe hain...
    git init
    git branch -M main
    git remote add origin https://github.com/bubbleew22/Kashmir-Stoppage-App.git
    echo.
) else (
    echo [2/6] Git repo mil gaya
)
echo.

REM ===== Add all files =====
echo [3/6] Files add kar rahe hain...
git add .
echo       Done
echo.

REM ===== Commit =====
echo [4/6] Commit kar rahe hain...
set /p MSG="Commit message (Enter = auto): "
if "%MSG%"=="" set MSG=Update %DATE% %TIME%
git commit -m "%MSG%"
echo.

REM ===== Push =====
echo [5/6] GitHub par push kar rahe hain...
git push -u origin main
if %errorlevel% neq 0 (
    echo.
    echo [WARN] Push fail hua - dobara try kar rahe hain...
    git push -u origin main --force
)
echo.

echo [6/6] DONE!
echo.
echo ================================================
echo   APK BUILD HO RAHA HAI GITHUB PAR
echo ================================================
echo.
echo   GitHub Actions khul raha hai browser mein...
echo   https://github.com/bubbleew22/Kashmir-Stoppage-App/actions
echo.
echo   2-3 minute baad APK ready hogi.
echo   Artifacts section se download karein.
echo.
echo ================================================
echo.

timeout /t 3 >nul
start https://github.com/bubbleew22/Kashmir-Stoppage-App/actions

pause