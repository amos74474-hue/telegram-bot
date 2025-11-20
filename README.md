# Telegram Bot

בוט Telegram לשמירת פרטים אישיים.

## התקנה

```bash
pip install -r requirements.txt
python bot.py
```

## שימוש

1. שלח `/start` לבוט
2. שלח פרטים בפורמט: `שם: [שם]`, `טלפון: [טלפון]`, `כתובת: [כתובת]`
3. לצפייה: שלח `[גבה]`

## פקודות

- `/start` - התחלה
- `/myid` - User ID
- `/adduser <user_id>` - הוספת משתמש מורשה
- `/removeuser <user_id>` - הסרת משתמש
- `/listusers` - רשימת משתמשים
- `/clear` - מחיקת נתונים

## העברה לשרת מרוחק

הבוט מוכן ל-Railway, Render, Heroku וכו'.

הוסף משתנה סביבה: `BOT_TOKEN`
