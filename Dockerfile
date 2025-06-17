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
    git \
    && rm -rf /var/lib/apt/lists/*

# Actualizar pip e instalar wheel
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel

# Instalar dependencias de Python
RUN pip3 install --no-cache-dir \
    psycopg2-binary==2.9.9 \
    python-ldap==3.4.3 \
    python-dateutil==2.8.2 \
    pytz==2023.3 \
    reportlab==4.0.4 \
    XlsxWriter==3.1.2 \
    Jinja2==3.1.2 \
    Mako==1.2.4 \
    decorator==5.1.1 \
    requests==2.31.0 \
    zeep==4.2.1 \
    qrcode==7.4.2 \
    vobject==0.9.6.1 \
    PyPDF2==3.0.1 \
    Werkzeug==2.3.7 \
    libsass==0.22.0 \
    Babel==2.12.1 \
    docutils==0.19 \
    ebaysdk==2.2.0 \
    feedparser==6.0.10 \
    gevent==22.10.2 \
    greenlet==2.0.2 \
    html2text==2020.1.16 \
    lxml==4.9.3 \
    markupsafe==2.1.3 \
    num2words==0.5.12 \
    ofxparse==0.21 \
    passlib==1.7.4 \
    polib==1.2.0 \
    psutil==5.9.5 \
    pyserial==3.5 \
    python-stdnum==1.18 \
    pytz==2023.3 \
    qrcode==7.4.2 \
    reportlab==4.0.4 \
    requests-toolbelt==1.0.0 \
    zeep==4.2.1

# Instalar Odoo
RUN pip3 install --no-cache-dir odoo==18.0

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
