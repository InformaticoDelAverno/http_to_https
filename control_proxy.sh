#!/bin/bash

# Mensaje de ayuda
show_help() {
    echo "Control del Proxy Nginx con Docker Compose"
    echo "Uso: $0 [start|stop]"
    echo ""
    echo "Opciones:"
    echo "  start    Iniciar el proxy"
    echo "  stop     Detener el proxy"
    echo "  -h, --help  Mostrar este mensaje de ayuda"
}

# Función para iniciar el proxy
start_proxy() {
    echo "Iniciando el proxy..."
    docker compose up -d
}

# Función para detener el proxy
stop_proxy() {
    echo "Deteniendo el proxy..."
    docker compose down
}

# Verificar los argumentos
if [ $# -eq 0 ]; then
    show_help
    exit 1
elif [ "$1" == "start" ]; then
    start_proxy
elif [ "$1" == "stop" ]; then
    stop_proxy
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help
else
    echo "Error: Argumento no reconocido."
    show_help
    exit 1
fi
