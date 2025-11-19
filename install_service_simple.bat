@echo off
REM סקריפט פשוט להתקנת שירות עם NSSM
REM הרץ כמנהל מערכת!

chcp 65001 >nul
cd /d "%~dp0"

echo מתקין את הבוט כשירות Windows...
echo.

REM בדיקה אם NSSM קיים
where nssm >nul 2>&1
if %errorlevel% neq 0 (
    echo שגיאה: NSSM לא נמצא!
    echo.
    echo הורד NSSM מ: https://nssm.cc/download
    echo חלץ את nssm.exe והעתק אותו לתיקייה זו
    echo או הוסף אותו לנתיב המערכת
    pause
    exit /b 1
)

REM מציאת Python
for /f "tokens=*" %%i in ('where python') do set PYTHON_PATH=%%i
if not defined PYTHON_PATH (
    echo שגיאה: Python לא נמצא!
    echo ודא ש-Python מותקן וזמין בנתיב
    pause
    exit /b 1
)

echo נמצא Python: %PYTHON_PATH%
echo.

REM הסרת שירות קיים
echo בודק שירות קיים...
nssm stop TelegramBot >nul 2>&1
nssm remove TelegramBot confirm >nul 2>&1

REM יצירת שירות חדש
echo יוצר שירות חדש...
nssm install TelegramBot "%PYTHON_PATH%" "%~dp0bot.py"
nssm set TelegramBot AppDirectory "%~dp0"
nssm set TelegramBot DisplayName "Telegram Bot"
nssm set TelegramBot Description "בוט Telegram - רץ אוטומטית ברקע"
nssm set TelegramBot Start SERVICE_AUTO_START
nssm set TelegramBot AppStdout "%~dp0bot_service.log"
nssm set TelegramBot AppStderr "%~dp0bot_service_error.log"

echo.
echo השירות נוצר בהצלחה!
echo.
echo פקודות שימושיות:
echo   nssm start TelegramBot    - התחל שירות
echo   nssm stop TelegramBot     - עצור שירות
echo   nssm restart TelegramBot  - הפעל מחדש
echo   nssm status TelegramBot   - סטטוס
echo   nssm remove TelegramBot confirm - הסר שירות
echo.

set /p START="האם להתחיל את השירות עכשיו? (Y/N): "
if /i "%START%"=="Y" (
    nssm start TelegramBot
    echo השירות התחיל!
    nssm status TelegramBot
)

pause

