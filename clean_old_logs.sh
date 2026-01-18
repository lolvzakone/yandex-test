#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Использование: $0 <путь_к_директории> <количество_дней>"
    echo "Пример: $0 /var/log 7"
    exit 1
fi

LOG_DIR="$1"
DAYS="$2"
# 2. Проверка директории
if [ ! -d "$LOG_DIR" ]; then
    echo "Ошибка: Директория '$LOG_DIR' не существует!"
    exit 1
fi
echo "Поиск .log файлов старше $DAYS дней в $LOG_DIR..."
OLD_LOGS=$(find "$LOG_DIR" -name "*.log" -mtime +$DAYS 2>/dev/null)

if [ -z "$OLD_LOGS" ]; then
    echo "Старых .log файлов не найдено."
    exit 0
fi

# 4. Вывод списка файлов
echo "Найдены файлы для удаления:"
echo "$OLD_LOGS"
echo "-------------------------"

# 5. Запрос подтверждения
echo -n "Удалить эти файлы? (y/n): "
read answer

# 6. Удаление при подтверждении
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "Удаление файлов..."
    echo "$OLD_LOGS" | xargs rm -f
    echo "Готово!"
else
    echo "Операция отменена."
fi
