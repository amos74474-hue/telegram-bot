"""הרצת הבוט עם פלט מפורט"""
import sys
import io

# תיקון קידוד
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

print("=" * 50)
print("מתחיל את הבוט...")
print("=" * 50)

try:
    # ייבוא הקוד
    from bot import main
    
    print("הקוד נטען בהצלחה")
    print("מפעיל את main()...")
    print("-" * 50)
    
    # הפעלת הבוט
    main()
    
except KeyboardInterrupt:
    print("\n" + "=" * 50)
    print("הבוט נעצר על ידי המשתמש")
    print("=" * 50)
except Exception as e:
    print("\n" + "=" * 50)
    print(f"שגיאה קריטית: {e}")
    print("=" * 50)
    import traceback
    traceback.print_exc()
    sys.exit(1)

