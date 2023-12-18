FROM nginx:alpine
RUN apk add --no-cache openssl envsubst

# Copiar archivos de configuración y scripts
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start-nginx.sh /start-nginx.sh

# Dar permiso de ejecución al script
RUN chmod +x /start-nginx.sh

# Exponer puerto
EXPOSE 443

CMD ["/start-nginx.sh"]
