@echo off
curl -s -o nul -w "%%{http_code}" http://localhost:80
if %errorlevel% neq 0 (
    echo Website test failed
    exit /b 1
)
exit /b 0