@echo off
setlocal EnableDelayedExpansion
title Verify Project Requirements
echo.
echo ============================================
echo   Verifying requirements for this project
echo ============================================
echo.

set "ALL_OK=1"

:: --- Check Node.js ---
echo [1/3] Checking Node.js (need v18 or newer)...
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo    [FAIL] Node.js is NOT installed.
    echo    Please install from: https://nodejs.org/
    echo.
    set "ALL_OK=0"
) else (
    for /f "tokens=*" %%v in ('node -v 2^>nul') do set NODE_VER=%%v
    echo    [OK] Node.js found: !NODE_VER!
    echo.
)

:: --- Check npm ---
echo [2/3] Checking npm...
where npm >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo    [FAIL] npm is NOT installed. It usually comes with Node.js.
    echo    Install Node.js from: https://nodejs.org/
    echo.
    set "ALL_OK=0"
) else (
    for /f "tokens=*" %%v in ('npm -v 2^>nul') do set NPM_VER=%%v
    echo    [OK] npm found: version !NPM_VER!
    echo.
)

:: --- Check MongoDB ---
echo [3/3] Checking MongoDB...
where mongod >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo    [WARN] MongoDB (mongod) not found in PATH.
    echo    Options:
    echo      - Install MongoDB locally: https://www.mongodb.com/try/download/community
    echo      - Or use MongoDB Atlas (cloud): https://www.mongodb.com/cloud/atlas
    echo      - If installed, add MongoDB bin folder to your PATH.
    echo.
    set "ALL_OK=0"
) else (
    for /f "tokens=*" %%v in ('mongod --version 2^>nul ^| findstr "db version"') do set MONGO_VER=%%v
    echo    [OK] MongoDB found: !MONGO_VER!
    echo.
)

:: --- Summary ---
echo ============================================
if "%ALL_OK%"=="1" (
    echo   All required tools are installed.
    echo   You can run setup-project.bat and then start the server.
) else (
    echo   Some requirements are missing. Please install them
    echo   as indicated above, then run this script again.
)
echo ============================================
echo.
pause
