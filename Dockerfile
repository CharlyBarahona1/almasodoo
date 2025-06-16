FROM odoo:18.0

# Cambiar a root para instalar paquetes adicionales
USER root

# Instalar dependencias necesarias y wkhtmltopdf
RUN apt-get update && apt-get install -y \
    libpq-dev gcc python3-dev libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev libjpeg-dev wkhtmltopdf && \
    pip3 install wheel && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear directorio para addons y establecer permisos
RUN mkdir -p /mnt/extra-addons && \
    chown -R odoo:odoo /mnt/extra-addons

# Cambiar de nuevo al usuario odoo
USER odoo
