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

current_user_id = 0
cart = []


def get_fio(login):
    global current_user_id
    con = psycopg2.connect(**BD_CON)
    try:
        cur = con.cursor()
        cur.execute('''
            SELECT name_users, fam_users, otch_users
            FROM users
            WHERE login_users = %s;''', (login,))
        row = cur.fetchone()
        if row:
            current_user_id = row[0]
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
        f_glav.pack()
        l_fio = tk.Label(f_head, text=f"Добро пожаловать, {fio}", font=("Arial", 10, "bold"), bg="#d2f6e7")
        l_fio.grid(row=0, column=0)
    else:
        messagebox.showerror("Ошибка", "Пользователь не найден!")

def get_categories():
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT name_categoria FROM categoria;")
        cats = ["Все категории"] + [r[0] for r in cur.fetchall()]
        cur.close()
        con.close()
        return cats
    except Exception:
        return ["Все категории"]


def katalog(event=None):
    for widget in scrol_frame.winfo_children():
        widget.destroy()

    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute('''
            SELECT m.id_models, m.name_models, c.name_categoria, m.img, m.prooizvodstvo, m.opisanie, m.coctav, m.zena, COALESCE(SUM(mr.count_m), 0) AS count_model
            FROM models m
            LEFT JOIN categoria c ON m.id_categoria = c.id_categoria
            LEFT JOIN model_razmer mr ON m.id_models = mr.id_models
            GROUP BY m.id_models, m.name_models, c.name_categoria, m.img, m.prooizvodstvo, m.opisanie, m.coctav, m.zena
            ORDER BY m.id_models ASC;
        ''')

        rows = cur.fetchall()

        vybor = c_categoria.get()
        if vybor and vybor != "Все категории":
            rows = [r for r in rows if r[2] == vybor]

        sort_zena = c_zena.get()
        if sort_zena == "мин --> макс":
            rows.sort(key=lambda r: float(r[7]))
        elif sort_zena == "макс --> мин":
            rows.sort(key=lambda r: float(r[7]), reverse=True)

        query = e_poisk.get().strip().lower()
        if query:
            rows = [r for r in rows if query in str(r[0]).lower()]

        for idx, row in enumerate(rows):
            f_pozicia = tk.Frame(scrol_frame, relief="solid", bd=1)
            f_pozicia.grid(row=idx+3, column=0, padx=32, pady=(15, 0), sticky="w")

            f_img = tk.Frame(f_pozicia, height=85, width=85, bg="#d2f6e7")
            f_img.pack_propagate(False)
            f_img.grid(row=0, column=0, padx=5)

            try:
                raw_img = tk.PhotoImage(file=f"Images/{row[3]}")
            except Exception:
                raw_img = tk.PhotoImage(file="Images/picture.png")

            scale = max(1, raw_img.width() // 85, raw_img.height() // 85)
            img = raw_img.subsample(scale, scale)

            l_img = tk.Label(f_img, image=img, bg="#d2f6e7")
            l_img.image = img 
            l_img.pack(expand=True)

            f_text = tk.Frame(f_pozicia)
            f_text.grid(row=0, column=1, padx=5)
            f_text.grid_columnconfigure(0, minsize=630)

            l_title = tk.Label(f_text, text=f"{row[4]} | {row[1]}", font=("Calibri", 12, "bold"))
            l_title.grid(row=0, column=0)

            l_cat = tk.Label(f_text, text=f"Категория: {row[2]}", font=("Calibri", 11))
            l_cat.grid(row=1, column=0, sticky="w")

            kolvo_color = "#ff8080" if row[8] < 3 else "black"

            l_kolvo = tk.Label(f_text, text=f"В наличии: {row[8]} шт.", font=("Calibri", 11), fg=kolvo_color)
            l_kolvo.grid(row=2, column=0, sticky="w", pady=2)

            l_sostav = tk.Label(f_text, text=f"Состав: {row[6]}", font=("Calibri", 10), justify="left", wraplength=600)
            l_sostav.grid(row=3, column=0, sticky="w")

            f_knopki = tk.Frame(f_pozicia)
            f_knopki.grid(row=0, column=2, padx=(0, 10))

            l_zena = tk.Label(f_knopki, text=f"{row[7]} руб.", font=("Calibri", 12))
            l_zena.grid(row=0, column=0, padx=2, sticky="e", pady=(10, 0))

            b_detali = tk.Button(f_knopki, text="Подробнее", width=11, bg="#70b2af", command=lambda r=row: open_detail(r))
            b_detali.grid(row=2, column=0, pady=(4,0))

            b_zakaz = tk.Button(f_knopki, text="Заказать", width=11, bg="#70b2af", command=lambda m_id=row[0], m_name=row[1], m_zena=row[7]: open_order_window(m_id, m_name, m_zena))
            b_zakaz.grid(row=3, column=0, pady=4)

        cur.close()
        con.close()

    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))

def open_detail(row):
    f_stranici.grid_remove()  
    f_katalog.grid_remove() 
    f_detali.grid(row=2, column=0, padx=10, pady=10) 

    for w in f_detali.winfo_children():
        w.destroy()

    def nazad():
        f_detali.grid_remove()
        f_stranici.grid()
        f_katalog.grid()

    tk.Button(f_detali, text="<-- Назад к каталогу", bg="#70b2af", command=nazad).pack(anchor="w", pady=(0, 10))

    tk.Label(f_detali, text=f"{row[3]} | {row[0]}", font=("Calibri", 16, "bold")).pack(anchor="w", pady=5)
    tk.Label(f_detali, text=f"Категория: {row[1]}", font=("Calibri", 12)).pack(anchor="w")
    tk.Label(f_detali, text=f"Состав: {row[5]}", font=("Calibri", 11)).pack(anchor="w", pady=2)
    tk.Label(f_detali, text=f"В наличии: {row[7]} шт.", font=("Calibri", 11, "italic")).pack(anchor="w")
    tk.Label(f_detali, text=f"Цена: {row[6]} руб.", font=("Calibri", 14, "bold")).pack(anchor="w", pady=10)
    
    tk.Label(f_detali, text="Описание:", font=("Calibri", 12, "bold")).pack(anchor="w")
    tk.Label(f_detali, text=row[4] or "Описание отсутствует", font=("Calibri", 11), justify="left", wraplength=600).pack(anchor="w", pady=5)

def open_order_window(id_model, model_name, zena):
    # Запрос доступных размеров для этой модели из БД
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute('''
            SELECT r.id_razmer, r.name_razmer, mr.count_m
            FROM model_razmer mr
            JOIN razmer r ON mr.id_razmer = r.id_razmer
            WHERE mr.id_models = %s AND mr.count_m > 0
            ORDER BY r.name_razmer ASC;
        ''', (id_model,))
        sizes_data = cur.fetchall() # [(id_razmer, name_razmer, count_m), ...]
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        return

    if not sizes_data:
        messagebox.showinfo("Нет в наличии", "К сожалению, этого товара нет в наличии.")
        return

    # Всплывающее окно диалога выбора размера
    win = tk.Toplevel(window)
    win.title("Выбор размера")
    win.geometry("320x220")
    win.grab_set() # делает окно модальным

    tk.Label(win, text=model_name, font=("Calibri", 10, "bold"), wraplength=300).pack(pady=5)
    
    # Выпадающий список с размерами
    tk.Label(win, text="Выберите размер:").pack()
    size_dict = {f"Размер {r[1]} (остаток: {r[2]} шт.)": (r[0], r[1], r[2]) for r in sizes_data}
    c_sizes = ttk.Combobox(win, values=list(size_dict.keys()), state="readonly", width=30)
    c_sizes.current(0)
    c_sizes.pack(pady=5)

    # Поле ввода количества
    tk.Label(win, text="Количество:").pack()
    e_cnt = tk.Entry(win, width=10)
    e_cnt.insert(0, "1")
    e_cnt.pack(pady=5)

    def add_to_cart_confirm():
        try:
            cnt = int(e_cnt.get().strip())
            if cnt <= 0:
                raise ValueError
        except ValueError:
            messagebox.showwarning("Ошибка", "Введите корректное количество!")
            return

        selected_str = c_sizes.get()
        id_razmer, name_razmer, stock = size_dict[selected_str]

        if cnt > stock:
            messagebox.showwarning("Ошибка", f"Доступно только {stock} шт.!")
            return

        total_price = cnt * zena

        # Добавляем позицию в список корзины и в визуальную таблицу tree
        item = (id_model, model_name, id_razmer, name_razmer, cnt, total_price)
        cart.append(item)
        tree.insert("", "end", values=(model_name, f"Размер {name_razmer}", cnt, f"{total_price} руб."))

        messagebox.showinfo("Успех", "Товар успешно добавлен в корзину!")
        win.destroy()

    tk.Button(win, text="Добавить в корзину", bg="#70b2af", command=add_to_cart_confirm).pack(pady=10)

def oformit_zakaz():
    if not cart:
        messagebox.showwarning("Корзина пуста", "Добавьте товары в корзину перед оформлением!")
        return

    from datetime import datetime
    today_str = datetime.now().strftime("%d.%m.%Y")

    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()

        # 1. Создаем новый заказ в zakazi
        cur.execute('''
            INSERT INTO zakazi (id_users, data_z)
            VALUES (%s, %s) RETURNING id_zakazi;
        ''', (current_user_id, today_str))
        id_zakazi = cur.fetchone()[0]

        # 2. Добавляем каждую позицию в poz_zakazi и уменьшаем остаток в model_razmer
        for item in cart:
            id_models, _, id_razmer, _, count_p, zena = item

            cur.execute('''
                INSERT INTO poz_zakazi (id_zakazi, id_models, id_razmer, count_p, zena)
                VALUES (%s, %s, %s, %s, %s);
            ''', (id_zakazi, id_models, id_razmer, count_p, zena))

            cur.execute('''
                UPDATE model_razmer
                SET count_m = count_m - %s
                WHERE id_models = %s AND id_razmer = %s;
            ''', (count_p, id_models, id_razmer))

        con.commit()
        cur.close()
        con.close()

        # 3. Очищаем корзину и обновляем интерфейс
        cart.clear()
        for item in tree.get_children():
            tree.delete(item)

        messagebox.showinfo("Заказ оформлен!", f"Ваш заказ №{id_zakazi} успешно сохранён!")
        katalog() # Обновляем остатки в каталоге

    except Exception as e:
        messagebox.showerror("Ошибка оформления", str(e))

def ochistit_korzinu():
    cart.clear()
    for item in tree.get_children():
        tree.delete(item)
    messagebox.showinfo("Корзина", "Корзина очищена.")

def go_to_registration():
    f_glav.pack_forget() 
    f_registracia.pack() 

def go_to_katalog():
    f_korzina.grid_remove()
    f_katalog.grid() 

def go_to_korzina():
    f_katalog.grid_remove()
    f_korzina.grid() 


window = tk.Tk()
window.title("Chudo-obuv")
window.geometry("1200x750")

f_glav = tk.Frame(window, bg="#d2f6e7")
f_glav.pack()

f_head = tk.Frame(f_glav)
f_head.grid(row=0, column=0, pady=5)

b_vhod = tk.Button(f_head, text="Вход", command=go_to_registration, bg="#70b2af")
b_vhod.grid(row=0, column=1, sticky="e")

f_stranici = tk.Frame(f_glav)
f_stranici.grid(row=1, column=0, sticky="w", padx=10)

b_katalog = tk.Button(f_stranici, text="Каталог", bg="#70b2af", command=go_to_katalog)
b_katalog.grid(row=0, column=0, sticky="e")

b_korzina = tk.Button(f_stranici, text="Корзина", bg="#70b2af", command=go_to_korzina)
b_korzina.grid(row=0, column=1, sticky="e")

f_katalog = tk.Frame(f_glav, relief="solid", bd=1)
f_katalog.grid(row=2, column=0, padx=10)

f_filtri = tk.Frame(f_katalog)
f_filtri.grid(row=1, column=0, pady=5)

l_poisk = tk.Label(f_filtri, text="Найти:")
l_poisk.grid(row=0, column=0)

e_poisk = tk.Entry(f_filtri, width=48)
e_poisk.grid(row=0, column=1, padx=2)

e_poisk.bind("<KeyRelease>", katalog)

c_categoria = ttk.Combobox(f_filtri, values=get_categories(), width=13, state="readonly")
c_categoria.set("Все категории") 
c_categoria.grid(row=0, column=2, padx=5)

c_categoria.bind("<<ComboboxSelected>>", katalog)

c_zena_znachenia = ["мин --> макс", "макс --> мин"]
c_zena = ttk.Combobox(f_filtri, value=c_zena_znachenia, width=13, state="readonly")
c_zena.set("Цена")
c_zena.grid(row=0, column=3)

c_zena.bind("<<ComboboxSelected>>", katalog)

c_katalog = tk.Canvas(f_katalog, width=900, height=650, highlightthickness=0)
c_katalog.grid(row=2, column=0, sticky="nsew")

scrol = ttk.Scrollbar(f_katalog, orient="vertical", command=c_katalog.yview)
scrol.grid(row=2, column=1, sticky="ns")

scrol_frame = tk.Frame(c_katalog)
scrol_frame.bind(
    "<Configure>",
    lambda e: c_katalog.configure(scrollregion=c_katalog.bbox("all"))
) 

canvas_frame = c_katalog.create_window((0, 0), window=scrol_frame, anchor="nw")

c_katalog.bind("<Configure>", lambda e: c_katalog.itemconfig(canvas_frame, width=e.width))
c_katalog.configure(yscrollcommand=scrol.set)

f_korzina = tk.Frame(f_glav)

f_table = tk.Frame(f_korzina)
f_table.grid(row=0, column=0, padx=10)

columns = ("model", "razmer", "count", "sum")
tree = ttk.Treeview(f_table, columns=columns, show="headings")

scroll = ttk.Scrollbar(f_table, orient="vertical", command=tree.yview)
tree.configure(yscrollcommand=scroll.set)

tree.pack(side="left", fill="both", expand=True)
scroll.pack(side="right", fill="y")

tree.heading("model", text="Модель")
tree.heading("razmer", text="Размер")
tree.heading("count", text="Колличество")
tree.heading("sum", text="Сумма")

for item in tree.get_children():
    tree.delete(item)

f_knopki = tk.Frame(f_korzina)
f_knopki.grid(row=1, column=0, sticky="e", padx=(0,30))

b_ochistit = tk.Button(f_knopki, text="Очистить корзину", bg="#ff8080", command=ochistit_korzinu)
b_ochistit.grid(row=0, column=0, padx=5)

b_oformit = tk.Button(f_knopki, text="Оформить заказ", bg="#70b2af", font=("Calibri", 11, "bold"), command=oformit_zakaz)
b_oformit.grid(row=0, column=1, padx=5)

f_detali = tk.Frame(f_glav)

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