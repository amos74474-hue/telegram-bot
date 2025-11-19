@echo off
chcp 65001 >nul
echo ========================================
echo הגדרת Git והעלאה ל-GitHub
echo ========================================
echo.

REM בדיקה אם Git מותקן
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo שגיאה: Git לא מותקן!
    echo.
    echo הורד Git מ: https://git-scm.com/download/win
    echo התקן אותו והרץ שוב את הסקריפט הזה.
    echo.
    pause
    exit /b 1
)

echo Git מותקן!
echo.

REM בדיקה אם כבר יש repository
if exist ".git" (
    echo נמצא repository קיים.
    echo.
    set /p CONTINUE="האם להמשיך? (Y/N): "
    if /i not "%CONTINUE%"=="Y" (
        exit /b 0
    )
) else (
    echo יוצר repository חדש...
    git init
    echo Repository נוצר!
    echo.
)

REM הוספת קבצים
echo מוסיף קבצים...
git add .
echo קבצים נוספו!
echo.

REM יצירת commit
echo יוצר commit...
git commit -m "Initial commit - Telegram Bot"
echo Commit נוצר!
echo.

echo ========================================
echo שלב הבא: העלאה ל-GitHub
echo ========================================
echo.
echo 1. היכנס ל-https://github.com
echo 2. לחץ על "+" בפינה הימנית העליונה
echo 3. בחר "New repository"
echo 4. שם: telegram-bot (או שם אחר)
echo 5. בחר "Public" או "Private"
echo 6. אל תסמן "Initialize with README"
echo 7. לחץ "Create repository"
echo.
echo 8. לאחר יצירת ה-repository, הרץ:
echo    git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo החלף YOUR_USERNAME ו-YOUR_REPO בשם שלך!
echo.

set /p HAS_REPO="האם כבר יצרת repository ב-GitHub? (Y/N): "
if /i "%HAS_REPO%"=="Y" (
    set /p REPO_URL="הזן את ה-URL של ה-repository (לדוגמה: https://github.com/username/repo.git): "
    if not "%REPO_URL%"=="" (
        git remote add origin "%REPO_URL%" 2>nul
        if %errorlevel% == 0 (
            echo ה-remote נוסף בהצלחה!
        ) else (
            git remote set-url origin "%REPO_URL%"
            echo ה-remote עודכן!
        )
        echo.
        git branch -M main
        echo.
        set /p PUSH_NOW="האם להעלות עכשיו? (Y/N): "
        if /i "%PUSH_NOW%"=="Y" (
            echo מעלה ל-GitHub...
            git push -u origin main
            if %errorlevel% == 0 (
                echo.
                echo ========================================
                echo SUCCESS - הקוד הועלה ל-GitHub!
                echo ========================================
                echo.
                echo עכשיו תוכל להגדיר את Railway או שירות אחר!
                echo קרא את QUICK_DEPLOY.md למדריך.
                echo.
            ) else (
                echo.
                echo ========================================
                echo ERROR - לא הצלחתי להעלות
                echo ========================================
                echo.
                echo ודא ש:
                echo 1. יצרת repository ב-GitHub
                echo 2. ה-URL נכון
                echo 3. יש לך הרשאות
                echo.
            )
        )
    )
)

pause

