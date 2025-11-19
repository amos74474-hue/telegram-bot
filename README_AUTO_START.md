# הפעלה אוטומטית של הבוט - מדריך מלא

## המטרה
להפעיל את הבוט אוטומטית כך שהוא יעבוד גם כשלא פותחים את המחשב ידנית.

## ⚠️ חשוב להבין
**הבוט לא יכול לעבוד כשהמחשב כבוי לחלוטין!**
- אם המחשב כבוי - הבוט לא יעבוד
- אם המחשב במצב שינה - הבוט לא יעבוד
- **הבוט יעבוד רק כשהמחשב דלוק ו-Windows רץ**

## פתרונות

### פתרון 1: Task Scheduler (הכי פשוט) ⭐ מומלץ

#### אוטומטי:
1. לחץ פעמיים על `setup_auto_start.bat`
2. אם יש שגיאה - הרץ כמנהל מערכת (Right-click → Run as Administrator)

#### ידני:
1. לחץ `Win + R` והקלד `taskschd.msc`
2. לחץ "Create Basic Task"
3. שם: `TelegramBotAutoStart`
4. Trigger: "When I log on" (כאשר אני נכנס למערכת)
5. Action: "Start a program"
6. Program: בחר את `start_bot_auto.bat`
7. Start in: `C:\Users\compu\OneDrive\Desktop\TelegramBotCursor`
8. לחץ Finish
9. לחץ ימין על המשימה → Properties
10. בטאב "General": סמן "Run whether user is logged on or not"
11. בטאב "Triggers": לחץ Edit → סמן "At startup" ו-"On workstation unlock"
12. בטאב "Settings": סמן "Run task as soon as possible after a scheduled start is missed"

**יתרונות:**
- פשוט להגדרה
- עובד אוטומטית
- מתחיל מחדש אם נכשל

**חסרונות:**
- דורש התחברות למערכת (או הגדרה מיוחדת)

---

### פתרון 2: Windows Service (הכי חזק) ⭐⭐⭐

#### דרישות:
1. הורד NSSM מ-https://nssm.cc/download
2. חלץ את `nssm.exe` (64-bit או 32-bit לפי המערכת שלך)
3. העתק את `nssm.exe` לתיקייה זו

#### התקנה:
1. לחץ ימין על `install_service_simple.bat` → Run as Administrator
2. עקוב אחר ההוראות

או ידנית:
```cmd
nssm install TelegramBot "C:\Python\python.exe" "C:\Users\compu\OneDrive\Desktop\TelegramBotCursor\bot.py"
nssm set TelegramBot AppDirectory "C:\Users\compu\OneDrive\Desktop\TelegramBotCursor"
nssm set TelegramBot Start SERVICE_AUTO_START
nssm start TelegramBot
```

**יתרונות:**
- רץ גם בלי התחברות למערכת
- רץ ברקע כל הזמן
- מתחיל אוטומטית בכל התחלה
- הכי יציב

**חסרונות:**
- דורש NSSM
- דורש הרצה כמנהל מערכת

---

### פתרון 3: Startup Folder (פשוט מאוד)

1. לחץ `Win + R` והקלד `shell:startup`
2. צור קיצור דרך (shortcut) ל-`start_bot_auto.bat`
3. הבוט יתחיל בכל התחלה

**יתרונות:**
- הכי פשוט
- לא דורש הרשאות מיוחדות

**חסרונות:**
- דורש התחברות למערכת
- לא מתחיל מחדש אוטומטית אם נכשל

---

## בדיקה שהבוט עובד

### בדיקה מהירה:
1. פתח את הבוט בטלגרם
2. שלח `/start`
3. אם אתה מקבל תשובה - הבוט עובד! ✅

### בדיקת Task Scheduler:
```cmd
schtasks /query /tn "TelegramBotAutoStart"
```

### בדיקת שירות:
```cmd
nssm status TelegramBot
```

או:
1. לחץ `Win + R` והקלד `services.msc`
2. חפש "Telegram Bot"
3. בדוק שהסטטוס הוא "Running"

---

## פתרון בעיות

### הבוט לא מתחיל אוטומטית:
1. בדוק שהמשימה/שירות מוגדר ל-"Automatic"
2. בדוק את הלוגים:
   - Task Scheduler: View → Show All Running Tasks
   - Service: `bot_service.log` ו-`bot_service_error.log`

### הבוט נעצר:
- `start_bot_auto.bat` יתחיל אותו מחדש אוטומטית
- אם זה לא עובד, בדוק את הלוגים

### שגיאות הרשאות:
- הרץ את הסקריפטים כמנהל מערכת (Run as Administrator)

---

## המלצה

**למשתמש רגיל:** פתרון 1 (Task Scheduler) - הכי פשוט וטוב
**למשתמש מתקדם:** פתרון 2 (Windows Service) - הכי יציב וחזק

---

## הערות חשובות

1. **המחשב חייב להיות דלוק** - הבוט לא יכול לעבוד כשהמחשב כבוי
2. **Windows חייב לרוץ** - הבוט לא יכול לעבוד בלי Windows
3. **חיבור לאינטרנט נדרש** - הבוט צריך חיבור לאינטרנט לעבוד
4. **Python חייב להיות מותקן** - ודא ש-Python מותקן וזמין

---

## תמיכה

אם יש בעיות:
1. בדוק את הלוגים (`bot_service.log` או חלון cmd)
2. בדוק שהבוט רץ: `python test_bot.py`
3. בדוק את Task Scheduler או Services

