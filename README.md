# 🤖 Telegram Bot - שמירת פרטים

בוט Telegram לשמירת פרטים אישיים (שם, טלפון, כתובת).

## ✨ תכונות

- שמירת פרטים אישיים
- ניהול משתמשים מורשים
- גיבוי וצפייה בנתונים
- תמיכה בעברית

## 🚀 התקנה מקומית

### דרישות
- Python 3.8+
- pip

### התקנה
```bash
pip install -r requirements.txt
```

### הפעלה
```bash
python bot.py
```

## ☁️ העברה לשרת מרוחק

הבוט מוכן להעברה לשרתים מרוחקים כמו Railway, Render, Heroku וכו'.

### Railway.app (מומלץ)
1. העלה את הקוד ל-GitHub
2. היכנס ל-https://railway.app
3. בחר "Deploy from GitHub repo"
4. הוסף משתנה סביבה: `BOT_TOKEN`

קרא את `QUICK_DEPLOY.md` למדריך מפורט.

## 📝 שימוש

1. פתח את הבוט בטלגרם
2. שלח `/start`
3. שלח פרטים בפורמט:
   ```
   שם: [השם שלך]
   טלפון: [מספר הטלפון]
   כתובת: [הכתובת]
   ```
4. לצפייה בנתונים: שלח `[גבה]`

## 🔧 פקודות

- `/start` - התחלה
- `/myid` - הצגת User ID
- `/adduser <user_id>` - הוספת משתמש מורשה
- `/removeuser <user_id>` - הסרת משתמש מורשה
- `/listusers` - רשימת משתמשים מורשים
- `/clear` - מחיקת כל הנתונים שלך

## 📁 מבנה הפרויקט

```
.
├── bot.py                 # הקוד הראשי
├── requirements.txt       # תלויות
├── Procfile              # להגדרת Railway/Heroku
├── runtime.txt           # גרסת Python
├── .gitignore           # קבצים לא להעלות
└── README.md            # קובץ זה
```

## 🔒 אבטחה

- הטוקן נשמר במשתני סביבה
- קבצי נתונים לא מועלים ל-GitHub
- `.env` ב-`.gitignore`

## 📚 תיעוד

- `QUICK_DEPLOY.md` - העברה מהירה לשרת מרוחק
- `DEPLOY_TO_CLOUD.md` - מדריך מפורט להעברה
- `README_AUTO_START.md` - הפעלה אוטומטית ב-Windows
- `TROUBLESHOOTING.md` - פתרון בעיות

## 📄 רישיון

פרויקט זה הוא קוד פתוח.

