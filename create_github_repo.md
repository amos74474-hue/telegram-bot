# 🚀 יצירת Repository ב-GitHub - מדריך שלב אחר שלב

## שלב 1: היכנס ל-GitHub

1. **פתח דפדפן** (Chrome, Edge, Firefox וכו')
2. **היכנס ל:** https://github.com
3. **היכנס לחשבון שלך:**
   - אם אין לך חשבון → לחץ "Sign up" ויצור אחד
   - אם יש לך → לחץ "Sign in"

---

## שלב 2: צור Repository חדש

1. **לחץ על הכפתור "+"** בפינה הימנית העליונה
   - זה נמצא ליד התמונה שלך
   - או לחץ כאן: https://github.com/new

2. **בחר "New repository"** מהתפריט

---

## שלב 3: מלא את הפרטים

### Repository name:
```
telegram-bot
```
(או כל שם אחר שאתה רוצה)

### Description (אופציונלי):
```
Telegram Bot for saving personal data
```

### Public או Private?
- **Public** - כולם יכולים לראות את הקוד (מומלץ לפרויקטים פתוחים)
- **Private** - רק אתה יכול לראות (מומלץ לפרויקטים פרטיים)

**בחר מה שאתה רוצה** (אני ממליץ על Private)

### ⚠️ חשוב - אל תסמן:
- ❌ **אל תסמן** "Add a README file"
- ❌ **אל תסמן** "Add .gitignore"
- ❌ **אל תסמן** "Choose a license"

**השאר הכל ריק!**

---

## שלב 4: צור את ה-Repository

1. **לחץ על הכפתור הירוק:** "Create repository"

2. **GitHub יציג לך הוראות** - אל תעשה כלום עדיין!

3. **העתק את ה-URL** של ה-repository:
   - זה יראה כך: `https://github.com/YOUR_USERNAME/telegram-bot.git`
   - העתק את זה (Ctrl+C)

---

## שלב 5: חיבור והעלאה (אחרי שתסיים את השלבים ב-PowerShell)

לאחר שתסיים את השלבים ב-PowerShell, תצטרך להריץ:

```powershell
git remote add origin https://github.com/YOUR_USERNAME/telegram-bot.git
git branch -M main
git push -u origin main
```

**החלף `YOUR_USERNAME` בשם המשתמש שלך ב-GitHub!**

---

## ✅ מה הלאה?

לאחר יצירת ה-repository:
1. חזור ל-PowerShell
2. הרץ את הפקודות שהכנתי
3. הקוד יועלה ל-GitHub
4. תוכל להגדיר Railway!

---

## 🎯 סיכום מהיר

1. ✅ היכנס ל-https://github.com
2. ✅ לחץ "+" → "New repository"
3. ✅ שם: `telegram-bot`
4. ✅ בחר Public או Private
5. ✅ **אל תסמן כלום!**
6. ✅ לחץ "Create repository"
7. ✅ העתק את ה-URL
8. ✅ חזור ל-PowerShell להמשך

---

## 📸 תמונות עזר

אם אתה רוצה, אני יכול להכין לך מדריך עם תמונות. אבל ההוראות למעלה מספיקות!

---

## ❓ שאלות?

אם יש בעיות:
- ודא שיצרת חשבון ב-GitHub
- ודא שהשם לא תפוס (אם כן, שנה שם)
- ודא שלא סימנת את התיבות

