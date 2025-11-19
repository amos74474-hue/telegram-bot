@echo off
chcp 65001 >nul
echo ========================================
echo הגדרת הבוט כשירות Windows
echo ========================================
echo.
echo פתרון זה דורש NSSM (Non-Sucking Service Manager)
echo.

REM בדיקה אם NSSM קיים
where nssm >nul 2>&1
if %errorlevel% neq 0 (
    echo NSSM לא נמצא במערכת.
    echo.
    echo הוראות התקנה:
    echo 1. הורד NSSM מ-https://nssm.cc/download
    echo 2. חלץ את הקובץ nssm.exe
    echo 3. העתק את nssm.exe לתיקיית System32 או הוסף לנתיב
    echo 4. הרץ שוב את הסקריפט הזה
    echo.
    pause
    exit /b 1
)

REM קבלת נתיבים
set "SCRIPT_DIR=%~dp0"
set "PYTHON_EXE=python"
set "BOT_SCRIPT=%SCRIPT_DIR%bot.py"

REM מציאת Python
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo Python לא נמצא בנתיב!
    echo אנא הזן את הנתיב המלא ל-Python:
    set /p PYTHON_EXE="נתיב ל-Python (לדוגמה: C:\Python\python.exe): "
)

echo.
echo נתיבים:
echo   Python: %PYTHON_EXE%
echo   סקריפט: %BOT_SCRIPT%
echo.

REM הסרת שירות קיים אם קיים
echo בודק אם יש שירות קיים...
nssm stop TelegramBot >nul 2>&1
nssm remove TelegramBot confirm >nul 2>&1

REM יצירת שירות חדש
echo יוצר שירות חדש...
nssm install TelegramBot "%PYTHON_EXE%" "%BOT_SCRIPT%"

if %errorlevel% == 0 (
    REM הגדרת השירות
    echo מגדיר את השירות...
    nssm set TelegramBot AppDirectory "%SCRIPT_DIR%"
    nssm set TelegramBot DisplayName "Telegram Bot Service"
    nssm set TelegramBot Description "שירות להפעלת בוט Telegram אוטומטית"
    nssm set TelegramBot Start SERVICE_AUTO_START
    nssm set TelegramBot AppStdout "%SCRIPT_DIR%bot_service.log"
    nssm set TelegramBot AppStderr "%SCRIPT_DIR%bot_service_error.log"
    
    echo.
    echo ========================================
    echo SUCCESS - השירות נוצר בהצלחה!
    echo ========================================
    echo.
    echo כדי להתחיל את השירות:
    echo   nssm start TelegramBot
    echo.
    echo כדי לעצור את השירות:
    echo   nssm stop TelegramBot
    echo.
    echo כדי להסיר את השירות:
    echo   nssm remove TelegramBot confirm
    echo.
    echo השירות יתחיל אוטומטית בכל התחלה של Windows.
    echo.
    
    REM התחלת השירות
    set /p START_NOW="האם להתחיל את השירות עכשיו? (Y/N): "
    if /i "%START_NOW%"=="Y" (
        nssm start TelegramBot
        echo השירות התחיל!
    )
) else (
    echo.
    echo ========================================
    echo ERROR - לא הצלחתי ליצור שירות
    echo ========================================
    echo.
    echo ודא שהרצת את זה כמנהל מערכת (Run as Administrator)
    echo.
)

pause

