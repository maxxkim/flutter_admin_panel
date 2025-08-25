#!/bin/bash

# Скрипт для объединения всех .dart файлов в один файл
# Использование: ./combine_dart_files.sh [входная_папка] [выходной_файл]

# Параметры по умолчанию
INPUT_DIR="${1:-.}"  # Текущая папка, если не указана другая
OUTPUT_FILE="${2:-combined_dart_files.txt}"  # Имя выходного файла по умолчанию

# Проверяем существование входной директории
if [ ! -d "$INPUT_DIR" ]; then
    echo "Ошибка: Директория '$INPUT_DIR' не существует!"
    exit 1
fi

# Создаем или очищаем выходной файл
> "$OUTPUT_FILE"

# Счетчик найденных файлов
file_count=0

echo "Поиск .dart файлов в директории: $INPUT_DIR"
echo "Результат будет сохранен в: $OUTPUT_FILE"
echo ""

# Добавляем заголовок в выходной файл
echo "====================================================================" >> "$OUTPUT_FILE"
echo "ОБЪЕДИНЕННЫЕ DART ФАЙЛЫ" >> "$OUTPUT_FILE"
echo "Сгенерировано: $(date)" >> "$OUTPUT_FILE"
echo "Исходная директория: $(realpath "$INPUT_DIR")" >> "$OUTPUT_FILE"
echo "====================================================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Находим все .dart файлы и обрабатываем их
find "$INPUT_DIR" -name "*.dart" -type f | sort | while read -r dart_file; do
    # Получаем относительный путь от входной директории
    relative_path=$(realpath --relative-to="$INPUT_DIR" "$dart_file")
    
    echo "Обрабатывается: $relative_path"
    
    # Добавляем разделитель и информацию о файле
    echo "" >> "$OUTPUT_FILE"
    echo "###################################################################" >> "$OUTPUT_FILE"
    echo "# ФАЙЛ: $relative_path" >> "$OUTPUT_FILE"
    echo "# ПОЛНЫЙ ПУТЬ: $dart_file" >> "$OUTPUT_FILE"
    echo "# РАЗМЕР: $(stat -c%s "$dart_file") байт" >> "$OUTPUT_FILE"
    echo "# ИЗМЕНЕН: $(stat -c%y "$dart_file")" >> "$OUTPUT_FILE"
    echo "###################################################################" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Добавляем содержимое файла
    cat "$dart_file" >> "$OUTPUT_FILE"
    
    # Добавляем разделитель в конце файла
    echo "" >> "$OUTPUT_FILE"
    echo "# КОНЕЦ ФАЙЛА: $relative_path" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    ((file_count++))
done

# Добавляем итоговую информацию
echo "" >> "$OUTPUT_FILE"
echo "====================================================================" >> "$OUTPUT_FILE"
echo "ИТОГО ОБРАБОТАНО ФАЙЛОВ: $file_count" >> "$OUTPUT_FILE"
echo "ЗАВЕРШЕНО: $(date)" >> "$OUTPUT_FILE"
echo "====================================================================" >> "$OUTPUT_FILE"

echo ""
echo "Готово! Обработано $file_count .dart файлов."
echo "Результат сохранен в: $OUTPUT_FILE"

# Показываем размер итогового файла
if [ -f "$OUTPUT_FILE" ]; then
    file_size=$(stat -c%s "$OUTPUT_FILE")
    echo "Размер итогового файла: $file_size байт"
fi