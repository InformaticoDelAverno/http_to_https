#!/bin/sh

# Reemplazar las variables de entorno en el template y crear nginx.conf.template
envsubst '$PROXY_PASS_URL' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Iniciar Nginx
nginx -g 'daemon off;'
