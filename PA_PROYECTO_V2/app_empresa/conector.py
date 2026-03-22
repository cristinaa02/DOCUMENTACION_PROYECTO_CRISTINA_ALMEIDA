import mysql.connector

print("--- EXTRAYENDO DATOS DEL MES ACTUAL ---")

# 1. CONEXIÓN
conexion = mysql.connector.connect(
    host="192.168.40.10", 
    user="PAdmin",
    password="PA123",
    database="PATRIMONIUM_ALMEIDAE"
)

cursor = conexion.cursor()

# 2. CONSULTA SQL
query = """
SELECT * FROM ENTRADA 
WHERE MONTH(FECHA_RESERVA) = MONTH(CURDATE()) 
  AND YEAR(FECHA_RESERVA) = YEAR(CURDATE())
"""

cursor.execute(query)
resultados = cursor.fetchall()

# 3. GUARDAR EN ARCHIVO LIMPIO
ruta_archivo = "/vagrant/app_empresa/datos.txt"

with open(ruta_archivo, "w", encoding="utf-8") as fichero: # Abre el canal
    print(f"Escribiendo {len(resultados)} registros...")
    for fila in resultados:
    # fila es una tupla con datos mixtos (int, date, decimal, string...)
    
        lista_limpia = []
        
        for dato in fila:
            # str(dato) convierte:
            # - datetime.date(2025, 12, 1)  ---> "2025-12-01"
            # - Decimal('20.00')            ---> "20.00"
            lista_limpia.append(str(dato))
        
        # Unimos todo con comas y escribimos
        linea = ",".join(lista_limpia)
        fichero.write(linea + "\n")
    fichero.flush()

cursor.close()
conexion.close()

print("¡Hecho! Archivo datos.txt actualizado y limpio.")