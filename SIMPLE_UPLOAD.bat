@echo off
chcp 65001 >nul
echo ========================================
echo העלאת הקוד ל-GitHub
echo ========================================
echo.

REM בדיקה אם Git מותקן
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo שגיאה: Git לא מותקן!
    pause
    exit /b 1
)

cd /d "%~dp0"

REM בדיקה אם יש repository
if not exist ".git" (
    echo יוצר repository חדש...
    git init
)

REM הגדרת Git
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo מגדיר Git...
    git config --global user.name "Telegram Bot"
    git config --global user.email "bot@example.com"
)

REM הוספת קבצים
echo מוסיף קבצים...
git add -A

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
if %errorlevel% neq 0 (
    echo שגיאה ביצירת commit!
    pause
    exit /b 1
)

REM branch
git branch -M main 2>nul

REM חיבור ל-GitHub
echo מחבר ל-GitHub...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/amos74474-hue/telegram-bot.git

REM העלאה
echo מעלה את הקוד ל-GitHub...
echo.
echo אם תתבקש להזין פרטים:
echo   Username: amos74474-hue
echo   Password: Token (לא סיסמה!)
echo.
git push -u origin main

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo SUCCESS - הקוד הועלה ל-GitHub!
    echo ========================================
    echo.
    start https://github.com/amos74474-hue/telegram-bot
) else (
    echo.
    echo ========================================
    echo שגיאה בהעלאה
    echo ========================================
    echo.
    echo צור Token: https://github.com/settings/tokens
    echo.
)

pause

