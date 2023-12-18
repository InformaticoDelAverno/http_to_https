#!/bin/bash

# Directorio donde se almacenarán las claves y certificados
SSL_DIR="./certs"

# Variables de entorno (establecer estos valores en tu .env o entorno)
CA_KEY="${SSL_DIR}/${CA_KEY_NAME:-ca.key}"
CA_CERT="${SSL_DIR}/${CA_CERT_NAME:-ca.crt}"
SERVER_KEY="${SSL_DIR}/${SERVER_KEY_NAME:-server.key}"
SERVER_CERT="${SSL_DIR}/${SERVER_CERT_NAME:-server.crt}"
SUBJ_CA="${SUBJ_CA:-/CN=MyCA}"
SUBJ_SERVER="${SUBJ_SERVER:-/CN=localhost}"

# Crear directorio para SSL si no existe
mkdir -p "${SSL_DIR}"

# Verificar si la CA ya existe, si no, crear una nueva
if [ ! -f "${CA_KEY}" ] || [ ! -f "${CA_CERT}" ]; then
    echo "Generando nueva CA..."
    openssl genrsa -out "${CA_KEY}" 2048
    openssl req -x509 -new -nodes -key "${CA_KEY}" -sha256 -days 1024 -out "${CA_CERT}" -subj "${SUBJ_CA}"
else
    echo "Utilizando CA existente..."
fi

# Generar un certificado y clave para el servidor
echo "Generando certificado y clave para el servidor..."
openssl genrsa -out "${SERVER_KEY}" 2048
openssl req -new -key "${SERVER_KEY}" -out server.csr -subj "${SUBJ_SERVER}"
openssl x509 -req -in server.csr -CA "${CA_CERT}" -CAkey "${CA_KEY}" -CAcreateserial -out "${SERVER_CERT}" -days 500 -sha256

# Limpiar CSR
rm server.csr

echo "Certificados generados."
