# 🚀 הגדרת הבוט לרוץ 24/7 - מדריך מהיר

## המטרה
להריץ את הבוט על שירות ענן כך שהוא יעבוד 24/7 גם כשהמחשב כבוי.

---

## ✅ שלב 1: בדיקה שהכל תקין

### בדיקה מקומית:
```bash
python bot.py
```

אם הבוט מתחיל - הכל תקין! ✓

---

## 📤 שלב 2: העלאה ל-GitHub

### אם הקוד כבר ב-GitHub:
- דלג לשלב 3

### אם לא:
1. פתח PowerShell
2. הרץ:
```powershell
cd "C:\Users\compu\OneDrive\Desktop\TelegramBotCursor"
git add .
git commit -m "Update bot"
git push
```

---

## ☁️ שלב 3: הגדרה על Render.com (מומלץ - חינמי)

### שלב 3.1: היכנס ל-Render
1. פתח: https://render.com
2. לחץ "Get Started for Free"
3. היכנס עם GitHub

### שלב 3.2: צור Background Worker
1. לחץ "New" → **"Background Worker"** (חשוב!)
2. Name: `telegram-bot`
3. Repository: בחר `telegram-bot`
4. Branch: `main`

### שלב 3.3: הגדרות
- **Build Command:** `pip install -r requirements.txt`
- **Start Command:** `python bot.py`
- **Plan:** Free (אוטומטית)

### שלב 3.4: משתני סביבה
1. גלול למטה ל-"Environment Variables"
2. לחץ "Add Environment Variable"
3. **Key:** `BOT_TOKEN`
4. **Value:** `8472498174:AAE5NgVcMzCQYFJLFxkSM70u6C7qV2mOf08`
5. לחץ "Add"

### שלב 3.5: צור
1. לחץ "Create Background Worker"
2. Render יתחיל לבנות ולהפעיל
3. זה יקח 2-3 דקות

### שלב 3.6: בדיקה
1. לחץ "Logs" כדי לראות את הלוגים
2. תראה: "מתחבר לבוט @comback122_bot..."
3. פתח את הבוט בטלגרם ושלח `/start`
4. אם אתה מקבל תשובה - זה עובד! ✅

---

## 🎉 סיימת!

הבוט עכשיו רץ 24/7 על Render!

- ✅ עובד גם כשהמחשב כבוי
- ✅ עובד כל הזמן
- ✅ חינמי

---

## 🔍 פתרון בעיות

### הבוט לא מתחיל?
- בדוק את ה-Logs ב-Render
- ודא שה-`BOT_TOKEN` נכון

### הבוט לא מגיב?
- ודא ש-`allowed_users.json` ריק: `[]`
- בדוק את ה-Logs

---

## 📝 הערות

- Render חינמי ל-Background Workers
- הבוט יתחיל מחדש אוטומטית אם נכשל
- כל עדכון ב-GitHub יעדכן אוטומטית את הבוט

