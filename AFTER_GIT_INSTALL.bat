@echo off
chcp 65001 >nul
echo ========================================
echo העלאת הקוד ל-GitHub
echo ========================================
echo.
echo Repository: https://github.com/amos74474-hue/telegram-bot.git
echo.

REM בדיקה אם Git מותקן
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ========================================
    echo שגיאה: Git עדיין לא מותקן!
    echo ========================================
    echo.
    echo אנא:
    echo 1. התקן Git מ-https://git-scm.com/download/win
    echo 2. הפעל מחדש את PowerShell
    echo 3. הרץ שוב את הסקריפט הזה
    echo.
    pause
    exit /b 1
)

echo Git מותקן! ✓
echo.

REM מעבר לתיקייה
cd /d "%~dp0"

REM הוספת קבצים
echo מוסיף קבצים...
git add .
if %errorlevel% neq 0 (
    echo שגיאה בהוספת קבצים!
    pause
    exit /b 1
)
echo קבצים נוספו! ✓
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
if %errorlevel% == 0 (
    echo Commit נוצר! ✓
) else (
    echo.
    echo בדיקה אם יש כבר commits...
    git log --oneline -1 >nul 2>&1
    if %errorlevel% == 0 (
        echo יש כבר commits, ממשיך...
    ) else (
        echo שגיאה: לא הצלחתי ליצור commit!
        echo ודא שיש קבצים להוסיף.
        pause
        exit /b 1
    )
)
echo.

REM חיבור ל-GitHub
echo מחבר ל-GitHub...
set "REPO_URL=https://github.com/amos74474-hue/telegram-bot.git"

REM הסרת remote קיים אם קיים
git remote remove origin >nul 2>&1

REM הוספת remote חדש
git remote add origin "%REPO_URL%"
echo חובר ל-GitHub! ✓
echo.

REM בדיקה איזה branch קיים
echo בודק branch קיים...
git branch --show-current >nul 2>&1
if %errorlevel% == 0 (
    for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
) else (
    REM אם אין branch, ננסה לראות מה יש
    for /f "tokens=*" %%i in ('git branch') do set CURRENT_BRANCH=%%i
    set CURRENT_BRANCH=%CURRENT_BRANCH:~2%
)

REM אם אין branch בשם main, נשנה את השם
if not "%CURRENT_BRANCH%"=="main" (
    echo משנה branch ל-main...
    git branch -M main 2>nul
    if %errorlevel% neq 0 (
        echo יצירת branch main...
        git checkout -b main 2>nul
    )
) else (
    echo Branch main כבר קיים! ✓
)
echo.

REM העלאה
echo מעלה את הקוד ל-GitHub...
echo (אם תתבקש - הזן את שם המשתמש והסיסמה/Token שלך)
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
    echo 1. צור Token: https://github.com/settings/tokens
    echo 2. סמן "repo" (כל ההרשאות)
    echo 3. העתק את ה-Token
    echo 4. כשתעלה - השתמש ב-Token במקום סיסמה
    echo.
)

pause

