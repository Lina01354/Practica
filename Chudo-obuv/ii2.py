tables = input("названия табл: ").split()
print(f"[info] Таблиц: {len(tables)}\n")
# Справочник автозамены: {"Название": "ID"}
lookup = {}
for table in tables:
    cols = input(f"названия столбцов таблицы {table}: ").replace(',', ' ').split()
    print(f"ввод данных для таблицы {table}:\n(вставь строки из Excel, затем пустая строка для завершения)")
    rows = []
    while True:
        line = input()
        if not line.strip():
            break
        # Excel при вставке разделяет ячейки табуляцией '\t'
        raw = line.split('\t') if '\t' in line else line.split('  ')
        row = []
        for v in raw:
            v = v.strip()
            key = v.strip('"\'')
            # 1. Замена текста на ID, если такое имя уже встречалось
            if key in lookup:
                row.append(str(lookup[key]))
            # 2. Числа и NULL оставляем как есть
            elif not v or v.upper() == 'NULL':
                row.append('NULL')
            elif v.replace('.', '', 1).replace('-', '', 1).isdigit():
                row.append(v)
            # 3. Текст оборачиваем в кавычки
            else:
                row.append(f'"{v}"')
        rows.append(row)
        # Сохраняем в справочник: если 1-й столбец число (ID), а 2-й — название
        if len(raw) >= 2 and raw[0].strip().isdigit():
            lookup[raw[1].strip('"\'')] = raw[0].strip()
    # Генерация SQL INSERT
    print(f"\nINSERT INTO {table} ({', '.join(cols)}) VALUES")
    for i, r in enumerate(rows):
        end = ',' if i < len(rows) - 1 else ';'
        print(f"({', '.join(r)}){end}")
    print()