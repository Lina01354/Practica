import tkinter as tk
from tkinter import ttk, messagebox
import psycopg2
from datetime import datetime

# ==============================================================================
# 1. НАСТРОЙКИ И ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
# ==============================================================================
BD_CON = {
    "host": "localhost",
    "database": "Demo_3",
    "user": "postgres",
    "password": "okna2301",
    "port": "5432"
}

current_user_id = 0
rol = 1
cart = []

# ==============================================================================
# 2. ФУНКЦИИ РАБОТЫ С БД И АВТОРИЗАЦИИ
# ==============================================================================
def get_fio(login):
    global current_user_id, rol
    con = psycopg2.connect(**BD_CON)
    try:
        cur = con.cursor()
        cur.execute('''
            SELECT id_users, name_users, fam_users, otch_users, id_rols
            FROM users
            WHERE login_users = %s;
        ''', (login,))
        row = cur.fetchone()
        if row:
            current_user_id = row[0]
            rol = row[4]
            return f"{row[2]} {row[1]} {row[3] or ''}".strip()
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))
    finally:
        cur.close()
        con.close()
    return None

def get_login():
    global current_user_id, rol
    login = e_login.get().strip()
    if not login:
        messagebox.showwarning("Ошибка", "Введите логин!")
        return
    fio = get_fio(login)
    if fio:
        f_registracia.pack_forget()
        f_glav.pack()
        l_fio = tk.Label(f_head, text=f"Добро пожаловать, {fio}", font=("Arial", 10, "bold"), bg="#d2f6e7")
        l_fio.grid(row=0, column=1)
        # Логика ролей: 1=админ, 2=менеджер, 3=обычный пользователь
        if rol in (1, 2):
            b_zakazi.grid(row=0, column=2, sticky="e")
            b_pozicii.grid(row=4, column=1, sticky="e")
            b_create_zakaz.grid(row=4, column=2, sticky="e")  # ДОБАВЛЕНО: создание заказа
            b_delete_zakaz.grid(row=4, column=3, sticky="e")  # ДОБАВЛЕНО: удаление заказа
            if rol == 1:
                b_admin_izmenit.grid(row=4, column=0, sticky="e")
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

# ==============================================================================
# 3. ФУНКЦИИ НАВИГАЦИИ
# ==============================================================================
def go_to_registration():
    f_glav.pack_forget()
    f_registracia.pack()

def go_to_katalog():
    f_korzina.grid_remove()
    f_zakazi.grid_remove()
    f_detali.grid_remove()
    f_katalog.grid()

def go_to_korzina():
    f_katalog.grid_remove()
    f_zakazi.grid_remove()
    f_detali.grid_remove()
    f_korzina.grid()

def go_to_zakazi():
    f_katalog.grid_remove()
    f_korzina.grid_remove()
    f_detali.grid_remove()
    f_zakazi.grid()
    load_zakazi()

# ==============================================================================
# 4. ФУНКЦИИ КАТАЛОГА И КОРЗИНЫ
# ==============================================================================
def katalog(event=None):
    for widget in scrol_frame.winfo_children():
        widget.destroy()
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        # ДОБАВЛЕНО: Расчёт цены со скидкой 25% (индекс 9 в кортеже row)
        # Скидка применяется, если НЕ БЫЛО заказов за предыдущий календарный месяц
        cur.execute('''
            SELECT m.id_models, m.name_models, c.name_categoria, m.img, m.prooizvodstvo,
                   m.opisanie, m.coctav, m.zena, COALESCE(SUM(mr.count_m), 0) AS count_model,
                   CASE WHEN NOT EXISTS (
                       SELECT 1 FROM poz_zakazi pz
                       JOIN zakazi z ON pz.id_zakazi = z.id_zakazi
                       WHERE pz.id_models = m.id_models
                       AND to_date(z.data_z, 'DD.MM.YYYY') >= date_trunc('month', CURRENT_DATE - interval '1 month')
                       AND to_date(z.data_z, 'DD.MM.YYYY') < date_trunc('month', CURRENT_DATE)
                   ) THEN ROUND(m.zena * 0.75) ELSE m.zena END AS zena_with_discount
            FROM models m
            LEFT JOIN categoria c ON m.id_categoria = c.id_categoria
            LEFT JOIN model_razmer mr ON m.id_models = mr.id_models
            GROUP BY m.id_models, m.name_models, c.name_categoria, m.img, m.prooizvodstvo,
                     m.opisanie, m.coctav, m.zena
            ORDER BY m.id_models ASC;
        ''')
        rows = cur.fetchall()

        vybor = c_categoria.get()
        if vybor and vybor != "Все категории":
            rows = [r for r in rows if r[2] == vybor]

        sort_zena = c_zena.get()
        if sort_zena == "мин --> макс":
            rows.sort(key=lambda r: float(r[9]))  # Сортировка по цене со скидкой
        elif sort_zena == "макс --> мин":
            rows.sort(key=lambda r: float(r[9]), reverse=True)

        query = e_poisk.get().strip().lower()
        if query:
            rows = [r for r in rows if query in str(r[1]).lower() or query in str(r[5]).lower()]

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

            # ИСПРАВЛЕНО: <= 3 (меньше или равно трём), как в ТЗ
            kolvo_color = "#ff8080" if row[8] <= 3 else "black"
            l_kolvo = tk.Label(f_text, text=f"В наличии: {row[8]} шт.", font=("Calibri", 11), fg=kolvo_color)
            l_kolvo.grid(row=2, column=0, sticky="w", pady=2)

            l_sostav = tk.Label(f_text, text=f"Состав: {row[6]}", font=("Calibri", 10), justify="left", wraplength=600)
            l_sostav.grid(row=3, column=0, sticky="w")

            f_knopki_tovara = tk.Frame(f_pozicia)
            f_knopki_tovara.grid(row=0, column=2, padx=(0, 10))
            
            # ВЫВЕДЕНО: Просто цена со скидкой (row[9]), без визуальных пометок, как ты просил
            l_zena = tk.Label(f_knopki_tovara, text=f"{row[9]} руб.", font=("Calibri", 12))
            l_zena.grid(row=0, column=0, padx=2, sticky="e", pady=(5, 0))
            
            # В open_detail также передаём цену со скидкой (row[9])
            b_detali = tk.Button(f_knopki_tovara, text="Подробнее", width=11, bg="#70b2af", command=lambda r=row: open_detail(r))
            b_detali.grid(row=2, column=0, pady=(10, 0))

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

    b_nazad = tk.Button(f_detali, text="<-- Назад к каталогу", bg="#70b2af", command=nazad)
    b_nazad.grid(row=0, column=0, sticky="w", pady=(0, 10))

    l_titel = tk.Label(f_detali, text=f"{row[4]} | {row[1]}", font=("Calibri", 16, "bold"), bg="#d2f6e7")
    l_titel.grid(row=1, column=0, sticky="w", pady=5)

    f_vse_detali = tk.Frame(f_detali, bg="#d2f6e7")
    f_vse_detali.grid(row=2, column=0, sticky="w", padx=5)

    f_img = tk.Frame(f_vse_detali, height=120, width=120, bg="#d2f6e7")
    f_img.pack_propagate(False)
    f_img.grid(row=0, column=0, padx=5, sticky="n")
    try:
        raw_img = tk.PhotoImage(file=f"Images/{row[3]}")
    except Exception:
        raw_img = tk.PhotoImage(file="Images/picture.png")
    scale = max(1, raw_img.width() // 120, raw_img.height() // 120)
    img = raw_img.subsample(scale, scale)
    l_img = tk.Label(f_img, image=img, bg="#d2f6e7")
    l_img.image = img
    l_img.pack(expand=True)

    f_text = tk.Frame(f_vse_detali, bg="#d2f6e7")
    f_text.grid(row=0, column=1, padx=5, sticky="w")

    l_kategoria = tk.Label(f_text, text=f"Категория: {row[2]}", font=("Calibri", 12), bg="#d2f6e7")
    l_kategoria.grid(row=0, column=0, sticky="w")
    l_sostav = tk.Label(f_text, text=f"Состав: {row[6]}", font=("Calibri", 11), bg="#d2f6e7")
    l_sostav.grid(row=1, column=0, sticky="w", pady=2)
    l_count = tk.Label(f_text, text=f"В наличии: {row[8]} шт.", font=("Calibri", 11, "italic"), bg="#d2f6e7")
    l_count.grid(row=2, column=0, sticky="w")
    # ДОБАВЛЕНО: цена со скидкой (индекс 9)
    if row[9] < row[7]:
        l_zena = tk.Label(f_text, text=f"Цена: {row[9]} руб.", font=("Calibri", 14, "bold"), bg="#d2f6e7")
    else:
        l_zena = tk.Label(f_text, text=f"Цена: {row[9]} руб.", font=("Calibri", 14, "bold"), bg="#d2f6e7")
    l_zena.grid(row=3, column=0, sticky="w", pady=10)
    l_opisanie = tk.Label(f_text, text=row[5] or "Описание отсутствует", font=("Calibri", 11), justify="left", wraplength=600, bg="#d2f6e7")
    l_opisanie.grid(row=4, column=0, sticky="w", pady=5)
    # ДОБАВЛЕНО: передаём цену со скидкой (row[9]) в окно заказа
    b_zakaz = tk.Button(f_text, text="Заказать", width=11, bg="#70b2af", 
                        command=lambda m_id=row[0], m_name=row[1], m_zena=row[9]: open_order_window(m_id, m_name, m_zena))
    b_zakaz.grid(row=5, column=0, sticky="w", pady=4)

def open_order_window(id_model, model_name, zena):
    if current_user_id == 0:
        messagebox.showwarning("Ошибка", "Войдите в аккаунт!")
        return
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
        sizes_data = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        return

    if not sizes_data:
        messagebox.showinfo("Нет в наличии", "К сожалению, этого товара нет в наличии.")
        return

    win = tk.Toplevel(window)
    win.title("Выбор размера")
    win.geometry("320x220")
    win.grab_set()

    tk.Label(win, text=model_name, font=("Calibri", 10, "bold"), wraplength=300).pack(pady=5)
    tk.Label(win, text="Выберите размер:").pack()

    size_dict = {f"Размер {r[1]} (остаток: {r[2]} шт.)": (r[0], r[1], r[2]) for r in sizes_data}
    c_sizes = ttk.Combobox(win, values=list(size_dict.keys()), state="readonly", width=30)
    c_sizes.current(0)
    c_sizes.pack(pady=5)

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
        item = (id_model, model_name, id_razmer, name_razmer, cnt, total_price)
        cart.append(item)
        tree_cart.insert("", "end", values=(model_name, f"Размер {name_razmer}", cnt, f"{total_price} руб."))
        messagebox.showinfo("Успех", "Товар успешно добавлен в корзину!")
        win.destroy()

    tk.Button(win, text="Добавить в корзину", bg="#70b2af", command=add_to_cart_confirm).pack(pady=10)

def oformit_zakaz():
    if not cart:
        messagebox.showwarning("Корзина пуста", "Добавьте товары в корзину перед оформлением!")
        return
    today_str = datetime.now().strftime("%d.%m.%Y")
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute('''
            INSERT INTO zakazi (id_users, data_z)
            VALUES (%s, %s) RETURNING id_zakazi;
        ''', (current_user_id, today_str))
        id_zakazi = cur.fetchone()[0]

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

        cart.clear()
        for item in tree_cart.get_children():
            tree_cart.delete(item)
        messagebox.showinfo("Заказ оформлен!", f"Ваш заказ №{id_zakazi} успешно сохранён!")
        katalog()
    except Exception as e:
        messagebox.showerror("Ошибка оформления", str(e))

def udalit_poziciu():
    if len(cart) == 0:
        messagebox.showinfo("Корзина", "Корзина пуста.")
        return
    win = tk.Toplevel(window)
    win.title("Удалить из корзины")
    win.geometry("400x180")
    win.grab_set()

    tk.Label(win, text="Выберите товар для удаления:", font=("Calibri", 11, "bold")).pack(pady=(10, 5))
    items_display = [f"{c[1]} | Размер {c[3]} | {c[4]} шт. | {c[5]} руб." for c in cart]
    c_items = ttk.Combobox(win, values=items_display, state="readonly", width=50)
    c_items.current(0)
    c_items.pack(pady=5)

    def delete_selected():
        idx = c_items.current()
        if idx < 0:
            return
        cart.pop(idx)
        tree_cart.delete(tree_cart.get_children()[idx])
        messagebox.showinfo("Успех", "Позиция удалена из корзины.")
        win.destroy()

    tk.Button(win, text="Удалить позицию", bg="#ff8080", font=("Calibri", 11), command=delete_selected).pack(pady=10)

def izmenit_korzinu():
    if len(cart) == 0:
        messagebox.showinfo("Ошибка", "В корзине нет товаров.")
        return
    win = tk.Toplevel(window)
    win.title("Изменить корзину")
    win.geometry("380x260")
    win.grab_set()

    tk.Label(win, text="Выберите товар:", font=("Calibri", 11, "bold")).pack(pady=(10, 0))
    items_display = [f"{c[1]} | Размер {c[3]} (сейчас: {c[4]} шт.)" for c in cart]
    c_items = ttk.Combobox(win, values=items_display, state="readonly", width=45)
    c_items.current(0)
    c_items.pack(pady=5)

    tk.Label(win, text="Новое количество:").pack()
    e_cnt = tk.Entry(win, width=10)
    e_cnt.insert(0, str(cart[0][4]))
    e_cnt.pack(pady=5)

    def on_select(event=None):
        idx = c_items.current()
        if idx >= 0:
            e_cnt.delete(0, tk.END)
            e_cnt.insert(0, str(cart[idx][4]))
    c_items.bind("<<ComboboxSelected>>", on_select)

    def save_changes():
        idx = c_items.current()
        if idx < 0:
            return
        try:
            new_cnt = int(e_cnt.get().strip())
            if new_cnt <= 0:
                raise ValueError
        except ValueError:
            messagebox.showwarning("Ошибка", "Введите корректное количество!")
            return

        id_model, _, id_razmer, _, _, _ = cart[idx]
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            cur.execute('''SELECT count_m FROM model_razmer WHERE id_models = %s AND id_razmer = %s;''', (id_model, id_razmer))
            stock = cur.fetchone()[0]
            cur.close()
            con.close()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))
            return

        if new_cnt > stock:
            messagebox.showwarning("Ошибка", f"Доступно только {stock} шт.!")
            return

        zena = cart[idx][5] / cart[idx][4]
        new_total = new_cnt * zena

        item = list(cart[idx])
        item[4] = new_cnt
        item[5] = new_total
        cart[idx] = tuple(item)

        all_items = tree_cart.get_children()
        tree_cart.item(all_items[idx], values=(cart[idx][1], f"Размер {cart[idx][3]}", new_cnt, f"{new_total} руб."))
        messagebox.showinfo("Успех", "Количество обновлено!")
        win.destroy()

    tk.Button(win, text="Сохранить", bg="#70b2af", command=save_changes).pack(pady=10)

# ==============================================================================
# 5. ФУНКЦИИ ЗАКАЗОВ И АДМИНКИ
# ==============================================================================
def load_zakazi():
    for item in tree_zakazi.get_children():
        tree_zakazi.delete(item)
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute('''
            SELECT z.id_zakazi,
                   u.fam_users || ' ' || u.name_users || ' ' || COALESCE(u.otch_users, '') AS fio,
                   z.data_z
            FROM zakazi z
            JOIN users u ON z.id_users = u.id_users
            ORDER BY z.id_zakazi ASC;
        ''')
        rows = cur.fetchall()
        for row in rows:
            tree_zakazi.insert("", "end", values=(row[0], row[1].strip(), row[2]))
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))

def get_podrobnie():
    win = tk.Toplevel(window)
    win.title("Просмотр позиций заказа")
    win.geometry("500x280")
    win.grab_set()

    tk.Label(win, text="Выберите заказ для просмотра:", font=("Calibri", 11, "bold")).pack(pady=10)
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT id_zakazi, data_z FROM zakazi ORDER BY id_zakazi DESC;")
        orders = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        win.destroy()
        return

    if not orders:
        messagebox.showinfo("Информация", "В базе данных пока нет заказов.")
        win.destroy()
        return

    order_dict = {f"Заказ №{o[0]} от {o[1]}": o[0] for o in orders}
    c_orders = ttk.Combobox(win, values=list(order_dict.keys()), state="readonly", width=40)
    c_orders.current(0)
    c_orders.pack(pady=5)

    def show_positions():
        selected_id = order_dict[c_orders.get()]
        for item in tree_pozicii.get_children():
            tree_pozicii.delete(item)
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            # ДОБАВЛЕНО: добавлено производство (m.prooizvodstvo) в запрос
            cur.execute('''
                SELECT pz.id_zakazi, m.name_models, m.prooizvodstvo, r.name_razmer, pz.count_p, pz.zena
                FROM poz_zakazi pz
                JOIN models m ON pz.id_models = m.id_models
                JOIN razmer r ON pz.id_razmer = r.id_razmer
                WHERE pz.id_zakazi = %s;
            ''', (selected_id,))
            positions = cur.fetchall()
            cur.close()
            con.close()

            total_sum = 0
            for pos in positions:
                tree_pozicii.insert("", "end", values=(pos[0], pos[1], pos[2], pos[3], pos[4], f"{pos[5]} руб."))
                total_sum += float(pos[5])

            # ДОБАВЛЕНО: отображение итоговой суммы заказа
            l_total.config(text=f"Итого по заказу: {total_sum:.2f} руб.")
            f_pozicii_frame.grid(row=1, column=0, padx=10, pady=(0, 10))
            messagebox.showinfo("Успех", f"Позиции заказа №{selected_id} успешно загружены.")
            win.destroy()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))

    # ДОБАВЛЕНО: Label для итоговой суммы
    global l_total
    l_total = tk.Label(win, text="", font=("Calibri", 12, "bold"), fg="#d32f2f")
    l_total.pack(pady=5)

    tk.Button(win, text="Показать позиции", bg="#70b2af", font=("Calibri", 11), command=show_positions).pack(pady=10)

# ==============================================================================
# ДОБАВЛЕНО: Создание нового заказа менеджером/админом
# ==============================================================================
def create_new_zakaz():
    win = tk.Toplevel(window)
    win.title("Создать новый заказ")
    win.geometry("500x400")
    win.grab_set()

    tk.Label(win, text="Создание нового заказа", font=("Calibri", 14, "bold")).pack(pady=10)
    tk.Label(win, text="Выберите клиента:", font=("Calibri", 11)).pack()
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT id_users, fam_users || ' ' || name_users FROM users ORDER BY fam_users")
        users = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        win.destroy()
        return

    user_dict = {f"{u[1]}": u[0] for u in users}
    c_users = ttk.Combobox(win, values=list(user_dict.keys()), state="readonly", width=40)
    c_users.current(0)
    c_users.pack(pady=5)

    tk.Label(win, text="Дата заказа (ДД.ММ.ГГГГ):").pack()
    e_date = tk.Entry(win, width=15)
    e_date.insert(0, datetime.now().strftime("%d.%m.%Y"))
    e_date.pack(pady=5)

    tk.Label(win, text="Выберите модель:").pack()
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT id_models, name_models, zena FROM models ORDER BY name_models")
        models = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        return

    model_dict = {f"{m[1]} ({m[2]} руб.)": (m[0], m[2]) for m in models}
    c_model = ttk.Combobox(win, values=list(model_dict.keys()), state="readonly", width=40)
    c_model.pack(pady=5)

    tk.Label(win, text="Размер:").pack()
    c_size = ttk.Combobox(win, state="readonly", width=40)
    c_size.pack(pady=5)

    tk.Label(win, text="Количество:").pack()
    e_cnt = tk.Entry(win, width=10)
    e_cnt.insert(0, "1")
    e_cnt.pack(pady=5)

    def update_sizes(event=None):
        if not c_model.get():
            return
        id_model, _ = model_dict[c_model.get()]
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            cur.execute('''
                SELECT r.id_razmer, r.name_razmer, mr.count_m
                FROM model_razmer mr
                JOIN razmer r ON mr.id_razmer = r.id_razmer
                WHERE mr.id_models = %s AND mr.count_m > 0
            ''', (id_model,))
            sizes = cur.fetchall()
            cur.close()
            con.close()
            size_dict_local = {f"Размер {s[1]} (остаток: {s[2]} шт.)": (s[0], s[1], s[2]) for s in sizes}
            c_size['values'] = list(size_dict_local.keys())
            if size_dict_local:
                c_size.current(0)
            win.size_dict = size_dict_local
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))
    c_model.bind("<<ComboboxSelected>>", update_sizes)

    def confirm_create():
        if not c_users.get() or not c_model.get() or not c_size.get():
            messagebox.showwarning("Ошибка", "Заполните все поля!")
            return
        try:
            new_date = e_date.get().strip()
            datetime.strptime(new_date, "%d.%m.%Y")
            cnt = int(e_cnt.get().strip())
            if cnt <= 0:
                raise ValueError
        except ValueError:
            messagebox.showerror("Ошибка", "Неверная дата или количество!")
            return

        id_user = user_dict[c_users.get()]
        id_razmer, name_razmer, stock = win.size_dict[c_size.get()]
        if cnt > stock:
            messagebox.showwarning("Ошибка", f"Доступно только {stock} шт.!")
            return

        id_model, unit_price = model_dict[c_model.get()]
        total_sum = cnt * unit_price

        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            cur.execute("INSERT INTO zakazi (id_users, data_z) VALUES (%s, %s) RETURNING id_zakazi;", (id_user, new_date))
            id_zakazi = cur.fetchone()[0]
            cur.execute("INSERT INTO poz_zakazi (id_zakazi, id_models, id_razmer, count_p, zena) VALUES (%s, %s, %s, %s, %s);",
                        (id_zakazi, id_model, id_razmer, cnt, total_sum))
            cur.execute("UPDATE model_razmer SET count_m = count_m - %s WHERE id_models = %s AND id_razmer = %s;",
                        (cnt, id_model, id_razmer))
            con.commit()
            cur.close()
            con.close()
            messagebox.showinfo("Успех", f"Заказ №{id_zakazi} успешно создан!")
            load_zakazi()
            katalog()
            win.destroy()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))

    tk.Button(win, text="Создать заказ", bg="#70b2af", font=("Calibri", 11), command=confirm_create).pack(pady=15)

# ==============================================================================
# ДОБАВЛЕНО: Удаление заказа целиком с подтверждением
# ==============================================================================
def delete_zakaz():
    win = tk.Toplevel(window)
    win.title("Удалить заказ")
    win.geometry("400x180")
    win.grab_set()

    tk.Label(win, text="Выберите заказ для удаления:", font=("Calibri", 11, "bold")).pack(pady=10)
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT id_zakazi, data_z FROM zakazi ORDER BY id_zakazi DESC;")
        orders = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        win.destroy()
        return

    if not orders:
        messagebox.showinfo("Информация", "В базе данных пока нет заказов.")
        win.destroy()
        return

    order_dict = {f"Заказ №{o[0]} от {o[1]}": o[0] for o in orders}
    c_orders = ttk.Combobox(win, values=list(order_dict.keys()), state="readonly", width=40)
    c_orders.current(0)
    c_orders.pack(pady=5)

    def confirm_delete():
        z_id = order_dict[c_orders.get()]
        if not messagebox.askyesno("Подтверждение", f"Вы уверены, что хотите удалить заказ №{z_id}?"):
            return
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            # Возвращаем остатки на склад
            cur.execute('''
                SELECT pz.id_models, pz.id_razmer, pz.count_p
                FROM poz_zakazi pz WHERE pz.id_zakazi = %s
            ''', (z_id,))
            positions = cur.fetchall()
            for p in positions:
                cur.execute("UPDATE model_razmer SET count_m = count_m + %s WHERE id_models = %s AND id_razmer = %s;",
                            (p[2], p[0], p[1]))
            cur.execute("DELETE FROM poz_zakazi WHERE id_zakazi = %s;", (z_id,))
            cur.execute("DELETE FROM zakazi WHERE id_zakazi = %s;", (z_id,))
            con.commit()
            cur.close()
            con.close()
            messagebox.showinfo("Успех", f"Заказ №{z_id} успешно удалён!")
            load_zakazi()
            katalog()
            win.destroy()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))

    tk.Button(win, text="Удалить заказ", bg="#ff8080", font=("Calibri", 11), command=confirm_delete).pack(pady=10)

def get_izmenit():
    win = tk.Toplevel(window)
    win.title("Управление заказами (Администратор)")
    win.geometry("550x250")
    win.grab_set()

    tk.Label(win, text="Выберите заказ для редактирования:", font=("Calibri", 11, "bold")).pack(pady=10)
    try:
        con = psycopg2.connect(**BD_CON)
        cur = con.cursor()
        cur.execute("SELECT id_zakazi, data_z FROM zakazi ORDER BY id_zakazi DESC;")
        orders = cur.fetchall()
        cur.close()
        con.close()
    except Exception as e:
        messagebox.showerror("Ошибка БД", str(e))
        win.destroy()
        return

    if not orders:
        messagebox.showinfo("Информация", "В базе данных пока нет заказов.")
        win.destroy()
        return

    order_dict = {f"Заказ №{o[0]} от {o[1]}": o[0] for o in orders}
    c_orders = ttk.Combobox(win, values=list(order_dict.keys()), state="readonly", width=50)
    c_orders.current(0)
    c_orders.pack(pady=5)

    def get_selected_id():
        return order_dict.get(c_orders.get())

    def edit_date_action():
        z_id = get_selected_id()
        if not z_id:
            return
        win_date = tk.Toplevel(win)
        win_date.title("Изменить дату заказа")
        win_date.geometry("300x150")
        win_date.grab_set()
        tk.Label(win_date, text="Новая дата (ДД.ММ.ГГГГ):").pack(pady=10)
        e_date = tk.Entry(win_date, width=15)
        e_date.pack(pady=5)
        def save_date():
            new_date = e_date.get().strip()
            try:
                datetime.strptime(new_date, "%d.%m.%Y")
            except ValueError:
                messagebox.showerror("Ошибка", "Неверный формат! Используйте ДД.ММ.ГГГГ")
                return
            try:
                con = psycopg2.connect(**BD_CON)
                cur = con.cursor()
                cur.execute("UPDATE zakazi SET data_z = %s WHERE id_zakazi = %s", (new_date, z_id))
                con.commit()
                cur.close()
                con.close()
                messagebox.showinfo("Успех", "Дата заказа успешно обновлена!")
                load_zakazi()
                win_date.destroy()
            except Exception as e:
                messagebox.showerror("Ошибка БД", str(e))
        tk.Button(win_date, text="Сохранить", bg="#70b2af", command=save_date).pack(pady=10)

    def delete_position_action():
        z_id = get_selected_id()
        if not z_id:
            return
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            cur.execute('''
                SELECT pz.id_models, m.name_models, r.name_razmer, pz.count_p, pz.id_razmer
                FROM poz_zakazi pz
                JOIN models m ON pz.id_models = m.id_models
                JOIN razmer r ON pz.id_razmer = r.id_razmer
                WHERE pz.id_zakazi = %s
            ''', (z_id,))
            positions = cur.fetchall()
            cur.close()
            con.close()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))
            return

        if not positions:
            messagebox.showinfo("Информация", "В этом заказе нет позиций для удаления.")
            return

        win_del = tk.Toplevel(win)
        win_del.title("Удалить позицию")
        win_del.geometry("420x200")
        win_del.grab_set()
        tk.Label(win_del, text="Выберите позицию для удаления:").pack(pady=5)
        pos_dict = {f"{p[1]} | Размер {p[2]} | {p[3]} шт.": (p[0], p[4], p[3]) for p in positions}
        c_pos = ttk.Combobox(win_del, values=list(pos_dict.keys()), state="readonly", width=50)
        c_pos.current(0)
        c_pos.pack(pady=5)

        def confirm_delete():
            id_model, id_razmer, count_p = pos_dict[c_pos.get()]
            try:
                con = psycopg2.connect(**BD_CON)
                cur = con.cursor()
                cur.execute('''DELETE FROM poz_zakazi WHERE id_zakazi = %s AND id_models = %s AND id_razmer = %s''', (z_id, id_model, id_razmer))
                cur.execute('''UPDATE model_razmer SET count_m = count_m + %s WHERE id_models = %s AND id_razmer = %s''', (count_p, id_model, id_razmer))
                con.commit()
                cur.close()
                con.close()
                messagebox.showinfo("Успех", "Позиция удалена, остатки возвращены на склад.")
                load_zakazi()
                win_del.destroy()
            except Exception as e:
                messagebox.showerror("Ошибка БД", str(e))

        tk.Button(win_del, text="Удалить позицию", bg="#ff8080", font=("Calibri", 11), command=confirm_delete).pack(pady=10)

    def add_position_action():
        z_id = get_selected_id()
        if not z_id:
            return
        win_add = tk.Toplevel(win)
        win_add.title("Добавить позицию в заказ")
        win_add.geometry("400x320")
        win_add.grab_set()
        try:
            con = psycopg2.connect(**BD_CON)
            cur = con.cursor()
            cur.execute("SELECT id_models, name_models, zena FROM models ORDER BY name_models")
            models = cur.fetchall()
            cur.close()
            con.close()
        except Exception as e:
            messagebox.showerror("Ошибка БД", str(e))
            return

        model_dict = {f"{m[1]} ({m[2]} руб./шт.)": (m[0], m[2]) for m in models}
        tk.Label(win_add, text="Выберите модель:").pack(pady=(10, 0))
        c_model = ttk.Combobox(win_add, values=list(model_dict.keys()), state="readonly", width=45)
        c_model.pack(pady=5)
        tk.Label(win_add, text="Выберите размер:").pack()
        c_size = ttk.Combobox(win_add, state="readonly", width=45)
        c_size.pack(pady=5)
        tk.Label(win_add, text="Количество:").pack()
        e_cnt = tk.Entry(win_add, width=10)
        e_cnt.insert(0, "1")
        e_cnt.pack(pady=5)

        def update_sizes(event=None):
            if not c_model.get():
                return
            id_model, unit_price = model_dict[c_model.get()]
            try:
                con = psycopg2.connect(**BD_CON)
                cur = con.cursor()
                cur.execute('''
                    SELECT r.id_razmer, r.name_razmer, mr.count_m
                    FROM model_razmer mr
                    JOIN razmer r ON mr.id_razmer = r.id_razmer
                    WHERE mr.id_models = %s AND mr.count_m > 0
                ''', (id_model,))
                sizes = cur.fetchall()
                cur.close()
                con.close()
                size_dict_local = {f"Размер {s[1]} (остаток: {s[2]} шт.)": (s[0], s[1], s[2]) for s in sizes}
                c_size['values'] = list(size_dict_local.keys())
                if size_dict_local:
                    c_size.current(0)
                win_add.size_dict = size_dict_local
                win_add.current_zena = unit_price
                win_add.current_id_model = id_model
            except Exception as e:
                messagebox.showerror("Ошибка БД", str(e))

        c_model.bind("<<ComboboxSelected>>", update_sizes)

        def confirm_add():
            if not c_model.get() or not c_size.get():
                messagebox.showwarning("Ошибка", "Выберите модель и размер!")
                return
            try:
                cnt = int(e_cnt.get().strip())
                if cnt <= 0:
                    raise ValueError
            except ValueError:
                messagebox.showwarning("Ошибка", "Введите корректное количество!")
                return

            id_razmer, name_razmer, stock = win_add.size_dict[c_size.get()]
            if cnt > stock:
                messagebox.showwarning("Ошибка", f"Доступно только {stock} шт. на складе!")
                return

            unit_price = win_add.current_zena
            id_model = win_add.current_id_model
            total_sum = cnt * unit_price
            try:
                con = psycopg2.connect(**BD_CON)
                cur = con.cursor()
                cur.execute('''INSERT INTO poz_zakazi (id_zakazi, id_models, id_razmer, count_p, zena) VALUES (%s, %s, %s, %s, %s)''', (z_id, id_model, id_razmer, cnt, total_sum))
                cur.execute('''UPDATE model_razmer SET count_m = count_m - %s WHERE id_models = %s AND id_razmer = %s''', (cnt, id_model, id_razmer))
                con.commit()
                cur.close()
                con.close()
                messagebox.showinfo("Успех", "Позиция успешно добавлена в заказ!")
                load_zakazi()
                win_add.destroy()
            except Exception as e:
                messagebox.showerror("Ошибка БД", str(e))

        tk.Button(win_add, text="Добавить в заказ", bg="#70b2af", font=("Calibri", 11), command=confirm_add).pack(pady=10)

    f_actions = tk.Frame(win)
    f_actions.pack(pady=15)
    tk.Button(f_actions, text="Удалить позицию", bg="#ff8080", font=("Calibri", 11), width=15, command=delete_position_action).grid(row=0, column=0, padx=5)
    tk.Button(f_actions, text="Добавить позицию", bg="#70b2af", font=("Calibri", 11), width=15, command=add_position_action).grid(row=0, column=1, padx=5)
    tk.Button(f_actions, text="Изменить дату", bg="#70b2af", font=("Calibri", 11), width=15, command=edit_date_action).grid(row=0, column=2, padx=5)

# ==============================================================================
# 6. СОЗДАНИЕ ГЛАВНОГО ОКНА И ИНТЕРФЕЙСА (UI)
# ==============================================================================
window = tk.Tk()
window.title("Чудо Обувь - система оформления заказов")
window.geometry("1200x750")

# ДОБАВЛЕНО: установка иконки приложения (если файл есть)
try:
    window.iconbitmap("Images/Чудо Обувь.ico")
except Exception:
    pass  # если файла нет — просто пропускаем

# --- Фрейм Регистрации ---
f_registracia = tk.Frame(window)
f_login = tk.Frame(f_registracia)
f_login.grid(row=0, column=0)
l_login = tk.Label(f_login, text="Логин:", font=("Calibri", 10))
l_login.grid(row=0, column=0)
e_login = tk.Entry(f_login)
e_login.grid(row=0, column=1)
b_registracia = tk.Button(f_registracia, text="Вход", command=get_login)
b_registracia.grid(row=1, column=0)

# --- Главный фрейм ---
f_glav = tk.Frame(window, bg="#d2f6e7")
f_glav.pack()

# Шапка
f_head = tk.Frame(f_glav, bg="#d2f6e7")
f_head.grid(row=0, column=0, pady=5)
# ДОБАВЛЕНО: логотип в шапке (если файл есть)
try:
    raw_logo = tk.PhotoImage(file="Images/Чудо Обувь.png")
    scale_logo = max(1, raw_logo.width() // 150, raw_logo.height() // 60)
    logo_img = raw_logo.subsample(scale_logo, scale_logo)
    l_logo = tk.Label(f_head, image=logo_img, bg="#d2f6e7")
    l_logo.image = logo_img
    l_logo.grid(row=0, column=0, padx=(0, 10))
except Exception:
    pass  # если логотипа нет — пропускаем

b_vhod = tk.Button(f_head, text="Вход", command=go_to_registration, bg="#70b2af")
b_vhod.grid(row=0, column=2, sticky="e")

# Навигация
f_stranici = tk.Frame(f_glav)
f_stranici.grid(row=1, column=0, sticky="w", padx=10)
b_katalog = tk.Button(f_stranici, text="Каталог", bg="#70b2af", command=go_to_katalog)
b_katalog.grid(row=0, column=0, sticky="e")
b_korzina = tk.Button(f_stranici, text="Корзина", bg="#70b2af", command=go_to_korzina)
b_korzina.grid(row=0, column=1, sticky="e")
b_zakazi = tk.Button(f_stranici, text="Заказы пользователей", bg="#70b2af", command=go_to_zakazi)
b_zakazi.grid_remove()

# --- Фрейм Каталога ---
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
c_zena = ttk.Combobox(f_filtri, values=c_zena_znachenia, width=13, state="readonly")
c_zena.set("Цена")
c_zena.grid(row=0, column=3)
c_zena.bind("<<ComboboxSelected>>", katalog)

c_katalog = tk.Canvas(f_katalog, width=900, height=650, highlightthickness=0)
c_katalog.grid(row=2, column=0, sticky="nsew")
scrol = ttk.Scrollbar(f_katalog, orient="vertical", command=c_katalog.yview)
scrol.grid(row=2, column=1, sticky="ns")
scrol_frame = tk.Frame(c_katalog)
scrol_frame.bind("<Configure>", lambda e: c_katalog.configure(scrollregion=c_katalog.bbox("all")))
canvas_frame = c_katalog.create_window((0, 0), window=scrol_frame, anchor="nw")
c_katalog.bind("<Configure>", lambda e: c_katalog.itemconfig(canvas_frame, width=e.width))
c_katalog.configure(yscrollcommand=scrol.set)

# --- Фрейм Корзины ---
f_korzina = tk.Frame(f_glav, bg="#d2f6e7")
f_table_cart = tk.Frame(f_korzina)
f_table_cart.grid(row=0, column=0, padx=10, pady=10)
columns_cart = ("model", "razmer", "count", "sum")
tree_cart = ttk.Treeview(f_table_cart, columns=columns_cart, show="headings")
scroll_cart = ttk.Scrollbar(f_table_cart, orient="vertical", command=tree_cart.yview)
tree_cart.configure(yscrollcommand=scroll_cart.set)
tree_cart.pack(side="left", fill="both", expand=True)
scroll_cart.pack(side="right", fill="y")
tree_cart.heading("model", text="Модель")
tree_cart.heading("razmer", text="Размер")
tree_cart.heading("count", text="Количество")
tree_cart.heading("sum", text="Сумма")

f_knopki = tk.Frame(f_korzina)
f_knopki.grid(row=1, column=0, sticky="e", padx=(0, 30))
b_izmenit_korz = tk.Button(f_knopki, text="Изменить корзину", bg="#70b2af", font=("Calibri", 11), command=izmenit_korzinu)
b_izmenit_korz.grid(row=0, column=0, padx=5)
b_ochistit = tk.Button(f_knopki, text="Удалить позицию", bg="#70b2af", font=("Calibri", 11), command=udalit_poziciu)
b_ochistit.grid(row=0, column=1, padx=5)
b_oformit = tk.Button(f_knopki, text="Оформить заказ", bg="#70b2af", font=("Calibri", 11), command=oformit_zakaz)
b_oformit.grid(row=0, column=2, padx=5)

# --- Фрейм Заказов ---
f_zakazi = tk.Frame(f_glav, bg="#d2f6e7")
f_table_zakazi = tk.Frame(f_zakazi)
f_table_zakazi.grid(row=0, column=0, padx=10, pady=10)
columns_zakazi = ("id", "user", "data")
tree_zakazi = ttk.Treeview(f_table_zakazi, columns=columns_zakazi, show="headings")
scroll_zakazi = ttk.Scrollbar(f_table_zakazi, orient="vertical", command=tree_zakazi.yview)
tree_zakazi.configure(yscrollcommand=scroll_zakazi.set)
tree_zakazi.pack(side="left", fill="both", expand=True)
scroll_zakazi.pack(side="right", fill="y")
tree_zakazi.heading("id", text="Номер")
tree_zakazi.heading("user", text="Пользователь")
tree_zakazi.heading("data", text="Дата")

# ДОБАВЛЕНО: колонка "Производство" в таблицу позиций
b_pozicii = tk.Button(f_zakazi, text="Посмотреть позиции", command=get_podrobnie, bg="#d2f6e7")
b_pozicii.grid_remove()
b_admin_izmenit = tk.Button(f_zakazi, text="Изменить", command=get_izmenit, bg="#d2f6e7")
b_admin_izmenit.grid_remove()
# ДОБАВЛЕНО: кнопки создания и удаления заказа
b_create_zakaz = tk.Button(f_zakazi, text="Создать заказ", command=create_new_zakaz, bg="#70b2af")
b_create_zakaz.grid_remove()
b_delete_zakaz = tk.Button(f_zakazi, text="Удалить заказ", command=delete_zakaz, bg="#ff8080")
b_delete_zakaz.grid_remove()

# Таблица позиций заказа
f_pozicii_frame = tk.Frame(f_zakazi, bg="#d2f6e7")
# ДОБАВЛЕНО: колонка "proizvodstvo" (производство)
columns_poz = ("id_zakazi", "model", "proizvodstvo", "razmer", "count", "sum")
tree_pozicii = ttk.Treeview(f_pozicii_frame, columns=columns_poz, show="headings")
scroll_poz = ttk.Scrollbar(f_pozicii_frame, orient="vertical", command=tree_pozicii.yview)
tree_pozicii.configure(yscrollcommand=scroll_poz.set)
tree_pozicii.pack(side="left", fill="both", expand=True)
scroll_poz.pack(side="right", fill="y")
tree_pozicii.heading("id_zakazi", text="№ Заказа")
tree_pozicii.heading("model", text="Модель")
tree_pozicii.heading("proizvodstvo", text="Производство")
tree_pozicii.heading("razmer", text="Размер")
tree_pozicii.heading("count", text="Кол-во")
tree_pozicii.heading("sum", text="Сумма")

# --- Фрейм Деталей товара ---
f_detali = tk.Frame(f_glav, bg="#d2f6e7")

# ==============================================================================
# 7. ЗАПУСК ПРИЛОЖЕНИЯ
# ==============================================================================
katalog()
window.mainloop()
# d2f6e7 - доп фон
# 70b2af - акцент
# ff8080 - меньше 2
# Win1251 - кодировка подключения