# !!!
# Перед запуском скрипта необходимо убедиться, что внешний диск примонтирован под буквой D, иначе внести изменения в $destinationFolder!!!
# !!!

# Указываем путь к папке, из которой нужно копировать файлы
$sourceFolder = "C:\Program Files (x86)\Kodeks\Techexpert-Intranet\Base\bases"

# Указываем путь к папке, в которую нужно скопировать файлы
$destinationFolder = "D:\Base"

# Определяем дату, от которой будем копировать файлы (2 месяца назад от текущей даты)
$cutOffDate = (Get-Date).AddMonths(-2)

# Получаем список файлов из файла base.txt
$baseFiles = Get-Content "C:\external disk\base.txt"

# Получаем список файлов, измененных позже, чем $cutOffDate, и указанных в base.txt
$filesToCopy = Get-ChildItem -Path $sourceFolder | Where-Object { $_.LastWriteTime -ge $cutOffDate -and $baseFiles.Contains($_.Name) }

# Инициализируем переменные для отслеживания прогресса копирования
$totalFiles = $filesToCopy.Count
$counter = 0

# Копируем файлы в папку $destinationFolder и выводим сообщение о количестве скопированных файлов
foreach ($file in $filesToCopy) {
    $counter++
    $percentComplete = ($counter / $totalFiles) * 100

    Write-Progress -Activity "Copying files..." -Status "Copying file $($file.Name)..." -PercentComplete $percentComplete

    Copy-Item $file.FullName $destinationFolder
}

    Write-Host "Копирование завершено. Скопировано $($filesToCopy.Count) файлов."
