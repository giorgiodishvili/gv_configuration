@echo off
setlocal

REM Define the repositories and their directories
set REPO1_URL=https://github.com/giorgiodishvili/order_management
set REPO2_URL=https://github.com/giorgiodishvili/user_management
set REPO1_DIR=..\order_management
set REPO2_DIR=..\user_management

REM Function to clone or pull a repository
:UPDATE_REPO
SET CURRENT_DIR=%cd%
set REPO_URL=%1
set REPO_DIR=%2

IF EXIST "%REPO_DIR%" (
    echo Directory %REPO_DIR% exists. Pulling latest changes...
    pushd "%REPO_DIR%"
    git pull
    popd
) ELSE (
    echo Directory %REPO_DIR% does not exist. Cloning repository...
    pushd ..
    git clone %REPO_URL%
    popd
)
goto :EOF

pushd "%CURRENT_DIR%"

REM Clone or pull repositories
call :UPDATE_REPO %REPO1_URL% %REPO1_DIR%
echo printing %cd% pwd
call :UPDATE_REPO %REPO2_URL% %REPO2_DIR%

REM Run docker-compose build --parallel
echo "Running docker-compose build --parallel..."
docker-compose build --parallel

REM Run docker-compose up
echo Running docker-compose up...
docker-compose up
