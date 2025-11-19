@echo off
chcp 65001 >nul
echo ========================================
echo תיקון והעלאת הקוד ל-GitHub
echo ========================================
echo.

REM בדיקה אם Git מותקן
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo שגיאה: Git לא מותקן!
    echo התקן Git מ-https://git-scm.com/download/win
    pause
    exit /b 1
)

REM מעבר לתיקייה
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

REM הוספת כל הקבצים
echo מוסיף קבצים...
git add .
echo קבצים נוספו! ✓
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
if %errorlevel% neq 0 (
    echo.
    echo בדיקה אם יש כבר commits...
    git log --oneline -1 >nul 2>&1
    if %errorlevel% neq 0 (
        echo שגיאה: לא הצלחתי ליצור commit!
        echo ודא שיש קבצים להוסיף.
        pause
        exit /b 1
    ) else (
        echo יש כבר commits, ממשיך...
    )
) else (
    echo Commit נוצר! ✓
)
echo.

REM בדיקת branch קיים
echo בודק branch...
for /f "tokens=*" %%i in ('git branch 2^>nul') do (
    set BRANCH_LINE=%%i
    if "!BRANCH_LINE:~0,2!"=="* " (
        set CURRENT_BRANCH=!BRANCH_LINE:~2!
    )
)

if not defined CURRENT_BRANCH (
    echo אין branch - יוצר main...
    git checkout -b main
    set CURRENT_BRANCH=main
)

echo Branch נוכחי: %CURRENT_BRANCH%
echo.

REM אם לא main, נשנה
if not "%CURRENT_BRANCH%"=="main" (
    echo משנה branch ל-main...
    git branch -M main
    echo Branch שונה ל-main! ✓
    echo.
)

REM חיבור ל-GitHub
echo מחבר ל-GitHub...
set "REPO_URL=https://github.com/amos74474-hue/telegram-bot.git"

REM הסרת remote קיים אם קיים
git remote remove origin >nul 2>&1

REM הוספת remote חדש
git remote add origin "%REPO_URL%"
echo חובר ל-GitHub! ✓
echo.

REM העלאה
echo מעלה את הקוד ל-GitHub...
echo.
echo ⚠️ אם תתבקש להזין פרטים:
echo    Username: השם שלך ב-GitHub
echo    Password: Token (לא סיסמה! - ראה למטה איך ליצור)
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
    echo.
    echo 1. היכנס ל: https://github.com/settings/tokens
    echo 2. לחץ "Generate new token" ^> "Generate new token (classic)"
    echo 3. שם: telegram-bot
    echo 4. סמן: repo (כל ההרשאות)
    echo 5. לחץ "Generate token"
    echo 6. העתק את ה-Token
    echo 7. הרץ שוב את הסקריפט הזה
    echo 8. כשתעלה - השתמש ב-Token במקום סיסמה
    echo.
    echo או נסה להריץ ידנית:
    echo   git push -u origin main
    echo.
)

pause

