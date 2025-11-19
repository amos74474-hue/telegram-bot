"""סקריפט בדיקה מהירה לבוט"""
import sys
import os
import io

# תיקון קידוד ל-Windows
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# בדיקת ייבוא
try:
    from telegram import Update
    from telegram.ext import Application, CommandHandler
    print("OK - כל החבילות מותקנות")
except ImportError as e:
    print(f"ERROR - שגיאה בייבוא: {e}")
    print("הרץ: pip install -r requirements.txt")
    sys.exit(1)

# בדיקת טוקן
BOT_TOKEN = "8472498174:AAE5NgVcMzCQYFJLFxkSM70u6C7qV2mOf08"
if not BOT_TOKEN or BOT_TOKEN == "YOUR_BOT_TOKEN":
    print("ERROR - טוקן לא הוגדר")
    sys.exit(1)

# בדיקת חיבור
try:
    print("מתחבר לבוט...")
    application = Application.builder().token(BOT_TOKEN).build()
    
    async def test_connection():
        bot = await application.bot.get_me()
        print(f"SUCCESS - חיבור הצליח!")
        print(f"   שם הבוט: {bot.first_name}")
        print(f"   שם משתמש: @{bot.username}")
        return True
    
    import asyncio
    result = asyncio.run(test_connection())
    if result:
        print("\nSUCCESS - הבוט מוכן לעבודה!")
        print("הרץ: python bot.py")
except Exception as e:
    print(f"ERROR - שגיאה בחיבור: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

