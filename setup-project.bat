@echo off
setlocal
title Setup Project
cd /d "%~dp0"

echo.
echo ============================================
echo   Setting up project (fresh laptop)
echo ============================================
echo.

:: --- Quick check: Node and npm ---
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Node.js is not installed. Run verify-requirements.bat first.
    echo Install from: https://nodejs.org/
    pause
    exit /b 1
)
where npm >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] npm is not installed. Run verify-requirements.bat first.
    pause
    exit /b 1
)

:: --- Install dependencies ---
echo [1/2] Installing npm dependencies...
echo.
call npm install
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] npm install failed.
    pause
    exit /b 1
)
echo.
echo [OK] Dependencies installed.
echo.

:: --- Check .env ---
echo [2/2] Checking .env file...
if not exist ".env" (
    echo    .env not found. Creating from template...
    (
        echo MONGO_URI=mongodb://localhost:27017/contact-manager
        echo JWT_SECRET=your_jwt_secret_key_here_change_this_in_production
        echo PORT=5000
        echo NODE_ENV=development
    ) > .env
    echo    [OK] .env created. Edit it if you use MongoDB Atlas or need different settings.
) else (
    echo    [OK] .env already exists.
)
echo.

echo ============================================
echo   Setup complete.
echo ============================================
echo.
echo Next steps:
echo   1. If using local MongoDB, make sure MongoDB is running.
echo   2. If using MongoDB Atlas, set MONGO_URI in .env to your Atlas connection string.
echo   3. Start the server: npm start
echo.
pause
