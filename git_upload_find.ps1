# Скрипт для поиска Git и загрузки на GitHub

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Поиск Git и загрузка на GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Поиск Git в стандартных местах
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\bin\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe",
    "$env:ProgramFiles(x86)\Git\bin\git.exe"
)

$gitExe = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitExe = $path
        Write-Host "Git найден: $path" -ForegroundColor Green
        break
    }
}

# Проверка через where.exe
if (-not $gitExe) {
    $whereResult = where.exe git 2>$null
    if ($whereResult) {
        $gitExe = "git"
        Write-Host "Git найден через PATH: $whereResult" -ForegroundColor Green
    }
}

if (-not $gitExe) {
    Write-Host ""
    Write-Host "ОШИБКА: Git не найден!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Возможные решения:" -ForegroundColor Yellow
    Write-Host "1. Перезапустите PowerShell (Git может быть не в PATH)" -ForegroundColor Yellow
    Write-Host "2. Установите Git: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "3. Добавьте Git в PATH вручную" -ForegroundColor Yellow
    pause
    exit
}

# Переход в папку проекта
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath
Write-Host "Рабочая папка: $scriptPath" -ForegroundColor Gray
Write-Host ""

# Используем найденный Git
if ($gitExe -ne "git") {
    $env:PATH = "$(Split-Path -Parent $gitExe);$env:PATH"
}

Write-Host "[1/6] Инициализация git..." -ForegroundColor Cyan
& $gitExe init
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось инициализировать git" -ForegroundColor Red
    pause
    exit
}

Write-Host "[2/6] Добавление файлов..." -ForegroundColor Cyan
& $gitExe add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось добавить файлы" -ForegroundColor Red
    pause
    exit
}

Write-Host "[3/6] Создание коммита..." -ForegroundColor Cyan
& $gitExe commit -m "Initial commit: Modern Telegram shipping bot with OxaPay integration"
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось создать коммит" -ForegroundColor Red
    pause
    exit
}

Write-Host "[4/6] Настройка remote..." -ForegroundColor Cyan
& $gitExe remote remove origin 2>$null
& $gitExe remote add origin https://github.com/bryanwax12/newbotcursor.git
& $gitExe branch -M main

Write-Host "[5/6] Проверка remote..." -ForegroundColor Cyan
& $gitExe remote -v

Write-Host "[6/6] Загрузка на GitHub..." -ForegroundColor Cyan
Write-Host ""
Write-Host "ВНИМАНИЕ: Вам нужно будет ввести учетные данные GitHub" -ForegroundColor Yellow
Write-Host "Используйте Personal Access Token вместо пароля" -ForegroundColor Yellow
Write-Host "Создайте токен: https://github.com/settings/tokens" -ForegroundColor Yellow
Write-Host ""

& $gitExe push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "УСПЕХ! Код загружен на GitHub" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Репозиторий: https://github.com/bryanwax12/newbotcursor" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "ОШИБКА при загрузке" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Возможные причины:" -ForegroundColor Yellow
    Write-Host "1. Неправильные учетные данные" -ForegroundColor Yellow
    Write-Host "2. Нужен Personal Access Token" -ForegroundColor Yellow
    Write-Host "3. Репозиторий не существует или нет доступа" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Создайте токен: https://github.com/settings/tokens" -ForegroundColor Cyan
}

pause

