# Скрипт для загрузки на GitHub с поиском Git в системе

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Загрузка проекта на GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Поиск Git в стандартных местах
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\bin\git.exe",
    "$env:ProgramFiles\Git\cmd\git.exe"
)

$gitFound = $false
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitDir = Split-Path $path
        $env:Path = "$gitDir;$env:Path"
        Write-Host "Git найден: $path" -ForegroundColor Green
        $gitFound = $true
        break
    }
}

# Проверка через Get-Command
if (-not $gitFound) {
    $gitCmd = Get-Command git -ErrorAction SilentlyContinue
    if ($gitCmd) {
        Write-Host "Git найден через PATH: $($gitCmd.Source)" -ForegroundColor Green
        $gitFound = $true
    }
}

if (-not $gitFound) {
    Write-Host "ОШИБКА: Git не найден в системе!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Возможные решения:" -ForegroundColor Yellow
    Write-Host "1. Перезапустите PowerShell после установки Git" -ForegroundColor Yellow
    Write-Host "2. Добавьте Git в PATH вручную" -ForegroundColor Yellow
    Write-Host "3. Используйте полный путь к git.exe" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Или загрузите через ZIP-архив:" -ForegroundColor Cyan
    Write-Host "C:\Users\super\telegram-shipping-bot.zip" -ForegroundColor Cyan
    pause
    exit
}

# Переход в папку проекта
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath
Write-Host "Рабочая папка: $scriptPath" -ForegroundColor Gray
Write-Host ""

# Инициализация git
Write-Host "[1/5] Инициализация git..." -ForegroundColor Cyan
& git init
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось инициализировать git" -ForegroundColor Red
    pause
    exit
}

# Добавление файлов
Write-Host "[2/5] Добавление файлов..." -ForegroundColor Cyan
& git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось добавить файлы" -ForegroundColor Red
    pause
    exit
}

# Коммит
Write-Host "[3/5] Создание коммита..." -ForegroundColor Cyan
& git commit -m "Initial commit: Modern Telegram shipping bot with OxaPay integration"
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось создать коммит" -ForegroundColor Red
    pause
    exit
}

# Настройка remote
Write-Host "[4/5] Настройка remote..." -ForegroundColor Cyan
& git remote remove origin 2>$null
& git remote add origin https://github.com/bryanwax12/newbotcursor.git
& git branch -M main

# Push
Write-Host "[5/5] Загрузка на GitHub..." -ForegroundColor Cyan
Write-Host ""
Write-Host "ВНИМАНИЕ: Используйте Personal Access Token вместо пароля!" -ForegroundColor Yellow
Write-Host "Создайте токен: https://github.com/settings/tokens" -ForegroundColor Yellow
Write-Host ""

& git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "УСПЕХ! Код загружен на GitHub" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Репозиторий: https://github.com/bryanwax12/newbotcursor" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "ОШИБКА при загрузке" -ForegroundColor Red
    Write-Host "Проверьте учетные данные или используйте Personal Access Token" -ForegroundColor Yellow
}

pause

