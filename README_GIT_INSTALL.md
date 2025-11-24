# Git не установлен - Решение

## Проблема
Git не установлен в системе, поэтому автоматическая загрузка невозможна.

## Решение 1: Установить Git автоматически

1. Запустите скрипт `install_git_and_upload.ps1` (правой кнопкой → "Запустить с PowerShell")
2. Скрипт попытается установить Git через winget
3. После установки перезапустите PowerShell и запустите скрипт снова

## Решение 2: Установить Git вручную

1. Откройте: https://git-scm.com/download/win
2. Скачайте установщик
3. Установите Git (оставьте все настройки по умолчанию)
4. Перезапустите PowerShell
5. Запустите `install_git_and_upload.ps1` или выполните команды вручную

## Решение 3: Загрузить через веб-интерфейс GitHub

1. Откройте: https://github.com/bryanwax12/newbotcursor
2. Нажмите "uploading an existing file"
3. Перетащите все файлы из папки `REFACTORINGBOT11` (кроме `.env`)
4. Нажмите "Commit changes"

## Решение 4: Использовать GitHub Desktop

1. Скачайте GitHub Desktop: https://desktop.github.com/
2. Установите и авторизуйтесь
3. File → Add Local Repository
4. Выберите папку `REFACTORINGBOT11`
5. Нажмите "Publish repository"

## После установки Git

Выполните в PowerShell:

```powershell
cd C:\Users\super\REFACTORINGBOT11
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/bryanwax12/newbotcursor.git
git branch -M main
git push -u origin main
```

При запросе пароля используйте Personal Access Token.

