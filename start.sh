#!/bin/bash

# Reemplazar variables de entorno en el archivo de configuración
sed -i "s/\${PORT}/$PORT/g" /etc/odoo/odoo.conf
sed -i "s/\${DB_HOST}/$DB_HOST/g" /etc/odoo/odoo.conf
sed -i "s/\${DB_PORT}/$DB_PORT/g" /etc/odoo/odoo.conf
sed -i "s/\${DB_USER}/$DB_USER/g" /etc/odoo/odoo.conf
sed -i "s/\${DB_PASSWORD}/$DB_PASSWORD/g" /etc/odoo/odoo.conf
sed -i "s/\${DB_NAME}/$DB_NAME/g" /etc/odoo/odoo.conf

# Iniciar Odoo
exec odoo --config=/etc/odoo/odoo.conf 