import tkinter as tk
from tkinter import ttk, messagebox
import psycopg2

BD_CONFIG = {
    "host" : "localhost",
    "database" : "Demo_3",
    "user" : "postgres",
    "password" : "okna2301",
    "port" : "5432"
}

def get_user_fio(login):
    conn = psycopg2.connect(**BD_CONFIG)
    try:
        with conn.cursor() as cur:
            cur.execute('''
                SELECT name_users, fam_users, otch_users
                FROM users
                WHERE login_users = %s;''', (login,))

            row = cur.fetchone()
            if row:
                return f"{row[1]} {row[0]} {row[2] or ''}".strip()
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))
    finally:  # Этот блок выполнится в любом случае (была ошибка или нет)
        conn.close()  # Обязательно закрываем соединение с базой данных
    return None

def handle_login():  # Вложенная функция для обработки процесса авторизации
    frame.pack_forget() 
    f_reg.pack()
    login = e_log.get().strip()  # Считываем текст из поля ввода и удаляем случайные пробелы по краям
    if not login:  # Если поле оказалось пустым
        messagebox.showwarning("Ошибка", "Введите логин!")  # Показываем предупреждение о необходимости ввода
        return  # Прерываем выполнение функции
        
    fio = get_user_fio(login)  # Вызываем функцию поиска пользователя в БД по введенному логину
    if fio:  # Если ФИО успешно найдено (пользователь существует)
        f_reg.pack_forget()  
        frame.pack() 
        tk.Label(frame, text=f"Добро пожаловать,\n{fio}!", font=("Arial", 18, "bold"), pady=30).grid(row=0, column=0, sticky="e", padx=3, pady=3)
    else:  # Если функция поиска вернула None
        messagebox.showerror("Ошибка", "Пользователь не найден!")  # Показываем окно с ошибкой авторизации




def fetch_users():
    try:
        # Открываем соединение с базой данных PostgreSQL, используя ранее заданные константы
        conn = psycopg2.connect(**BD_CONFIG)

        # Создаем курсор — инструмент для выполнения SQL-запросов и получения их результатов
        cur = conn.cursor()

        # Выполняем SQL-запрос. Используется LEFT JOIN для объединения таблицы пользователей (users)
        # и ролей (roles), чтобы вместо числового role_id вывести понятное название роли (role_name)
        cur.execute("""
            SELECT m.name_models, c.name_categoria, m.img, m.prooizvodstvo, m.opisanie, m.coctav, m.zena
            FROM models m
            LEFT JOIN categoria c ON m.id_categoria = c.id_categoria
            ORDER BY m.id_models ASC;
        """)

        # Извлекаем все строки, которые вернул SQL-запрос, в переменную rows (список кортежей)
        rows = cur.fetchall()
        for idx, row in enumerate(rows):
            # Шаблон карточки товара (начинаем размещать карточки с 3-й строки и ниже)
            f_kart = tk.Frame(frame, width=300, bg="white", bd=1, relief="groove")
            f_kart.grid(row=3 + idx, column=0, sticky="we", padx=5, pady=5)
        
            # Поле для картинки
            img_container = tk.Frame(f_kart, width=70, height=70, bg="grey", bd=2, relief="sunken")
            img_container.pack_propagate(False)
            img_container.grid(row=0, column=0, sticky="w", padx=5, pady=5)
        
            # Внутренняя метка для картинки
            label_img_display = tk.Label(img_container, bg="grey")
            label_img_display.pack(expand=True)

            # Правый фрейм с текстовыми данными
            f_text = tk.Frame(f_kart, width=300, bg="white")
            f_text.grid(row=0, column=2, sticky="w", padx=5, pady=5)
            
            # Название товара (row[0])
            lbl_name = tk.Label(f_text, text=row[0], font=("Calibri", 12, "bold"), bg="white")
            lbl_name.grid(row=0, column=0, sticky="w")
            
            # Вспомогательная строка (Категория * Производитель)
            f_cat = tk.Frame(f_text, bg="white")
            f_cat.grid(row=1, column=0, sticky="w")
            
            lbl_cat = tk.Label(f_cat, text=row[1] if row[1] else "Без категории", font=("Calibri", 7), bg="white")
            lbl_cat.grid(row=0, column=0, sticky="w")
            
            lbl_star = tk.Label(f_cat, text=" * ", font=("Calibri", 7), bg="white")
            lbl_star.grid(row=0, column=1, sticky="w")
            
            lbl_proiz = tk.Label(f_cat, text=row[3] if row[3] else "Неизвестно", font=("Calibri", 7), bg="white")
            lbl_proiz.grid(row=0, column=2, sticky="w")
            
            # Описание товара (row[4])
            lbl_desc = tk.Label(f_text, text=row[4] if row[4] else "Описание отсутствует", font=("Calibri", 10), wraplength=300, justify="left", bg="white")
            lbl_desc.grid(row=2, column=0, sticky="w", pady=(0,5))
            
            # Цена товара (row[6])
            lbl_price = tk.Label(f_text, text=f"{row[6]} руб.", font=("Calibri", 15), bg="white", fg="green")
            lbl_price.grid(row=3, column=0, sticky="e")

        # Закрываем курсор и соединение с БД, чтобы освободить ресурсы сервера
        cur.close()
        conn.close()

    except Exception as e:
        # Если на каком-то этапе (подключение, запрос) произошла ошибка, показываем всплывающее окно с её текстом
        messagebox.showerror("Ошибка БД", str(e))

# Функции перехода между страницами
def go_to_registration():
    frame.pack_forget() 
    f_reg.pack()      

def go_to_shop():
    f_reg.pack_forget()  
    frame.pack()         

window = tk.Tk()
window.title("calc")
window.geometry("1000x750")

#Создаем страницу каталога
frame = tk.Frame(window, bg="lightblue")
frame.pack()

button1 = tk.Button(frame, text="Вход", command=go_to_registration)
button1.grid(row=0, column=1, sticky="e", padx=3, pady=3)

label = tk.Label(frame, text="Магазин 'Чудо-обувь'", font=("Calibri", 20))
label.grid(row=1, column=0, sticky="s", padx=5, pady=5)

#фрейм с фильтрами
f_filtr = tk.Frame(frame, width=300, bg="white")
f_filtr.grid(row=2, column=0, sticky="s")

l_filtr = tk.Label(f_filtr, text="Найти:")
l_filtr.grid(row=0, column=0)

e_filtr = tk.Entry(f_filtr)
e_filtr.grid(row=0, column=1)

#выпадающие окна
shoe_sizes = ["38", "39", "40", "41", "42"]
size_combo = ttk.Combobox(f_filtr, values=shoe_sizes, width=10, state="readonly")
size_combo.set("Размер") 
size_combo.grid(row=0, column=2)

kat = ["Детская обувь", "Женская обувь", "Мужская обувь"]
kat_combo = ttk.Combobox(f_filtr, values=kat, width=18, state="readonly")
kat_combo.set("Категория обуви") 
kat_combo.grid(row=0, column=3)

#страница регистрации
f_reg = tk.Frame(window)

l_reg = tk.Label(f_reg, text="Registracia")
l_reg.grid(row=0, column=0)

f_log = tk.Frame(f_reg)
f_log.grid(row=1, column=0)

l_log = tk.Label(f_log, text="login")
l_log.grid(row=0, column=0)

e_log = tk.Entry(f_log)
e_log.grid(row=0, column=1)
e_log.focus()

b_reg = tk.Button(f_reg, text="Вход", command=handle_login)
b_reg.grid(row=2, column=0)

fetch_users()

window.mainloop()
