@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo מתחיל את הבוט...
python bot.py
if errorlevel 1 (
    echo הבוט נעצר עם שגיאה. מנסה להפעיל מחדש בעוד 10 שניות...
    timeout /t 10 /nobreak >nul
    goto :eof
)
pause

