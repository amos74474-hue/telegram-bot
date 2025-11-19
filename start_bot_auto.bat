@echo off
REM סקריפט להפעלת הבוט עם התחלה מחדש אוטומטית
chcp 65001 >nul
cd /d "%~dp0"

REM יצירת קובץ לוג
set "LOG_FILE=%~dp0bot_auto_start.log"
echo [%date% %time%] מתחיל סקריפט הפעלה אוטומטית >> "%LOG_FILE%"

:loop
echo [%date% %time%] מתחיל את הבוט... >> "%LOG_FILE%"
echo [%date% %time%] מתחיל את הבוט...
python bot.py >> "%LOG_FILE%" 2>&1
set EXIT_CODE=%errorlevel%

if %EXIT_CODE% == 0 (
    echo [%date% %time%] הבוט נעצר בצורה תקינה. מנסה להפעיל מחדש בעוד 5 שניות... >> "%LOG_FILE%"
    echo [%date% %time%] הבוט נעצר. מנסה להפעיל מחדש בעוד 5 שניות...
    timeout /t 5 /nobreak >nul
) else (
    echo [%date% %time%] הבוט נעצר עם שגיאה (קוד: %EXIT_CODE%). מנסה להפעיל מחדש בעוד 15 שניות... >> "%LOG_FILE%"
    echo [%date% %time%] הבוט נעצר עם שגיאה. מנסה להפעיל מחדש בעוד 15 שניות...
    timeout /t 15 /nobreak >nul
)
goto loop

