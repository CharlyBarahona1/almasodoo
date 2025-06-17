FROM odoo:18.0

# Cambiar a root para instalar paquetes adicionales
USER root

# Configurar repositorios y actualizar
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libpq-dev \
        gcc \
        python3-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libsasl2-dev \
        libldap2-dev \
        libjpeg-dev \
        wkhtmltopdf \
        ca-certificates \
        gnupg2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instalar wheel por separado
RUN pip3 install --no-cache-dir wheel

# Crear directorios necesarios y establecer permisos
RUN mkdir -p /mnt/extra-addons && \
    mkdir -p /tmp/odoo && \
    chown -R odoo:odoo /mnt/extra-addons && \
    chown -R odoo:odoo /tmp/odoo

# Copiar archivo de configuración
COPY odoo.conf /etc/odoo/odoo.conf

# Cambiar de nuevo al usuario odoo
USER odoo

# Exponer el puerto
EXPOSE 10000

# Comando para iniciar Odoo
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
