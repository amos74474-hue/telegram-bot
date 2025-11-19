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
    echo שגיאה: Git לא מותקן!
    echo ========================================
    echo.
    echo שלב 1: התקן Git
    echo.
    echo 1. פתח: https://git-scm.com/download/win
    echo 2. לחץ "Download for Windows"
    echo 3. התקן (Next בכל השלבים)
    echo 4. הפעל מחדש את PowerShell
    echo 5. הרץ שוב את הסקריפט הזה
    echo.
    echo או לחץ כאן להורדה:
    start https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo Git מותקן! ✓
echo.

REM בדיקה אם כבר יש repository
if exist ".git" (
    echo נמצא repository מקומי קיים.
    echo.
) else (
    echo יוצר repository מקומי...
    git init
    if %errorlevel% == 0 (
        echo Repository נוצר בהצלחה! ✓
    ) else (
        echo שגיאה ביצירת repository!
        pause
        exit /b 1
    )
    echo.
)

REM הגדרת Git (אם לא הוגדר)
echo בודק הגדרות Git...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo צריך להגדיר את Git (פעם אחת בלבד)
    set /p GIT_NAME="הזן את השם שלך: "
    set /p GIT_EMAIL="הזן את האימייל שלך: "
    git config --global user.name "%GIT_NAME%"
    git config --global user.email "%GIT_EMAIL%"
    echo הגדרות Git נשמרו! ✓
    echo.
)

REM הוספת קבצים
echo מוסיף קבצים ל-repository...
git add .
if %errorlevel% == 0 (
    echo קבצים נוספו! ✓
) else (
    echo שגיאה בהוספת קבצים!
    pause
    exit /b 1
)
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot" >nul 2>&1
if %errorlevel% == 0 (
    echo Commit נוצר בהצלחה! ✓
) else (
    REM אולי אין שינויים או כבר יש commit
    git status --short >nul 2>&1
    if %errorlevel% == 0 (
        echo אין שינויים חדשים.
    ) else (
        echo Commit כבר קיים או אין שינויים.
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
if %errorlevel% == 0 (
    echo חובר ל-GitHub! ✓
    echo.
    
    REM שינוי שם branch ל-main
    git branch -M main >nul 2>&1
    echo.
    
    echo מעלה את הקוד ל-GitHub...
    echo (זה עלול לקחת כמה שניות...)
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
        echo עכשיו תוכל:
        echo 1. לפתוח את ה-repository ב-GitHub
        echo 2. להגדיר Railway או שירות אחר
        echo 3. קרא את QUICK_DEPLOY.md למדריך
        echo.
        start https://github.com/amos74474-hue/telegram-bot
    ) else (
        echo.
        echo ========================================
        echo שגיאה בהעלאה
        echo ========================================
        echo.
        echo אפשרויות:
        echo 1. ודא שיצרת repository ב-GitHub
        echo 2. אם יש שגיאת authentication:
        echo    - GitHub דורש Token אישי
        echo    - צור Token: GitHub ^> Settings ^> Developer settings ^> Personal access tokens
        echo    - בחר "Generate new token (classic)"
        echo    - סמן "repo" (כל ההרשאות)
        echo    - העתק את ה-Token
        echo    - השתמש ב-Token במקום סיסמה כשתעלה
        echo.
        echo או נסה להריץ ידנית:
        echo   git push -u origin main
        echo.
    )
) else (
    echo שגיאה בחיבור ל-GitHub!
    echo ודא שה-URL נכון.
)

pause

