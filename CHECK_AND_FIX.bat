@echo off
chcp 65001 >nul
echo ========================================
echo בדיקה ותיקון - העלאת הקוד ל-GitHub
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

echo בודק מצב repository...
echo.

REM בדיקה אם יש repository
if not exist ".git" (
    echo יוצר repository חדש...
    git init
    echo Repository נוצר! ✓
    echo.
)

REM הגדרת Git (אם לא הוגדר)
echo בודק הגדרות Git...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo צריך להגדיר את Git (פעם אחת בלבד)
    set /p GIT_NAME="הזן את השם שלך (או לחץ Enter לשימוש ב-'Telegram Bot'): "
    if "%GIT_NAME%"=="" set GIT_NAME=Telegram Bot
    set /p GIT_EMAIL="הזן את האימייל שלך (או לחץ Enter לשימוש ב-'bot@example.com'): "
    if "%GIT_EMAIL%"=="" set GIT_EMAIL=bot@example.com
    git config --global user.name "%GIT_NAME%"
    git config --global user.email "%GIT_EMAIL%"
    echo הגדרות Git נשמרו! ✓
    echo   שם: %GIT_NAME%
    echo   אימייל: %GIT_EMAIL%
    echo.
) else (
    echo הגדרות Git כבר קיימות! ✓
    echo.
)

REM בדיקת קבצים
echo בודק קבצים בתיקייה...
dir /b *.py *.txt *.md *.bat 2>nul | find /v /c "" > temp_count.txt
set /p FILE_COUNT=<temp_count.txt
del temp_count.txt
echo נמצאו %FILE_COUNT% קבצים
echo.

REM בדיקת סטטוס
echo בודק סטטוס Git...
git status --short >nul 2>&1
if %errorlevel% == 0 (
    echo יש שינויים להוסיף!
    git status --short
) else (
    echo אין שינויים חדשים.
)
echo.

REM הוספת כל הקבצים (כולל קבצים שלא ב-.gitignore)
echo מוסיף כל הקבצים...
git add -A
if %errorlevel% neq 0 (
    echo שגיאה בהוספת קבצים!
    pause
    exit /b 1
)

REM בדיקה מה נוסף
echo.
echo קבצים שנוספו:
git status --short
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
if %errorlevel% neq 0 (
    echo.
    echo בדיקה אם יש כבר commits...
    git log --oneline -1 >nul 2>&1
    if %errorlevel% neq 0 (
        echo.
        echo ========================================
        echo שגיאה: לא הצלחתי ליצור commit!
        echo ========================================
        echo.
        echo אפשרויות:
        echo 1. אולי אין קבצים חדשים (כולם כבר ב-commit)
        echo 2. אולי יש בעיה עם Git
        echo.
        echo ננסה לראות מה המצב:
        echo.
        git status
        echo.
        echo אם יש קבצים ב-"Untracked files" - נסה להריץ:
        echo   git add .
        echo   git commit -m "Initial commit"
        echo.
        pause
        exit /b 1
    ) else (
        echo יש כבר commits, ממשיך...
        git log --oneline -1
    )
) else (
    echo Commit נוצר בהצלחה! ✓
    git log --oneline -1
)
echo.

REM בדיקת branch
echo בודק branch...
git branch >nul 2>&1
if %errorlevel% neq 0 (
    echo אין branch - יוצר main...
    git checkout -b main
) else (
    for /f "tokens=*" %%i in ('git branch') do (
        set BRANCH_LINE=%%i
        if "!BRANCH_LINE:~0,2!"=="* " (
            set CURRENT_BRANCH=!BRANCH_LINE:~2!
        )
    )
    
    if not defined CURRENT_BRANCH (
        for /f "tokens=*" %%i in ('git branch') do set CURRENT_BRANCH=%%i
    )
    
    echo Branch נוכחי: %CURRENT_BRANCH%
    
    if not "%CURRENT_BRANCH%"=="main" (
        echo משנה branch ל-main...
        git branch -M main
    )
)
echo.

REM חיבור ל-GitHub
echo מחבר ל-GitHub...
set "REPO_URL=https://github.com/amos74474-hue/telegram-bot.git"

git remote remove origin >nul 2>&1
git remote add origin "%REPO_URL%"
echo חובר ל-GitHub! ✓
echo.

REM העלאה
echo מעלה את הקוד ל-GitHub...
echo.
echo ⚠️ אם תתבקש להזין פרטים:
echo    Username: amos74474-hue
echo    Password: Token (לא סיסמה!)
echo.
git push -u origin main

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo SUCCESS - הקוד הועלה ל-GitHub!
    echo ========================================
    echo.
    echo Repository: https://github.com/amos74474-hue/telegram-bot
    echo.
    start https://github.com/amos74474-hue/telegram-bot
) else (
    echo.
    echo ========================================
    echo שגיאה בהעלאה
    echo ========================================
    echo.
    echo אם יש שגיאת authentication - צור Token:
    echo https://github.com/settings/tokens
    echo.
)

pause

