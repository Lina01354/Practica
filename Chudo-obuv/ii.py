# Импорты
import tkinter as tk
from tkinter import ttk, messagebox
import psycopg2

# Соединения
bd_connect = {
    "host": "localhost",
    "user": "postgres",
    "database": "Demo",
    "password": "okna2301",
    "port": "5432"
}

# Определение роли пользователя
user_rol = 0

# Цвета
fon = "#ffffff"
dop_fon = "#d2f6e7"
knopka = "#70b2af" 
kras = "#ff8080"

# Получение ФИО
def get_login(login):
    global user_rol
    try:
        con = psycopg2.connect(**bd_connect)
        cur = con.cursor()
        cur.execute('''select last_name, first_name, middle_name, role_id
                    from users
                    where login = %s''', (login,))
        row = cur.fetchone()
        fio = f"{row[0]} {row[1]} {row[2] or ''}".strip()
        user_rol = row[3]
        cur.close()
        con.close()
        return fio
    except Exception:
        messagebox.showwarning("Нет данных", "Пользователь не найден")
        return None

# Получение логина
def get_fio():
    login = e_reg.get().strip()
    if not login:
        messagebox.showwarning("Нет данных", "Введите логин")
        return None

    fio = get_login(login)
    if fio:
        f_reg.pack_forget()
        f_glav.pack()
        f_korzina.grid_remove()
        f_zakazi.grid_remove()
        f_magazin.grid(row=2, column=0)
        l_fio = tk.Label(f_head, text=fio, bg=dop_fon)
        l_fio.grid(row=0, column=1)
        if user_rol == 3:
            b_zakazi.grid_remove()
        if user_rol == 1 or user_rol == 2:
            b_zakazi.grid(row=0, column=2)

# Получение категории
def kategorii():
    try:
        con = psycopg2.connect(**bd_connect)
        cur = con.cursor()
        cur.execute('select category_name from category;')
        kat = ["Все категории"] + [r[0] for r in cur.fetchall()]
        cur.close()
        con.close()
        return kat
    except Exception:
        return ["Все категории"]

# Создание каталога
def katalog(Event=None):
    for w in f_katalog.winfo_children():
        w.destroy()

    try:
        con = psycopg2.connect(**bd_connect)
        cur = con.cursor()
        cur.execute('''select p.product_id, c.category_name, p.subcategory, p.image_path, p.product_name, p.manufacturer, p.description, p.composition, p.price, sum(si.quantity_available)
                    from products p
                    left join category c on p.category_id = c.category_id
                    left join stock_items si on p.product_id = si.product_id
                    group by p.product_id, c.category_name;
                    ''')
        rows = cur.fetchall()

        kat = c_kat.get()
        if kat and kat != "Все категории":
            rows = [r for r in rows if r[1] == kat]

        prise = c_prise.get()
        if prise == "Макс -> мин":
            rows.sort(key=lambda r: float(r[8]), reverse=True)
        elif prise == "Мин -> макс":
            rows.sort(key=lambda r: float(r[8]))

        poisk = e_poisk.get().lower().strip()
        if poisk:
            rows = [r for r in rows if poisk in str(r[4]).lower()]

        for i, row in enumerate(rows):
            f_poz = tk.Frame(f_katalog, relief="solid", bd=1, bg=fon)
            f_poz.grid(row=i+1, column=0, pady=(10, 0))

            f_img = tk.Frame(f_poz, width=100, height=100, bg=dop_fon)
            f_img.pack_propagate(False)
            f_img.grid(row=0, column=0)

            try:
                foto = tk.PhotoImage(file=f"Images/{row[3]}")
            except Exception:
                foto = tk.PhotoImage(file="Images/picture.png")

            size = max(foto.width() // 100, foto.height() // 100)
            img = foto.subsample(size, size)

            l_img = tk.Label(f_img, image=img)
            l_img.image = img
            l_img.pack(expand=True)

            f_text = tk.Frame(f_poz, bg=fon)
            f_text.grid_columnconfigure(0, minsize=600)
            f_text.grid(row=0, column=1)

            l_titel = tk.Label(f_text, text=f"{row[5]} | {row[4]}", font=("Calibri", 12), bg=fon)
            l_titel.grid(row=0, column=0)

            l_kat = tk.Label(f_text, text=f"Категория: {row[1]}", font=("Calibri", 11), bg=fon)
            l_kat.grid(row=1, column=0, sticky="w")

            l_count = tk.Label(f_text, text=f"В наличии: {row[9]} шт.", font=("Calibri", 11), bg=fon, fg=kras if row[9] <= 3 else "black")
            l_count.grid(row=2, column=0, sticky="w")

            l_sostav = tk.Label(f_text, text=f"Состав: {row[7]}", font=("Calibri", 10), wraplength=600, justify="left", bg=fon)
            l_sostav.grid(row=3, column=0, sticky="w")

            f_detal = tk.Frame(f_poz, bg=fon)
            f_detal.grid_columnconfigure(0, minsize=60)
            f_detal.grid(row=0, column=2)

            l_prise = tk.Label(f_detal, text=f"{row[8]} руб.", font=("Calibri", 12), bg=fon)
            l_prise.grid(row=0, column=0, padx=5)

            b_detali = tk.Button(f_detal, text="Подробнее", command=lambda r=row: detali(r), bg=knopka)
            b_detali.grid(row=1, column=0, pady=(10, 0))

        cur.close()
        con.close()

    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))

# Открытие деталей продукта
def detali(row):
    win = tk.Toplevel(window)
    win.title("Подробнее")
    win.geometry("820x420")

    f_poz = tk.Frame(win, relief="solid", bd=1, bg=fon)
    f_poz.grid(row=0, column=0)

    f_img = tk.Frame(f_poz, width=100, height=100, bg=dop_fon)
    f_img.pack_propagate(False)
    f_img.grid(row=0, column=0)

    try:
        foto = tk.PhotoImage(file=f"Images/{row[3]}")
    except Exception:
        foto = tk.PhotoImage(file="Images/picture.png")

    size = max(foto.width() // 100, foto.height() // 100)
    img = foto.subsample(size, size)

    l_img = tk.Label(f_img, image=img)
    l_img.image = img
    l_img.pack(expand=True)

    f_text = tk.Frame(f_poz, bg=fon)
    f_text.grid_columnconfigure(0, minsize=600)
    f_text.grid(row=0, column=1)

    l_titel = tk.Label(f_text, text=f"{row[5]} | {row[4]}", font=("Calibri", 12), bg=fon)
    l_titel.grid(row=0, column=0)

    l_kat = tk.Label(f_text, text=f"Категория: {row[1]}", font=("Calibri", 11), bg=fon)
    l_kat.grid(row=1, column=0, sticky="w")

    l_count = tk.Label(f_text, text=f"В наличии: {row[9]} шт.", font=("Calibri", 11), bg=fon, fg=kras if row[9] <= 3 else "black")
    l_count.grid(row=2, column=0, sticky="w")

    l_sostav = tk.Label(f_text, text=f"Состав: {row[7]}", font=("Calibri", 10), wraplength=600, justify="left", bg=fon)
    l_sostav.grid(row=3, column=0, sticky="w")

    f_detal = tk.Frame(f_poz, bg=fon)
    f_detal.grid_columnconfigure(0, minsize=60)
    f_detal.grid(row=0, column=2)

    l_prise = tk.Label(f_detal, text=f"{row[8]} руб.", font=("Calibri", 12), bg=fon)
    l_prise.grid(row=0, column=0, padx=5)

    b_zakaz = tk.Button(f_detal, text="Заказать", command=zakaz, bg=knopka)
    b_zakaz.grid(row=1, column=0, pady=(10, 0))

def zakaz():
    messagebox.showinfo(":Р", "Возможно я могла бы сделать заказы, но я не помню как")

# Функции переходов между страницами
def go_reg():
    f_glav.pack_forget()
    f_reg.pack()

def go_magazin():
    f_korzina.grid_remove()
    f_zakazi.grid_remove()
    f_magazin.grid(row=2, column=0)

def go_korzina():
    f_magazin.grid_remove()
    f_zakazi.grid_remove()
    f_korzina.grid(row=2, column=0)

def go_zakazi():
    f_magazin.grid_remove()
    f_korzina.grid_remove()
    f_zakazi.grid(row=2, column=0)


# Создание окна
window = tk.Tk()
window.title("Чудо-обувь")
window.geometry("1200x700")

# Главная страница
f_glav = tk.Frame(window, bg=dop_fon)
f_glav.pack()

f_head = tk.Frame(f_glav, bg=dop_fon)
f_head.grid(row=0, column=0)

b_vhod = tk.Button(f_head, text="Ввойти", command=go_reg, bg=knopka)
b_vhod.grid(row=0, column=0)

# Навигация
f_knopki = tk.Frame(f_glav, bg=dop_fon)
f_knopki.grid(row=1, column=0, sticky="w")

b_magazin = tk.Button(f_knopki, text="Каталог", command=go_magazin, bg=knopka)
b_magazin.grid(row=0, column=0)

b_korzina = tk.Button(f_knopki, text="Корзина", command=go_korzina, bg=knopka)
b_korzina.grid(row=0, column=1)

b_zakazi = tk.Button(f_knopki, text="Заказы пользователей", command=go_zakazi, bg=knopka)

f_magazin = tk.Frame(f_glav, bg=dop_fon)
f_magazin.grid(row=2, column=0)

# Фильтры
f_filtri = tk.Frame(f_magazin, bg=dop_fon)
f_filtri.grid(row=0, column=0)

l_poisk = tk.Label(f_filtri, text="Найти:", font=("Calibri", 10), bg=dop_fon)
l_poisk.grid(row=0, column=0)

e_poisk = tk.Entry(f_filtri, width=70, bg=fon)
e_poisk.grid(row=0, column=1)
e_poisk.bind("<KeyRelease>", katalog) 

c_kat = ttk.Combobox(f_filtri, values=kategorii())
c_kat.set("Все категории")
c_kat.grid(row=0, column=2)
c_kat.bind("<<ComboboxSelected>>", katalog)

c_prise = ttk.Combobox(f_filtri, values=["Макс -> мин", "Мин -> макс"])
c_prise.set("Цена")
c_prise.grid(row=0, column=3)
c_prise.bind("<<ComboboxSelected>>", katalog)

f_katalog = tk.Frame(f_magazin, bg=fon)
f_katalog.grid_columnconfigure(0, minsize=760)
f_katalog.grid(row=1, column=0, padx=10, pady=10)

# Корзина
f_korzina = tk.Frame(f_glav, bg=dop_fon)

l_korzina = tk.Label(f_korzina, text="Здесь должна быть таблица - корзина пользователя, но я не умею делать таблицы :(", font=("Calibri", 10), bg=fon)
l_korzina.grid(row=0, column=0)

# Заказы пользователей
f_zakazi = tk.Frame(f_glav, bg=dop_fon)

l_zakazi = tk.Label(f_zakazi, text="Здесь должна быть таблица - заказы пользователей, но я не умею делать таблицы :(", font=("Calibri", 10), bg=fon)
l_zakazi.grid(row=0, column=0)

# Регистрация
f_reg = tk.Frame(window, bg=fon)

l_reg = tk.Label(f_reg, text="Введите логин:", font=("Calibri", 10), bg=fon)
l_reg.grid(row=0, column=0)

e_reg = tk.Entry(f_reg, bg=fon)
e_reg.grid(row=1, column=0)

b_reg = tk.Button(f_reg, text="Ввойти", command=get_fio, bg=knopka)
b_reg.grid(row=2, column=0)

katalog()
window.mainloop()