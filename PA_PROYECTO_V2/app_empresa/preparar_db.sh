#!/bin/bash

IP_DB="192.168.40.10"
IP_SCP="10.0.2.2"
DIR="/vagrant/app_empresa"
# DIR_SQL="/vagrant/db/pa_copia_database.sql"
DIR_SQL="/vagrant/db/"
LOG="preparar_db_log.log"
PASSWORD="PA123"
LIMITE_KB=10240 # 10MB

log_date() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> $LOG
}

# NUEVA FUNCIÓN: Generar nombre de fichero con la fecha de creación
file_date() {
    local FECHA=$(date '+%Y-%m-%d_%H-%M-%S')
    echo "${FECHA}_pa_copia_database.sql"
}

# NUEVA FUNCIÓN: Limpieza de logs
if [ -f "$LOG" ]; then
    SIZE_LOG=$(du -k "$LOG" | cut -f1)

    if [ "$SIZE_LOG" -gt "$LIMITE_LOG" ]; then
        echo "" > $LOG
        log_date "ARCHIVO VACIADO POR SUPERAR LOS 10MB"
    fi
fi

# Verificacion de conexion
if ! ping -c 3 $IP_DB; then
    log_date "ERROR: Server DB fuera de conexión"
    exit 1
fi

# Backup de la DB
# NUEVO: Se implementa la función para añadir la fecha al fichero
NAME_SQL=$(file_date) 
RUTA_FULL="${DIR_SQL}${NAME_SQL}"
mysqldump -h $IP_DB -u PAdmin -p$PASSWORD PATRIMONIUM_ALMEIDAE > "$RUTA_FULL" 2>/dev/null

# Verificación del archivo sql
if [ ! -f "$RUTA_FULL" ]; then
    log_date "ERROR: Archivo SQL no creado"
    exit 2
else
    log_date "Backup DB creado"
fi 
 
# Extraer datos
if [ ! -f "$DIR/conector.py" ]; then
    log_date "ERROR: Conector.py no encontrado"
    exit 3
fi 

python3 "$DIR/conector.py"

# Verificación del archivo txt
if [ ! -f "$DIR/datos.txt" ]; then
    log_date "ERROR: Archivo TXT no creado"
    exit 4
else
    log_date "datos.txt creado"
fi

# Permisos
chmod 666 "$DIR/datos.txt"

# Enviar datos a ServerAD
if scp "$DIR/datos.txt" "mañana@$IP_SCP:C:\Users\mañana\Desktop\PA_WIN"; then
    log_date "datos.txt enviado"
else
    log_date "ERROR: SCP Fallido para datos.txt"
fi

# NUEVO: Enviar SQL a ServerAD
if scp "$RUTA_FULL" "mañana@$IP_SCP:C:\Users\mañana\Desktop\PA_WIN\COPIAS_DATABASE"; then
    log_date "Archivo SQL enviado"
else
    log_date "ERROR: SCP Fallido para SQL"
fi