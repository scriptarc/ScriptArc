@echo off
echo Syncing Course videos to Backblaze B2...
C:\Users\Aswin\AppData\Local\Python\pythoncore-3.14-64\Scripts\b2.exe sync "frontend\public\Course" b2://ScripArc/Course
echo Sync complete!
pause
