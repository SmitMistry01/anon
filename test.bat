@echo off

:: Wait for the website to be up
timeout /t 10 /nobreak >nul

:: Check if the website is accessible
for /f "delims=" %%r in ('curl -s -o nul -w "%%{http_code}" http://localhost:8080') do (
    set "response=%%r"
)

if "%response%"=="200" (
    echo Website is accessible
    exit /b 0
) else (
    echo Website is not accessible. Response code: %response%
    exit /b 1
)