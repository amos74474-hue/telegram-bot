import json
import os
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

# קובץ לשמירת הנתונים
DATA_FILE = "data.json"
# קובץ לשמירת המשתמשים המורשים
ALLOWED_USERS_FILE = "allowed_users.json"

def load_allowed_users():
    """טוען את רשימת המשתמשים המורשים"""
    if os.path.exists(ALLOWED_USERS_FILE):
        with open(ALLOWED_USERS_FILE, 'r', encoding='utf-8') as f:
            return json.load(f)
    return []

def save_allowed_users(allowed_users):
    """שומר את רשימת המשתמשים המורשים"""
    with open(ALLOWED_USERS_FILE, 'w', encoding='utf-8') as f:
        json.dump(allowed_users, f, ensure_ascii=False, indent=2)

def is_user_allowed(user_id):
    """בודק אם המשתמש מורשה להשתמש בבוט"""
    try:
        allowed_users = load_allowed_users()
        print(f"רשימת משתמשים מורשים: {allowed_users}")
        # אם הרשימה ריקה, כל המשתמשים מורשים (מצב פתוח)
        # אם יש משתמשים ברשימה, רק הם מורשים
        result = len(allowed_users) == 0 or user_id in allowed_users
        print(f"בדיקת הרשאות - user_id: {user_id}, רשימה: {allowed_users}, תוצאה: {result}")
        return result
    except Exception as e:
        print(f"שגיאה ב-is_user_allowed: {e}")
        # במקרה של שגיאה, נאפשר גישה (מצב בטוח יותר)
        return True

def load_data():
    """טוען את הנתונים מהקובץ"""
    if os.path.exists(DATA_FILE):
        with open(DATA_FILE, 'r', encoding='utf-8') as f:
            return json.load(f)
    return []

def save_data(data):
    """שומר את הנתונים לקובץ"""
    with open(DATA_FILE, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """פקודת התחלה"""
    try:
        user_id = update.message.from_user.id
        print(f"פקודת /start התקבלה מ-user ID: {user_id}")
        
        # בדיקת הרשאות
        allowed = is_user_allowed(user_id)
        print(f"הרשאות - user_id: {user_id}, מורשה: {allowed}")
        
        if not allowed:
            await update.message.reply_text("❌ אין לך הרשאה להשתמש בבוט זה.")
            print(f"ניסיון גישה לא מורשה מ-user ID: {user_id}")
            return
        
        print(f"פקודת /start מאושרת מ-{update.message.from_user.username or update.message.from_user.first_name}")
        welcome_message = """שלום! 👋

אני בוט לשמירת פרטים.

שלח לי את הפרטים בפורמט הבא:
שם: [השם שלך]
טלפון: [מספר הטלפון]
כתובת: [הכתובת]

או שלח כל פרט בשורה נפרדת.

לצפייה בכל הפרטים שמורים, שלח: [גבה]"""
        await update.message.reply_text(welcome_message)
        print("הודעת ברכה נשלחה בהצלחה")
    except Exception as e:
        print(f"שגיאה ב-start: {e}")
        import traceback
        traceback.print_exc()
        try:
            await update.message.reply_text("אירעה שגיאה. אנא נסה שוב.")
        except:
            pass

async def myid(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מציג את ה-user ID של המשתמש"""
    try:
        user_id = update.message.from_user.id
        username = update.message.from_user.username or "אין שם משתמש"
        first_name = update.message.from_user.first_name or "אין שם"
        
        message = f"המזהה שלך (User ID): {user_id}\n"
        message += f"שם משתמש: @{username}\n"
        message += f"שם: {first_name}\n\n"
        message += f"להוספה לרשימת המשתמשים המורשים, שלח: /adduser {user_id}"
        
        await update.message.reply_text(message)
        print(f"User ID נשלח ל-{user_id}")
    except Exception as e:
        print(f"שגיאה ב-myid: {e}")
        await update.message.reply_text(f"אירעה שגיאה: {str(e)}")

async def add_user(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מוסיף משתמש מורשה"""
    user_id = update.message.from_user.id
    
    # בדיקה אם יש ארגומנט (user ID להוספה)
    if not context.args:
        await update.message.reply_text("שימוש: /adduser <user_id>\nלהצגת ה-user ID שלך, שלח /myid")
        return
    
    try:
        new_user_id = int(context.args[0])
        allowed_users = load_allowed_users()
        
        if new_user_id not in allowed_users:
            allowed_users.append(new_user_id)
            save_allowed_users(allowed_users)
            await update.message.reply_text(f"✅ משתמש {new_user_id} נוסף לרשימת המשתמשים המורשים.")
            print(f"משתמש {new_user_id} נוסף לרשימה על ידי {user_id}")
        else:
            await update.message.reply_text(f"המשתמש {new_user_id} כבר ברשימה.")
    except ValueError:
        await update.message.reply_text("❌ שגיאה: user ID חייב להיות מספר.")

async def remove_user(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מסיר משתמש מורשה"""
    user_id = update.message.from_user.id
    
    # בדיקה אם יש ארגומנט (user ID להסרה)
    if not context.args:
        await update.message.reply_text("שימוש: /removeuser <user_id>")
        return
    
    try:
        remove_user_id = int(context.args[0])
        allowed_users = load_allowed_users()
        
        if remove_user_id in allowed_users:
            allowed_users.remove(remove_user_id)
            save_allowed_users(allowed_users)
            await update.message.reply_text(f"✅ משתמש {remove_user_id} הוסר מרשימת המשתמשים המורשים.")
            print(f"משתמש {remove_user_id} הוסר מהרשימה על ידי {user_id}")
        else:
            await update.message.reply_text(f"המשתמש {remove_user_id} לא נמצא ברשימה.")
    except ValueError:
        await update.message.reply_text("❌ שגיאה: user ID חייב להיות מספר.")

async def list_users(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מציג את רשימת המשתמשים המורשים"""
    allowed_users = load_allowed_users()
    
    if len(allowed_users) == 0:
        await update.message.reply_text("📋 הבוט פתוח לכולם (אין משתמשים מורשים ברשימה).\n\nלהוספת משתמשים, שלח: /adduser <user_id>")
    else:
        message = f"📋 רשימת המשתמשים המורשים ({len(allowed_users)}):\n\n"
        for user_id in allowed_users:
            message += f"• {user_id}\n"
        await update.message.reply_text(message)

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מטפל בהודעות רגילות"""
    try:
        user_id = update.message.from_user.id
        print(f"הודעה התקבלה מ-user ID: {user_id}")
        
        # בדיקת הרשאות
        allowed = is_user_allowed(user_id)
        print(f"הרשאות - user_id: {user_id}, מורשה: {allowed}")
        
        if not allowed:
            await update.message.reply_text("❌ אין לך הרשאה להשתמש בבוט זה.")
            print(f"ניסיון גישה לא מורשה מ-user ID: {user_id}")
            return
        
        text = update.message.text.strip()
        print(f"הודעה מאושרת: {text}")  # לוג לדיבוג
        
        # בדיקה אם זו פקודת גבה
        if text == "[גבה]" or text == "גבה":
            print("זוהתה פקודת גבה")  # לוג לדיבוג
            await send_collected_data(update, context)
            return
        
        # ניסיון לחלץ פרטים מההודעה
        data = load_data()
        user_id = update.message.from_user.id
        
        # חילוץ פרטים מההודעה
        name = None
        phone = None
        address = None
        
        lines = text.split('\n')
        for line in lines:
            line = line.strip()
            if line.startswith('שם:') or line.startswith('שם :'):
                name = line.split(':', 1)[1].strip()
            elif line.startswith('טלפון:') or line.startswith('טלפון :') or line.startswith('פלאפון:') or line.startswith('פלאפון :'):
                phone = line.split(':', 1)[1].strip()
            elif line.startswith('כתובת:') or line.startswith('כתובת :'):
                address = line.split(':', 1)[1].strip()
        
        # אם לא מצאנו בפורמט מובנה, ננסה לזהות לפי מספר שורות
        if not name and not phone and not address:
            parts = [line.strip() for line in lines if line.strip()]
            if len(parts) >= 3:
                name = parts[0]
                phone = parts[1]
                address = parts[2]
            elif len(parts) == 2:
                name = parts[0]
                phone = parts[1]
            elif len(parts) == 1:
                # אם יש רק שורה אחת, נשמור אותה כהערה או נבקש פרטים נוספים
                await update.message.reply_text(
                    "אנא שלח את הפרטים בפורמט:\nשם: [שם]\nטלפון: [טלפון]\nכתובת: [כתובת]"
                )
                return
        
        # שמירת הנתונים
        if name or phone or address:
            entry = {
                "user_id": user_id,
                "name": name or "לא צוין",
                "phone": phone or "לא צוין",
                "address": address or "לא צוין"
            }
            data.append(entry)
            save_data(data)
            
            await update.message.reply_text(
                f"✅ הפרטים נשמרו בהצלחה!\n\n"
                f"שם: {entry['name']}\n"
                f"טלפון: {entry['phone']}\n"
                f"כתובת: {entry['address']}"
            )
        else:
            await update.message.reply_text(
                "לא הצלחתי לזהות את הפרטים. אנא שלח בפורמט:\nשם: [שם]\nטלפון: [טלפון]\nכתובת: [כתובת]"
            )
    except Exception as e:
        print(f"שגיאה ב-handle_message: {e}")
        import traceback
        traceback.print_exc()
        try:
            await update.message.reply_text(f"אירעה שגיאה: {str(e)}")
        except:
            pass

async def send_collected_data(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """שולח את כל הנתונים השמורים"""
    user_id = update.message.from_user.id
    
    # בדיקת הרשאות
    if not is_user_allowed(user_id):
        await update.message.reply_text("❌ אין לך הרשאה להשתמש בבוט זה.")
        return
    
    try:
        data = load_data()
        user_id = update.message.from_user.id
        
        # מסנן רק את הנתונים של המשתמש הנוכחי
        user_data = [entry for entry in data if entry.get("user_id") == user_id]
        
        if not user_data:
            await update.message.reply_text("אין פרטים שמורים עדיין.")
            return
        
        # בניית רשימה מסודרת
        message = "📋 רשימת הפרטים השמורים:\n\n"
        message += "=" * 30 + "\n\n"
        
        for i, entry in enumerate(user_data, 1):
            message += f"📌 רשומה #{i}\n"
            message += f"שם: {entry.get('name', 'לא צוין')}\n"
            message += f"טלפון: {entry.get('phone', 'לא צוין')}\n"
            message += f"כתובת: {entry.get('address', 'לא צוין')}\n"
            message += "-" * 30 + "\n\n"
        
        message += f"סה\"כ: {len(user_data)} רשומות"
        
        await update.message.reply_text(message)
    
    except Exception as e:
        await update.message.reply_text(f"אירעה שגיאה: {str(e)}")

async def clear_data(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """מחיקת כל הנתונים של המשתמש"""
    user_id = update.message.from_user.id
    
    # בדיקת הרשאות
    if not is_user_allowed(user_id):
        await update.message.reply_text("❌ אין לך הרשאה להשתמש בבוט זה.")
        return
    
    try:
        data = load_data()
        user_id = update.message.from_user.id
        
        # מסנן את הנתונים של המשתמש הנוכחי
        filtered_data = [entry for entry in data if entry.get("user_id") != user_id]
        save_data(filtered_data)
        
        await update.message.reply_text("✅ כל הנתונים שלך נמחקו.")
    
    except Exception as e:
        await update.message.reply_text(f"אירעה שגיאה: {str(e)}")

async def error_handler(update: object, context: ContextTypes.DEFAULT_TYPE) -> None:
    """מטפל בשגיאות"""
    try:
        print(f"שגיאה: {context.error}")
        import traceback
        traceback.print_exc()
        
        if isinstance(update, Update) and update.message:
            try:
                await update.message.reply_text("אירעה שגיאה. אנא נסה שוב.")
            except:
                pass  # אם לא הצלחנו לשלוח הודעה, לא נוסיף עוד שגיאות
    except Exception as e:
        print(f"שגיאה ב-error_handler: {e}")

def main():
    """פונקציה ראשית להפעלת הבוט"""
    # תיקון קידוד לטרמינל Windows
    import sys
    import io
    if sys.platform == 'win32':
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
        sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')
    
    # קבלת הטוקן ממשתנה סביבה או ערך ברירת מחדל
    # ניתן לקבל טוקן מ-@BotFather בטלגרם
    # לשרתים מרוחקים: הגדר BOT_TOKEN כמשתנה סביבה
    BOT_TOKEN = os.getenv('BOT_TOKEN', "8472498174:AAE5NgVcMzCQYFJLFxkSM70u6C7qV2mOf08")
    
    if BOT_TOKEN == "YOUR_BOT_TOKEN" or not BOT_TOKEN:
        print("אנא החלף את BOT_TOKEN בטוקן האמיתי של הבוט!")
        print("קבל טוקן מ-@BotFather בטלגרם")
        print("או הגדר משתנה סביבה: export BOT_TOKEN=הטוקן_שלך")
        return
    
    # יצירת האפליקציה
    application = Application.builder().token(BOT_TOKEN).build()
    
    # הוספת handlers
    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("myid", myid))
    application.add_handler(CommandHandler("adduser", add_user))
    application.add_handler(CommandHandler("removeuser", remove_user))
    application.add_handler(CommandHandler("listusers", list_users))
    application.add_handler(CommandHandler("clear", clear_data))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
    application.add_error_handler(error_handler)
    
    # הפעלת הבוט
    print("מתחבר לבוט @comback122_bot...")
    print("הבוט פועל...")
    print("ממתין להודעות...")
    print("שלח /start לבוט @comback122_bot בטלגרם")
    
    # הגדרות polling לשיפור ביצועים ותגובה מהירה
    retry_count = 0
    max_retries = -1  # אינסופי
    
    def setup_application():
        """יוצר ומגדיר את האפליקציה"""
        print("יוצר אפליקציה חדשה...")
        app = Application.builder().token(BOT_TOKEN).build()
        app.add_handler(CommandHandler("start", start))
        app.add_handler(CommandHandler("myid", myid))
        app.add_handler(CommandHandler("adduser", add_user))
        app.add_handler(CommandHandler("removeuser", remove_user))
        app.add_handler(CommandHandler("listusers", list_users))
        app.add_handler(CommandHandler("clear", clear_data))
        app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
        app.add_error_handler(error_handler)
        print("אפליקציה נוצרה בהצלחה")
        return app
    
    # בדיקת חיבור ראשונית
    try:
        print("בודק חיבור ראשוני...")
        import asyncio
        async def test_connection():
            bot = await application.bot.get_me()
            print(f"חיבור הצליח! שם הבוט: {bot.first_name} (@{bot.username})")
            return True
        asyncio.run(test_connection())
    except Exception as e:
        print(f"אזהרה: בעיה בחיבור ראשוני: {e}")
        print("מנסה להמשיך בכל זאת...")
    
    while True:  # לולאה אינסופית - הבוט תמיד רץ
        try:
            if retry_count > 0:
                print(f"\n{'='*50}")
                print(f"מתחבר לבוט מחדש... (ניסיון #{retry_count + 1})")
                print(f"{'='*50}")
                # סגירת האפליקציה הישנה אם קיימת
                try:
                    if application:
                        import asyncio
                        try:
                            loop = asyncio.get_event_loop()
                            if loop.is_running():
                                # אם הלולאה כבר רצה, נצטרך לסגור אחרת
                                pass
                            else:
                                asyncio.run(application.stop())
                                asyncio.run(application.shutdown())
                        except:
                            pass
                except:
                    pass
                application = setup_application()
            else:
                print("מתחיל polling...")
            
            # הפעלת polling
            application.run_polling(
                allowed_updates=Update.ALL_TYPES,
                drop_pending_updates=True,
                poll_interval=1.0,  # דיליי קצר בין polling
                timeout=30,  # timeout ארוך יותר ליציבות
                bootstrap_retries=-1  # retry אינסופי במקרה של בעיות חיבור
            )
            # אם run_polling חזר, זה אומר שהבוט נעצר
            print("run_polling חזר - הבוט נעצר")
            retry_count += 1
            
        except KeyboardInterrupt:
            print("\nהבוט נעצר על ידי המשתמש")
            try:
                import asyncio
                try:
                    loop = asyncio.get_event_loop()
                    if not loop.is_running():
                        asyncio.run(application.stop())
                        asyncio.run(application.shutdown())
                except:
                    pass
            except:
                pass
            break
        except Exception as e:
            retry_count += 1
            print(f"\n{'='*50}")
            print(f"שגיאה: {e}")
            print(f"{'='*50}")
            import traceback
            traceback.print_exc()
            # ניסיון להפעיל מחדש אחרי 10 שניות
            print(f"מנסה להפעיל מחדש בעוד 10 שניות... (ניסיון #{retry_count})")
            import time
            time.sleep(10)

if __name__ == "__main__":
    main()

