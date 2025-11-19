@echo off
chcp 65001 >nul
echo ========================================
echo הגדרת הפעלה אוטומטית של הבוט
echo ========================================
echo.

REM קבלת נתיב התיקייה הנוכחית
set "SCRIPT_DIR=%~dp0"
set "BAT_FILE=%SCRIPT_DIR%start_bot_auto.bat"

echo נתיב התיקייה: %SCRIPT_DIR%
echo קובץ הפעלה: %BAT_FILE%
echo.

REM יצירת Task Scheduler
echo יוצר Task Scheduler...
schtasks /create /tn "TelegramBotAutoStart" /tr "\"%BAT_FILE%\"" /sc onlogon /rl highest /f

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo SUCCESS - Task Scheduler נוצר בהצלחה!
    echo ========================================
    echo.
    echo הבוט יתחיל אוטומטית בכל התחלה של Windows.
    echo.
    echo כדי לבדוק שהמשימה נוצרה:
    echo   schtasks /query /tn "TelegramBotAutoStart"
    echo.
    echo כדי להסיר את המשימה:
    echo   schtasks /delete /tn "TelegramBotAutoStart" /f
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR - לא הצלחתי ליצור Task Scheduler
    echo ========================================
    echo.
    echo נסה להריץ את זה כמנהל מערכת (Run as Administrator)
    echo.
    echo לחלופין, עקוב אחר ההוראות ב-README_STARTUP.md
    echo.
)

pause

