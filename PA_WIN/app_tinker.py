import tkinter as tk
import subprocess
import os

# --- CONFIGURACIÓN ---
# Ruta real en TU WINDOWS para que Python pueda "ver" si el archivo existe
RUTA_LOCAL = r"C:\Users\mañana\Desktop\PA_PROYECTO"
VM = "serverWeb1"

def verificar_y_ejecutar(comando_vm, ruta_relativa_win, luz, nombre):
    """
    1. Ejecuta el comando DENTRO de la VM.
    2. Verifica si el archivo existe DESDE Windows.
    """
    lbl_res.config(text=f"⏳ Procesando {nombre}...", fg="black")
    root.update()

    # Ejecutar en la VM
    subprocess.run(f'vagrant ssh {VM} -c "{comando_vm}"', shell=True)

    # Verificar desde Windows (unimos la carpeta base con la ruta del archivo)
    ruta_total_win = os.path.join(RUTA_LOCAL, ruta_relativa_win)
    
    if os.path.exists(ruta_total_win):
        luz.config(bg="green")
        lbl_res.config(text=f"✅ {nombre} encontrado", fg="green")
    else:
        luz.config(bg="red")
        lbl_res.config(text=f"❌ {nombre} no detectado en Windows", fg="red")

def enviar_scp():
    # El SCP se lanza desde la VM, no desde Windows
    comando = "scp /vagrant/app_empresa/datos.txt mañana@10.0.2.2:/home/mañana/Desktop/PA_WIN"
    res = subprocess.run(f'vagrant ssh {VM} -c "{comando}"', shell=True, capture_output=True)
    
    if res.returncode == 0:
        lbl_res.config(text="✅ SCP Enviado", fg="green")
    else:
        lbl_res.config(text="❌ Error en SCP", fg="red")

# --- INTERFAZ ---
root = tk.Tk()
root.title("Gestor PA")
root.geometry("400x400")

tk.Label(root, text="Panel de Control", font=("Arial", 14, "bold")).pack(pady=20)

# Botón SQL - Ruta relativa desde la carpeta del proyecto
luz_sql = tk.Label(root, width=2, bg="grey"); luz_sql.pack()
tk.Button(root, text="Backup SQL", width=25,
          command=lambda: verificar_y_ejecutar("cd /vagrant/app_empresa && ./preparar_db.sh", 
                                             "db/pa_copia_database.sql", luz_sql, "SQL")).pack(pady=5)

# Botón TXT
luz_txt = tk.Label(root, width=2, bg="grey"); luz_txt.pack()
tk.Button(root, text="Datos TXT", width=25,
          command=lambda: verificar_y_ejecutar("python3 /vagrant/app_empresa/conector.py", 
                                             "app_empresa/datos.txt", luz_txt, "TXT")).pack(pady=5)

tk.Button(root, text="EJECUTAR ENVÍO SCP", bg="#2196F3", fg="white", font=("Arial", 10, "bold"),
          command=enviar_scp).pack(pady=20)

lbl_res = tk.Label(root, text="Listo")
lbl_res.pack()

root.mainloop()