import tkinter as tk
from tkinter import ttk

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
button1.grid(row=0, column=0, sticky="e", padx=3, pady=3)

label = tk.Label(frame, text="Магазин 'Чудо обувь'", font=("Arial", 20))
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

#фрейм с предметами
frame1 = tk.Frame(frame, width=300, bg="white")
frame1.grid(row=3, column=0, sticky="w", padx=5, pady=5)

img1 = tk.Frame(frame1, width=70, height=70, bg="grey", bd=2, relief="sunken")
img1.pack_propagate(False)
img1.grid(row=0, column=0, sticky="w", padx=5, pady=5)

frame2 = tk.Frame(frame1, width=300, bg="white")
frame2.grid(row=0, column=2, sticky="w", padx=5, pady=5)

label1 = tk.Label(frame2, text="Крутая, интересная кросовка, летний вариант, хорошо подходит как мальчикам, так и девочкам, т.д. т.п.", font=("Arial", 10), wraplength=300)
label1.grid(row=0, column=0, sticky="e", padx=5, pady=1)

label2 = tk.Label(frame2, text="10.000$", font=("Arial", 15))
label2.grid(row=1, column=0, sticky="e", padx=(0,20), pady=(0,5))

frame1 = tk.Frame(frame, width=300, bg="white")
frame1.grid(row=4, column=0, sticky="w", padx=5, pady=5)

img1 = tk.Frame(frame1, width=70, height=70, bg="grey", bd=2, relief="sunken")
img1.pack_propagate(False)
img1.grid(row=0, column=0, sticky="w", padx=5, pady=5)

frame2 = tk.Frame(frame1, width=300, bg="white")
frame2.grid(row=0, column=2, sticky="w", padx=5, pady=5)

label1 = tk.Label(frame2, text="Еще более крутая, интересная кросовка, летний вариант, хорошо подходит как мальчикам, так и девочкам, т.д. т.п.", font=("Arial", 10), wraplength=300)
label1.grid(row=0, column=0, sticky="e", padx=5, pady=1)

label2 = tk.Label(frame2, text="15.000$", font=("Arial", 15))
label2.grid(row=1, column=0, sticky="e", padx=(0,20), pady=(0,5))



frame1 = tk.Frame(frame, width=300, bg="white")
frame1.grid(row=5, column=0, sticky="w", padx=5, pady=5)

img1 = tk.Frame(frame1, width=70, height=70, bg="grey", bd=2, relief="sunken")
img1.pack_propagate(False)
img1.grid(row=0, column=0, sticky="w", padx=5, pady=5)

frame2 = tk.Frame(frame1, width=300, bg="white")
frame2.grid(row=0, column=2, sticky="w", padx=5, pady=5)

label1 = tk.Label(frame2, text="Самая крутая, интересная кросовка, летний вариант, хорошо подходит как мальчикам, так и девочкам, т.д. т.п.", font=("Arial", 10), wraplength=300)
label1.grid(row=0, column=0, sticky="e", padx=5, pady=1)

label2 = tk.Label(frame2, text="20.000$", font=("Arial", 15))
label2.grid(row=1, column=0, sticky="e", padx=(0,20), pady=(0,5))


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

b_reg = tk.Button(f_reg, text="Вход", command=go_to_shop)
b_reg.grid(row=2, column=0)

window.mainloop()
