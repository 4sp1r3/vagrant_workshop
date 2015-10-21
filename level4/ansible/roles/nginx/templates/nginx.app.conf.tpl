server {
    listen 80;

    server_name web.dev;
    root /vagrant;

    error_log /var/log/nginx/app.error.log;
    access_log /var/log/nginx/app.access.log;

    location / {
        index hello_world.html;
    }

}
