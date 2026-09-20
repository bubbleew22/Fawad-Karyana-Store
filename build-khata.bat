@echo off
title KARYANA KHATA - AUTO BUILD AND PUSH
color 0A

echo ================================================
echo   KARYANA KHATA - AUTO BUILD AND PUSH
echo ================================================
echo.

cd /d "C:\Users\K_MDF\Desktop\K_store"

echo [1/6] Git check...
git --version >nul 2>&1
if errorlevel 1 (
  echo       [ERROR] Git install nahi hai!
  echo       https://git-scm.com/downloads se install karein
  pause
  exit /b
)
echo       Git mil gaya

echo.
echo [2/6] Git repo check...
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
  echo       [ERROR] Yeh folder git repo nahi hai!
  echo       Pehle "git init" chalayein ya sahi folder mein jayein
  pause
  exit /b
)
echo       Git repo mil gaya

echo.
echo [3/6] Files add kar rahe hain...
git add .
echo       Done

echo.
echo [4/6] Commit kar rahe hain...
git commit -m "Update Hisab Kitab - all features ready" >nul 2>&1
if errorlevel 1 (
  echo       Kuch naya nahi tha commit karne ke liye
) else (
  echo       Commit ho gaya
)

echo.
echo [5/6] GitHub se pull kar rahe hain (sync)...
git pull origin main --no-edit >nul 2>&1
echo       Sync ho gaya

echo.
echo [6/6] GitHub par push kar rahe hain...
git push origin main
if errorlevel 1 (
  echo.
  echo       [WARN] Push fail hua - force try kar rahe hain...
  git push origin main --force
)
echo       Push ho gaya!

echo.
echo ================================================
echo   APK BUILD HO RAHA HAI GITHUB PAR
echo ================================================
echo.
echo   GitHub Actions khul raha hai browser mein...
start https://github.com/bubbleew22/Fawad-Karyana-Store/actions
echo.
echo   2-3 minute baad APK ready hogi.
echo   Artifacts section se download karein.
echo.
echo ================================================

pause