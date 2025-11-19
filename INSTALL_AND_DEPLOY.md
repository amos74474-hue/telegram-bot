# 🚀 התקנה והעלאה - מדריך מלא

## שלב 1: התקנת Git

### אופציה A: הורדה והתקנה ידנית

1. **הורד Git:**
   - פתח: https://git-scm.com/download/win
   - לחץ על "Download for Windows"
   - הקובץ יורד אוטומטית

2. **התקן Git:**
   - לחץ פעמיים על הקובץ שהורד
   - לחץ "Next" בכל השלבים (ברירת מחדל טובה)
   - בסוף לחץ "Finish"

3. **הפעל מחדש את PowerShell:**
   - סגור את PowerShell
   - פתח PowerShell חדש

4. **בדיקה:**
   ```powershell
   git --version
   ```
   אם אתה רואה מספר גרסה - Git מותקן! ✅

### אופציה B: התקנה עם Chocolatey (אם מותקן)

```powershell
choco install git
```

---

## שלב 2: יצירת חשבון GitHub (אם אין)

1. **היכנס ל-GitHub:**
   - פתח: https://github.com
   - לחץ "Sign up"

2. **צור חשבון:**
   - הזן שם משתמש
   - הזן אימייל
   - הזן סיסמה
   - לחץ "Create account"

3. **אימות אימייל:**
   - בדוק את האימייל שלך
   - לחץ על הקישור

---

## שלב 3: העלאת הקוד ל-GitHub

### דרך אוטומטית (מומלץ):

1. **הרץ את הסקריפט:**
   - לחץ פעמיים על `setup_git.bat`
   - עקוב אחר ההוראות

### דרך ידנית:

**פתח PowerShell בתיקייה:**
```powershell
cd "C:\Users\compu\OneDrive\Desktop\TelegramBotCursor"
```

**1. הגדר Git (פעם אחת):**
```powershell
git config --global user.name "השם שלך"
git config --global user.email "האימייל שלך ב-GitHub"
```

**2. צור repository מקומי:**
```powershell
git init
```

**3. הוסף קבצים:**
```powershell
git add .
```

**4. צור commit:**
```powershell
git commit -m "Initial commit - Telegram Bot"
```

**5. צור repository ב-GitHub:**
   - היכנס ל-https://github.com
   - לחץ "+" → "New repository"
   - שם: `telegram-bot`
   - **אל תסמן** "Initialize with README"
   - לחץ "Create repository"

**6. חבר והעלה:**
```powershell
git remote add origin https://github.com/YOUR_USERNAME/telegram-bot.git
git branch -M main
git push -u origin main
```

**החלף `YOUR_USERNAME` בשם המשתמש שלך ב-GitHub!**

**דוגמה:**
```powershell
git remote add origin https://github.com/john/telegram-bot.git
git branch -M main
git push -u origin main
```

---

## שלב 4: הגדרת Railway (לאחר ההעלאה)

1. **היכנס ל-Railway:**
   - פתח: https://railway.app
   - לחץ "Login with GitHub"
   - הרשא ל-Railway לגשת ל-GitHub

2. **צור פרויקט:**
   - לחץ "Start a New Project"
   - בחר "Deploy from GitHub repo"
   - בחר את ה-repository `telegram-bot`

3. **הגדר משתני סביבה:**
   - לחץ על הפרויקט
   - לחץ "Variables"
   - לחץ "New Variable"
   - שם: `BOT_TOKEN`
   - ערך: `8472498174:AAE5NgVcMzCQYFJLFxkSM70u6C7qV2mOf08`
   - לחץ "Add"

4. **הבוט יתחיל אוטומטית!**
   - בדוק ב-"Deployments" שהבוט רץ
   - בדוק ב-"Logs" שאין שגיאות

5. **בדיקה:**
   - פתח את הבוט בטלגרם
   - שלח `/start`
   - אם אתה מקבל תשובה - זה עובד! ✅

---

## ✅ סיכום

1. ✅ התקן Git
2. ✅ צור חשבון GitHub
3. ✅ העלה את הקוד ל-GitHub
4. ✅ הגדר Railway
5. ✅ הבוט עובד 24/7! 🚀

---

## 🐛 פתרון בעיות

### Git לא מותקן:
- הורד והתקן מ-https://git-scm.com/download/win
- הפעל מחדש את PowerShell

### שגיאת Authentication:
- GitHub דורש Token אישי
- צור Token: GitHub → Settings → Developer settings → Personal access tokens
- השתמש ב-Token במקום סיסמה

### שגיאת Permission:
- ודא שיש לך הרשאות ל-repository
- ודא שה-URL נכון

---

## 📞 עזרה

אם יש בעיות:
1. קרא את `GITHUB_SETUP.md` למדריך מפורט
2. קרא את `QUICK_DEPLOY.md` להגדרת Railway

