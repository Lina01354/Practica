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

def katalog(event=None):
    for widget in scrol_frame.winfo_children():
        widget.destroy()

    try:
        #код для вывода данных из бд + запрос на количество
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

        # ФИЛЬТРАЦИЯ: читаем прямо из комбобокса
        vybor = c_categoria.get()
        if vybor not in ["Все категории"]:
            # Если выбрано "Детская обувь", берем первое слово: "детская"
            poisk_slovo = vybor.split()[0].lower()
            # Оставляем только те строки, где категория из БД содержит это слово
            rows = [r for r in rows if r[1] and poisk_slovo in str(r[1]).lower()]

        # СОРТИРОВКА ПО ЦЕНЕ
        sort_zena = c_zena.get()
        if sort_zena == "мин --> макс":
            rows.sort(key=lambda r: float(r[6]))
        elif sort_zena == "макс --> мин":
            rows.sort(key=lambda r: float(r[6]), reverse=True)

        query = e_poisk.get().strip().lower()
        if query:
            rows = [r for r in rows if query in str(r[0]).lower() or query in str(r[3]).lower()]

        for idx, row in enumerate(rows):
            f_pozicia = tk.Frame(scrol_frame, relief="solid", bd=1)
            f_pozicia.grid(row=idx+3, column=0, pady=(15, 0), sticky="w")

            f_img = tk.Frame(f_pozicia, height=85, width=85, bg="grey")
            f_img.pack_propagate(False)
            f_img.grid(row=0, column=0, padx=5)

            if row[2]:  # Если имя файла есть в БД (row[2] — это m.img)
                try:
                    raw_img = tk.PhotoImage(file=f"Images/{row[2]}")
                    
                    # Считаем, во сколько раз нужно уменьшить картинку, чтобы влезла в 85px
                    scale = max(1, raw_img.width() // 85, raw_img.height() // 85)
                    img = raw_img.subsample(scale, scale)

                    l_img = tk.Label(f_img, image=img, bg="grey")
                    l_img.image = img  # сохраняем ссылку
                    l_img.pack(expand=True)
                except Exception:
                    pass

            f_text = tk.Frame(f_pozicia)
            f_text.grid(row=0, column=1, padx=5)
            f_text.grid_columnconfigure(0, minsize=650)

            l_title = tk.Label(f_text, text=f"{row[3]} | {row[0]}", font=("Calibri", 12, "bold"))
            l_title.grid(row=0, column=0)

            l_cat = tk.Label(f_text, text=f"Категория: {row[1]}", font=("Calibri", 11))
            l_cat.grid(row=1, column=0, sticky="w")

            kolvo_color = "#ff8080" if row[7] < 3 else "black"

            l_kolvo = tk.Label(f_text, text=f"В наличии: {row[7]} шт.", font=("Calibri", 11), fg=kolvo_color)
            l_kolvo.grid(row=3, column=0, sticky="w", pady=2)

            l_sostav = tk.Label(f_text, text=f"Состав: {row[5]}", font=("Calibri", 10), justify="left", wraplength=600)
            l_sostav.grid(row=4, column=0, sticky="w")

            l_zena = tk.Label(f_text, text=f"{row[6]} руб.", font=("Calibri", 12))
            l_zena.grid(row=0, column=2, padx=2, sticky="e", pady=(15, 0))

        cur.close()
        con.close()

    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))

def go_to_registration():
    f_katalog.pack_forget() 
    f_registracia.pack() 


window = tk.Tk()
window.title("Chudo-obuv")
window.geometry("1200x750")

f_katalog = tk.Frame(window)
f_katalog.pack()

b_vhod = tk.Button(f_katalog, text="Вход", command=go_to_registration, bg="#70b2af")
b_vhod.grid(row=0, column=1)

f_filtri = tk.Frame(f_katalog)
f_filtri.grid(row=1, column=0, pady=5)

l_poisk = tk.Label(f_filtri, text="Найти:")
l_poisk.grid(row=0, column=0)

e_poisk = tk.Entry(f_filtri, width=48)
e_poisk.grid(row=0, column=1, padx=2)

e_poisk.bind("<KeyRelease>", katalog)

c_categoria_znachenia = ["Все категории", "Детская обувь", "Женская обувь", "мужская обувь"]
c_categoria = ttk.Combobox(f_filtri, values=c_categoria_znachenia, width=13, state="readonly")
c_categoria.set("Все категории") 
c_categoria.grid(row=0, column=2, padx=5)

c_categoria.bind("<<ComboboxSelected>>", katalog)

c_zena_znachenia = ["мин --> макс", "макс --> мин"]
c_zena = ttk.Combobox(f_filtri, value=c_zena_znachenia, width=13, state="readonly")
c_zena.set("Цена")
c_zena.grid(row=0, column=3)

c_zena.bind("<<ComboboxSelected>>", katalog)

# 1. Создаем холст
c_katalog = tk.Canvas(f_katalog, width=900, height=650, highlightthickness=0)
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
#d2f6e7 - доп фон
#70b2af - акцент
#ff8080 - меньше 2