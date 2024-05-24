# Set default value for DM_BACKEND_PROTOCOL if not provided
if [ -z "$DM_BACKEND_PROTOCOL" ]; then
  DM_BACKEND_PROTOCOL="http"
fi

# Set default value for DM_BACKEND if not provided
if [ -z "$DM_BACKEND" ]; then
  DM_BACKEND="localhost:8888"
fi

# Replace placeholders in nginx configuration files with the values from environment variables
sed -i "s/{DM_APP_NAME}/${DM_APP_NAME}/g" /etc/nginx/nginx.conf
sed -i "s/{DM_BACKEND_PROTOCOL}/${DM_BACKEND_PROTOCOL}/g" /etc/nginx/sites-enabled/app.conf
sed -i "s/{DM_BACKEND}/${DM_BACKEND}/g" /etc/nginx/sites-enabled/app.conf
