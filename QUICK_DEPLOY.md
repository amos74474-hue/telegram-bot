# 🚀 העברה מהירה לשרת מרוחק

## המטרה
להריץ את הבוט על שרת מרוחק שתמיד דלוק, כך שהוא יעבוד גם כשהמחשב שלך כבוי.

---

## ⚡ פתרון מהיר - Railway.app (5 דקות)

### שלב 1: העלה ל-GitHub
1. צור repository חדש ב-GitHub
2. העלה את כל הקבצים (חוץ מ-`.env` ו-`*.log`)
3. ודא ש-`.gitignore` כולל את הקבצים הפרטיים

### שלב 2: התקן ב-Railway
1. היכנס ל-https://railway.app
2. לחץ "Start a New Project"
3. בחר "Deploy from GitHub repo"
4. בחר את ה-repo שלך
5. Railway יזהה אוטומטית שזה Python

### שלב 3: הגדר משתני סביבה
1. לחץ על הפרויקט
2. לחץ "Variables"
3. הוסף: `BOT_TOKEN` = `8472498174:AAE5NgVcMzCQYFJLFxkSM70u6C7qV2mOf08`
4. לחץ "Add"

### שלב 4: בדיקה
1. הבוט יתחיל אוטומטית!
2. בדוק ב-Logs שהבוט רץ
3. פתח את הבוט בטלגרם ושלח `/start`
4. אם אתה מקבל תשובה - זה עובד! ✅

---

## 🌐 אפשרויות אחרות

### Render.com (חינמי)
1. היכנס ל-https://render.com
2. "New" → "Background Worker"
3. בחר את ה-repo שלך
4. Build: `pip install -r requirements.txt`
5. Start: `python bot.py`
6. הוסף משתנה: `BOT_TOKEN`

### PythonAnywhere (חינמי)
1. היכנס ל-https://www.pythonanywhere.com
2. צור חשבון
3. העלה קבצים
4. הרץ: `python3.10 bot.py`
5. הגדר Scheduled Task

### VPS (תשלום - 5$/חודש)
- DigitalOcean
- Vultr
- Linode

---

## ✅ יתרונות

- ✅ הבוט עובד 24/7
- ✅ לא תלוי במחשב שלך
- ✅ עובד גם כשהמחשב כבוי
- ✅ חינמי (בחלק מהשירותים)

---

## 📋 קבצים חשובים

- `DEPLOY_TO_CLOUD.md` - מדריך מפורט
- `Procfile` - להגדרת Railway/Heroku
- `runtime.txt` - גרסת Python
- `.gitignore` - קבצים לא להעלות

---

## 🔒 אבטחה

⚠️ **אל תעלה את הטוקן ל-GitHub!**
- השתמש במשתני סביבה
- `.env` כבר ב-`.gitignore`
- הטוקן בקוד הוא רק לדוגמה

---

## 📞 עזרה

קרא את `DEPLOY_TO_CLOUD.md` למדריך מפורט יותר.

