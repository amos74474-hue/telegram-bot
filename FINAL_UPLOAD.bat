@echo off
chcp 65001 >nul
echo ========================================
echo העלאת הקוד ל-GitHub - גרסה סופית
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
    echo.
)

REM הוספת כל הקבצים
echo מוסיף כל הקבצים...
git add -A
echo קבצים נוספו! ✓
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
if %errorlevel% neq 0 (
    echo שגיאה ביצירת commit!
    pause
    exit /b 1
)
echo Commit נוצר בהצלחה! ✓
echo.

REM בדיקת branch
echo בודק branch...
git branch >nul 2>&1
if %errorlevel% neq 0 (
    echo יוצר branch main...
    git checkout -b main
) else (
    git branch -M main >nul 2>&1
)
echo Branch main מוכן! ✓
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
    echo אם יש שגיאת authentication:
    echo 1. היכנס ל: https://github.com/settings/tokens
    echo 2. לחץ "Generate new token" ^> "Generate new token (classic)"
    echo 3. שם: telegram-bot
    echo 4. סמן: repo (כל ההרשאות)
    echo 5. לחץ "Generate token"
    echo 6. העתק את ה-Token
    echo 7. הרץ שוב את הסקריפט הזה
    echo 8. כשתעלה - השתמש ב-Token במקום סיסמה
    echo.
)

pause

