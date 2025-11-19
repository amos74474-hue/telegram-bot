# הוראות להפעלת הבוט אוטומטית ב-Windows

## הבעיה
כאשר המחשב נסגר או נכנס למצב שינה, הבוט נעצר ולא מתחיל מחדש אוטומטית.

## פתרונות

### פתרון 1: הפעלה אוטומטית עם Task Scheduler (מומלץ)

1. לחץ על `Win + R` והקלד `taskschd.msc` ואז Enter
2. לחץ על "Create Basic Task" (יצירת משימה בסיסית) בצד ימין
3. שם: `Telegram Bot Auto Start`
4. תיאור: `מתחיל את הבוט אוטומטית בעת התחלת Windows`
5. לחץ Next
6. בחר "When I log on" (כאשר אני נכנס למערכת)
7. לחץ Next
8. בחר "Start a program"
9. לחץ Next
10. ב-"Program/script": לחץ Browse ובחר את הקובץ `start_bot_auto.bat`
11. ב-"Start in": הזן את הנתיב לתיקייה שבה נמצא הבוט (לדוגמה: `C:\Users\compu\OneDrive\Desktop\TelegramBotCursor`)
12. לחץ Next
13. סמן את "Open the Properties dialog for this task when I click Finish"
14. לחץ Finish
15. בחלון Properties:
    - בטאב "General": סמן "Run whether user is logged on or not" (אם אפשר)
    - בטאב "Triggers": לחץ Edit
      - סמן "On a schedule" → "At startup"
      - סמן "On workstation unlock" (כאשר המחשב מתעורר)
      - לחץ OK
    - בטאב "Settings":
      - סמן "Allow task to be run on demand"
      - סמן "Run task as soon as possible after a scheduled start is missed"
      - סמן "If the task fails, restart every:" → בחר 1 minute
      - "Attempt to restart up to:" → בחר 3 times
    - לחץ OK

### פתרון 2: הפעלה ידנית

פשוט לחץ פעמיים על `start_bot_auto.bat` - הבוט יתחיל ויתחיל מחדש אוטומטית אם יקרה משהו.

### פתרון 3: הוספה ל-Startup

1. לחץ על `Win + R` והקלד `shell:startup` ואז Enter
2. צור קיצור דרך (shortcut) לקובץ `start_bot_auto.bat`
3. הבוט יתחיל אוטומטית בכל התחלה של Windows

### פתרון 4: הפעלה כשירות (מתקדם)

אם אתה רוצה שהבוט ירוץ גם כשלא נכנסת למערכת, תוכל להשתמש ב-NSSM (Non-Sucking Service Manager):
1. הורד NSSM מ-https://nssm.cc/download
2. פתח cmd כמנהל מערכת
3. הרץ: `nssm install TelegramBot "C:\Python\python.exe" "C:\Users\compu\OneDrive\Desktop\TelegramBotCursor\bot.py"`
4. התאם את הנתיבים לפי המיקום שלך

## בדיקה שהבוט עובד

1. פתח את הבוט בטלגרם
2. שלח `/start`
3. אם אתה מקבל תשובה, הבוט עובד!

## הערות

- הקבצים `start_bot.bat` ו-`start_bot_auto.bat` מפעילים את הבוט
- `start_bot_auto.bat` יתחיל מחדש את הבוט אוטומטית אם הוא נעצר
- אם יש בעיות, בדוק את חלון ה-cmd כדי לראות הודעות שגיאה

