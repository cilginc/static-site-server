# Static Site Server Project

## Introduction

I don't want to pay cloud providers, so I'll use my own Ubuntu container in Docker. To use SSH in Docker, we need to assign the SSH port to a different port:

```yaml
port: 2222:22
```

However, you don't need to do this manually—I have already created a `docker-compose.yml` file for you. Just run the following commands:

```sh
git clone https://github.com/cilginc/static-site-server.git
cd static-site-server
docker-compose up -d
```

Then, connect to the container using:

```sh
ssh root@localhost -p 2222
```

The default password is `root`. If you want to change the default SSH port or password, you can modify the values in the Dockerfile. Just don't forget to rebuild the container with:

```sh
docker-compose up -d --build
```

whenever you make changes to the Dockerfile.

---

## Setting Up SSH Keys for Faster Deployment

Setting up SSH keys will allow secure and faster development, especially for the deployment script.

```sh
ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2222 root@localhost
```

---

## Installing Dependencies

We could install these dependencies when building the Dockerfile, but since we're simulating cloud providers, we will install them manually.

### Install Nginx

```sh
apt-get update
apt-get install nginx -y
```

Verify the installation:

```sh
nginx -v
```

### Install Rsync

```sh
apt-get install rsync -y
```

---

## Setting Up the Website

I used [v0.dev](https://v0.dev) to generate a static portfolio website schema, but you can use any website you prefer.

### Configuring Nginx to Host the Website

Create the directory for the website files:

```sh
mkdir -p /data/www
```

Edit the Nginx configuration:

```sh
vim /etc/nginx/nginx.conf
```
Delete all the lines and:

Add the following configuration (you may need to install your preferred text editor):

```nginx
worker_processes 1;

events {
    worker_connections 1024;
}

http {
    server {
        listen 8000;
        root /data/www;
        index index.html;
    }
}
```

Restart Nginx:

```sh
nginx
nginx -t
nginx -s reload
```

Now, if you visit `localhost:8000` in your browser, you should see the website running.
But it says 403 Forbidden  because we still don't uploaded html file to docker.
### Using rsync to Upload `index.html` to the Docker Machine

```sh
rsync -a -e "ssh -p 2222" ./index.html root@localhost:/data/www/
```
# Reload Nginx Again
```sh
nginx -s reload
```
---

## Automating Deployment with a Bash Script

Make the deployment script executable:

```sh
chmod +x deploy.sh
./deploy.sh
```

This script will automate the necessary steps to deploy updates to the website.

---

Now, everything should be set up and running smoothly!

This project is part of [roadmap.sh](https://roadmap.sh/projects/static-site-server) DevOps projects.
