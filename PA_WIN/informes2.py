import sys
import os
from datetime import datetime

print("--- INICIANDO PATRIMONIUM ALMEIDAE: GENERADOR DE INFORMES ---")

lista_fecha=[]
lista_tipo=[]
lista_evento=[]
lista_precio=[]
lista_estado=[]

fichero = 'datos.txt'
fecha=datetime.now().strftime("%Y-%m-%d")

# Comprobar existencia del archivo.
if os.path.exists(fichero):
    print(f"Leyendo archivo: {fichero}...")
    with open(fichero, 'r', encoding='utf-8') as file:
        for linea in file:
            linea=linea.strip()
            if not linea: continue # Saltarse líneas vacías

            datos=linea.split(',')
            if datos[1] != fecha: continue # Saltarse dato si no coindice con la fecha de hoy

            lista_fecha.append(datos[1])
            lista_precio.append(float(datos[2]))
            lista_tipo.append(datos[3].lower())
            lista_estado.append(datos[4].lower())
            lista_evento.append(datos[6])
    
    print(f"Se han cargado {len(lista_fecha)} registros correctamente.\n")

else:
    print(f"ERROR: El archivo '{fichero}' no existe.")
    sys.exit()

# --- PROGRAMA PRINCIPAL ---

visitantes=0
recaudacion=0.0
# Tipos de entrada
tipo_adulto=0
tipo_infantil=0
tipo_escolar=0
tipo_jubilado=0
# Eventos

# Incidencias
cancelada=0
no_utilizada=0

cont=0
for entrada in lista_estado:
    cont += 1
    if entrada == 'activa':
        visitantes += 1
        recaudacion += lista_precio[cont-1]
        
        # Tipos de entrada
        match lista_tipo[cont-1]:
            case 'adulto':
                tipo_adulto += 1
            case 'infantil':
                tipo_infantil += 1
            case 'escolar':
                tipo_escolar += 1
            case 'jubilado':
                tipo_jubilado += 1

    else:
        # Si no es válida
        match lista_estado[cont-1]:
            case 'cancelada':
                cancelada += 1
            case 'no utilizada':
                no_utilizada += 1

# --- ARGUMENTOS ---

print(" === INICIANDO GENERADOR DE INFORMES ===")
print(" ================ MENU =================")
print(" 1. Gestión Cultural.")
print(" 2. Contabilidad.")
print(" 3. Exit.")
print(" =======================================")

opcion = input("Seleccione su departamento (1 o 2): ")

intentos = 3
acceso = False
nombre_archivo = ""

if opcion == "3":
    print("Saliendo...")
    sys.exit()

while intentos > 0:
    password = input("Introduzca la contraseña: ")

    # --- VALIDACIÓN DE CONTRASEÑA ---

    if opcion == "1" and password == "cultural":
        acceso = True
        nombre_archivo = rf"//Server-ad-pa/patrimonium_almeidae/Gestion Cultural/informe_cultural_{fecha}.txt"
        break
    elif opcion == "2" and password == "contable":
        acceso = True
        nombre_archivo = rf"//Server-ad-pa/patrimonium_almeidae/Contabilidad/informe_contabilidad_{fecha}.txt"
        break

    if not acceso:
        intentos=intentos-1
        print("ERROR: Contraseña incorrecta o departamento inválido.")
        if intentos==0:
            sys.exit()


# --- GENERACIÓN DE FICHEROS TXT ---
print("GENERANDO ARCHIVO...")
with open(nombre_archivo, 'w', encoding='utf-8') as f:
    
    if opcion == "1":
        # GESTIÓN CULTURAL: Estadísticas + Incidencias
        f.write("MUSEO PATRIMONIUM ALMEIDAE - GESTIÓN CULTURAL\n")
        f.write(f"Fecha: {fecha}\n")
        f.write("---------------------------------------------\n")
        f.write("\n")
        f.write(f"VISITANTES TOTALES: {visitantes}\n")
        f.write("\n")
        f.write("DESGLOSE POR TIPO:\n")
        f.write(f"- Adulto:   {tipo_adulto}\n")
        f.write(f"- Infantil: {tipo_infantil}\n")
        f.write(f"- Escolar:  {tipo_escolar}\n")
        f.write(f"- Jubilado: {tipo_jubilado}\n")
        f.write("\n")
        f.write("INCIDENCIAS:\n")
        f.write(f"- Canceladas:   {cancelada}\n")
        f.write(f"- No utilizadas: {no_utilizada}\n")
        
    elif opcion == "2":
        # CONTABILIDAD: Recaudación + Estadísticas (SIN Incidencias)
        dinero_fmt = f"{recaudacion:.2f}".replace('.', ',')
        
        f.write("MUSEO PATRIMONIUM ALMEIDAE - CONTABILIDAD\n")
        f.write(f"Fecha: {fecha}\n")
        f.write("---------------------------------------------\n")
        f.write("\n")
        f.write(f"RECAUDACIÓN TOTAL: {dinero_fmt} EUR\n")
        f.write(f"ENTRADAS VENDIDAS: {visitantes}\n")
        f.write("\n")
        f.write("NOTA: Para información más detallada, contacte con el departamento de Gestión Cultural.\n")

print(f"¡ÉXITO! Se ha generado el archivo: {nombre_archivo}")