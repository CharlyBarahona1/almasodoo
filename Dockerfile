FROM python:3.10-slim-bullseye

# Instalar dependencias del sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    build-essential \
    libpq-dev \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    wkhtmltopdf \
    && rm -rf /var/lib/apt/lists/*

# Instalar Odoo y dependencias de Python
RUN pip3 install --no-cache-dir \
    odoo==18.0 \
    wheel \
    psycopg2-binary

# Crear usuario odoo
RUN useradd -ms /bin/bash odoo

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
