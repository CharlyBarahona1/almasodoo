FROM odoo:18.0

# Cambiar a root para instalar paquetes adicionales
USER root

# Instalar dependencias básicas
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libpq-dev \
    gcc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    wkhtmltopdf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instalar wheel
RUN pip3 install --no-cache-dir wheel

# Crear directorios necesarios
RUN mkdir -p /mnt/extra-addons /tmp/odoo && \
    chown -R odoo:odoo /mnt/extra-addons /tmp/odoo

# Copiar configuración
COPY odoo.conf /etc/odoo/odoo.conf

# Cambiar al usuario odoo
USER odoo

# Exponer puerto
EXPOSE 10000

# Iniciar Odoo
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
