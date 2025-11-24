# Скрипт для создания ZIP-архива проекта

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Создание ZIP-архива проекта" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

$zipPath = "C:\Users\super\telegram-shipping-bot.zip"

# Удаляем старый архив если есть
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
    Write-Host "Удален старый архив" -ForegroundColor Yellow
}

Write-Host "Создание архива..." -ForegroundColor Cyan

# Получаем все файлы, исключая ненужные
$files = Get-ChildItem -Recurse -File | Where-Object {
    $_.FullName -notmatch '\.env$' -and
    $_.FullName -notmatch '__pycache__' -and
    $_.FullName -notmatch '\.pyc$' -and
    $_.FullName -notmatch 'venv\\' -and
    $_.FullName -notmatch '\.git\\' -and
    $_.Name -ne 'telegram-shipping-bot.zip'
}

# Создаем архив
$files | Compress-Archive -DestinationPath $zipPath -Force

if (Test-Path $zipPath) {
    $size = (Get-Item $zipPath).Length / 1MB
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✅ Архив успешно создан!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Расположение: $zipPath" -ForegroundColor Cyan
    Write-Host "Размер: $([math]::Round($size, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Теперь загрузите этот файл на GitHub:" -ForegroundColor Yellow
    Write-Host "https://github.com/bryanwax12/newbotcursor" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Add file → Upload files → перетащите архив" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "❌ Ошибка при создании архива" -ForegroundColor Red
}

pause

