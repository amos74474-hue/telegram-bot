@echo off
chcp 65001 >nul
echo ========================================
echo מדריך שלב אחר שלב - העלאה ל-GitHub
echo ========================================
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
    pause
    exit /b 1
)

echo Git מותקן! ✓
echo.

REM בדיקה אם כבר יש repository
if exist ".git" (
    echo נמצא repository קיים.
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
    echo אין שינויים חדשים או commit כבר קיים.
)
echo.

echo ========================================
echo שלב הבא: יצירת Repository ב-GitHub
echo ========================================
echo.
echo עכשיו תצטרך:
echo.
echo 1. פתח דפדפן והיכנס ל: https://github.com
echo 2. לחץ על הכפתור "+" בפינה הימנית העליונה
echo 3. בחר "New repository"
echo 4. שם: telegram-bot (או שם אחר)
echo 5. בחר Public או Private
echo 6. אל תסמן כלום! (אל תסמן README, .gitignore, license)
echo 7. לחץ "Create repository"
echo.
echo לאחר יצירת ה-repository, GitHub יציג לך הוראות.
echo העתק את ה-URL של ה-repository (זה יראה כך):
echo    https://github.com/YOUR_USERNAME/telegram-bot.git
echo.
echo לאחר מכן, חזור לכאן והמשך!
echo.

set /p HAS_REPO="האם כבר יצרת repository ב-GitHub? (Y/N): "
if /i "%HAS_REPO%"=="Y" (
    echo.
    set /p REPO_URL="הזן את ה-URL של ה-repository (לדוגמה: https://github.com/username/telegram-bot.git): "
    if not "%REPO_URL%"=="" (
        echo.
        echo מחבר ל-GitHub...
        
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
                echo עכשיו תוכל:
                echo 1. לפתוח את ה-repository ב-GitHub
                echo 2. להגדיר Railway או שירות אחר
                echo 3. קרא את QUICK_DEPLOY.md למדריך
                echo.
            ) else (
                echo.
                echo ========================================
                echo שגיאה בהעלאה
                echo ========================================
                echo.
                echo אפשרויות:
                echo 1. ודא שה-URL נכון
                echo 2. ודא שיצרת repository ב-GitHub
                echo 3. אם יש שגיאת authentication:
                echo    - GitHub דורש Token אישי
                echo    - צור Token: GitHub ^> Settings ^> Developer settings
                echo    - השתמש ב-Token במקום סיסמה
                echo.
            )
        ) else (
            echo שגיאה בחיבור ל-GitHub!
            echo ודא שה-URL נכון.
        )
    ) else (
        echo לא הוזן URL. נסה שוב מאוחר יותר.
    )
) else (
    echo.
    echo ========================================
    echo הוראות להמשך
    echo ========================================
    echo.
    echo 1. פתח: https://github.com/new
    echo 2. שם: telegram-bot
    echo 3. בחר Public או Private
    echo 4. אל תסמן כלום!
    echo 5. לחץ "Create repository"
    echo 6. העתק את ה-URL
    echo 7. הרץ שוב את הסקריפט הזה
    echo 8. הזן Y כשישאל אם יצרת repository
    echo 9. הדבק את ה-URL
    echo.
    echo או קרא את create_github_repo.md למדריך מפורט
    echo.
)

pause

