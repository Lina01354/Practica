import tkinter as tk
from tkinter import ttk, messagebox
import psycopg2

BD_CON = {
    "host" : "localhost",
    "database" : "Demo_3",
    "user" : "postgres",
    "password" : "okna2301",
    "port" : "5432"
}


def get_fio(login):
    con = psycopg2.connect(**BD_CON)
    try:
        cur = con.cursor()
        cur.execute('''
            SELECT name_users, fam_users, otch_users
            FROM users
            WHERE login_users = %s;''', (login,))
        row = cur.fetchone()
        if row:
            return f"{row[1]} {row[0]} {row[2] or ''}".strip()
    except Exception as e:
            messagebox.showerror("Ошибка", str(e))
    finally:
        cur.close()
        con.close()
    return None

def get_login():
    f_katalog.pack_forget()
    f_registracia.pack()
    login = e_login.get().strip()
    if not login:
        messagebox.showwarning("Ошибка", "Введите логин!")
        return

    fio = get_fio(login)
    if fio:
        f_registracia.pack_forget()
        f_katalog.pack()
        l_fio = tk.Label(f_katalog, text=f"Добро пожаловать, {fio}", font=("Arial", 10, "bold"))
        l_fio.grid(row=0, column=0)
    else:
        messagebox.showerror("Ошибка", "Пользователь не найден!")

def katalog():
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute('''
            SELECT m.name_models, c.name_categoria, m.img, m.prooizvodstvo, m.opisanie, m.coctav, m.zena, COALESCE(SUM(mr.count_m), 0) AS count_model
            FROM models m
            LEFT JOIN categoria c ON m.id_categoria = c.id_categoria
            LEFT JOIN model_razmer mr ON m.id_models = mr.id_models
            GROUP BY m.id_models, m.name_models, c.name_categoria, m.img, m.prooizvodstvo, m.opisanie, m.coctav, m.zena
            ORDER BY m.id_models ASC;
        ''')

        rows = cur.fetchall()
        for idx, row in enumerate(rows):
            f_pozicia = tk.Frame(scrol_frame)
            f_pozicia.grid(row=idx+3, column=0, pady=(15, 0))

            f_img = tk.Frame(f_pozicia, height=75, width=75, bg="grey")
            f_img.pack_propagate(False)
            f_img.grid(row=0, column=0, padx=5)

            f_text = tk.Frame(f_pozicia)
            f_text.grid(row=0, column=1, padx=5)
            f_text.grid_columnconfigure(0, minsize=480)

            l_model_name = tk.Label(f_text, text=row[0], font=("Calibri", 12, "bold"))
            l_model_name.grid(row=0, column=0)

            l_proizvoditel = tk.Label(f_text, text=f"Производитель: {row[3]}" if row[3] else "Производитель не указан", font=("Calibri", 8))
            l_proizvoditel.grid(row=1, column=0, sticky="w")

            l_opisanie = tk.Label(f_text, text=row[4] if row[4] else "Описания нет", font=("Calibri", 10), justify="left", wraplength=480)
            l_opisanie.grid(row=2, column=0, sticky="w")

            kolvo_color = "red" if row[7] < 3 else "gray"

            l_kolvo = tk.Label(f_text, text=f"В наличии: {row[7]} шт.", font=("Calibri", 10, "italic"), fg=kolvo_color)
            l_kolvo.grid(row=3, column=0, sticky="w", pady=2)

            l_zena = tk.Label(f_text, text=f"{row[6]} руб.", font=("Calibri", 12))
            l_zena.grid(row=4, column=0, sticky="e")

        cur.close()
        con.close()

    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))

def go_to_registration():
    f_katalog.pack_forget() 
    f_registracia.pack() 


window = tk.Tk()
window.title("Chudo-obuv")
window.geometry("1000x750")

f_katalog = tk.Frame(window)
f_katalog.pack()

b_vhod = tk.Button(f_katalog, text="Вход", command=go_to_registration)
b_vhod.grid(row=0, column=1)

f_filtri = tk.Frame(f_katalog)
f_filtri.grid(row=1, column=0)

l_poisk = tk.Label(f_filtri, text="Найти:")
l_poisk.grid(row=0, column=0)

e_poisk = tk.Entry(f_filtri, width=48)
e_poisk.grid(row=0, column=1, padx=2)

c_size_znachenia = ["38", "39", "40", "41", "42"]
c_size = ttk.Combobox(f_filtri, values=c_size_znachenia, width=8, state="readonly")
c_size.set("Размер") 
c_size.grid(row=0, column=2, padx=5)

c_categoria_znachenia = ["Детская обувь", "Женская обувь", "мужская обувь"]
c_categoria = ttk.Combobox(f_filtri, value=c_categoria_znachenia, width=13, state="readonly")
c_categoria.set("Категория")
c_categoria.grid(row=0, column=3)

# 1. Создаем холст
c_katalog = tk.Canvas(f_katalog, width=650, height=650, highlightthickness=0)
c_katalog.grid(row=2, column=0, sticky="nsew")

# 2. Создаем скроллбар
scrol = ttk.Scrollbar(f_katalog, orient="vertical", command=c_katalog.yview)
scrol.grid(row=2, column=1, sticky="ns")

# 3. Создаем внутренний фрейм
scrol_frame = tk.Frame(c_katalog)

# --- ПЕРВЫЙ БИНД: для высоты скролла (уже был) ---
scrol_frame.bind(
    "<Configure>",
    lambda e: c_katalog.configure(scrollregion=c_katalog.bbox("all"))
)

# 4. Кладем фрейм в холст и ЗАПОМИНАЕМ его в переменную 'canvas_frame'
canvas_frame = c_katalog.create_window((0, 0), window=scrol_frame, anchor="nw")

# --- ВТОРОЙ БИНД: для ширины карточек (добавляем) ---
# Он заставляет внутренний фрейм растягиваться по ширине холста
c_katalog.bind("<Configure>", lambda e: c_katalog.itemconfig(canvas_frame, width=e.width))

# 5. Связываем их
c_katalog.configure(yscrollcommand=scrol.set)



f_registracia = tk.Frame(window)

f_login = tk.Frame(f_registracia)
f_login.grid(row=0, column=0)

l_login = tk.Label(f_login, text="Логин:", font=("Calibri", 10))
l_login.grid(row=0, column=0)

e_login = tk.Entry(f_login)
e_login.grid(row=0, column=1)

b_registracia = tk.Button(f_registracia, text="Вход", command=get_login)
b_registracia.grid(row=1, column=0)

katalog()
window.mainloop()