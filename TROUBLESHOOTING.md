# פתרון בעיות - הבוט לא פועל

## בדיקה מהירה

### שלב 1: בדיקת Python
פתח PowerShell והרץ:
```powershell
python --version
```
אם אתה מקבל שגיאה, התקן Python מ-https://www.python.org/

### שלב 2: בדיקת החבילות
```powershell
python -m pip install -r requirements.txt
```

### שלב 3: בדיקת חיבור
```powershell
python test_bot.py
```

אם אתה מקבל שגיאה, בדוק:
1. האם הטוקן נכון?
2. האם יש חיבור לאינטרנט?
3. האם החבילות מותקנות?

### שלב 4: הפעלת הבוט
```powershell
python bot.py
```

או לחץ פעמיים על `start_bot_auto.bat`

## בעיות נפוצות

### בעיה: "ModuleNotFoundError: No module named 'telegram'"
**פתרון:**
```powershell
python -m pip install python-telegram-bot
```

### בעיה: "Invalid token" או "Unauthorized"
**פתרון:**
1. בדוק שהטוקן ב-`bot.py` נכון
2. קבל טוקן חדש מ-@BotFather בטלגרם
3. החלף את הטוקן ב-`bot.py`

### בעיה: הבוט לא מגיב להודעות
**פתרון:**
1. ודא שהבוט רץ (תראה הודעות בקונסול)
2. שלח `/start` לבוט בטלגרם
3. בדוק שאתה ברשימת המשתמשים המורשים (אם יש רשימה)

### בעיה: הבוט נעצר אחרי סגירת המחשב
**פתרון:**
1. השתמש ב-`start_bot_auto.bat` להפעלה
2. הגדר Task Scheduler לפי ההוראות ב-`README_STARTUP.md`

### בעיה: שגיאת קידוד (encoding)
**פתרון:**
הקוד כבר מכיל תיקון לקידוד. אם עדיין יש בעיה:
```powershell
chcp 65001
python bot.py
```

## בדיקת סטטוס הבוט

כדי לבדוק אם הבוט רץ:
1. פתח את הבוט בטלגרם
2. שלח `/start`
3. אם אתה מקבל תשובה - הבוט עובד!

## לוגים

הבוט מדפיס הודעות לקונסול. אם יש שגיאה, תראה אותה שם.

## קבלת עזרה

אם שום דבר לא עובד:
1. הרץ `python test_bot.py` ושלח את הפלט
2. הרץ `python bot.py` ושלח את השגיאות
3. בדוק שיש חיבור לאינטרנט

