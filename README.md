# Static Site Server Project

I don't want to give money to cloud providers so I will use my own ubuntu container in docker. To use ssh in docker we need to assign the ssh port to a different port.

```
port: 2222:22
```

like this but you don't need to do this i already maked a docker-compose file for you just

```
git clone https://github.com/cilginc/static-site-server.git
cd static-site-server
docker-compose up -d
```

and connect like this

```
ssh root@localhost -p 2222
```

the default password is root
if you want to change default port or default password you can change the values in the dockerfile
just don't forget to use

```
docker-compose up -d --build
```

when you change someting in your dockerfile

# Set SSH keys for speed development (needed for deployment script)
```
ssh-keygen -t rsa -b 4096 
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2222 root@localhost
```
# Install Dependincies

We could install this dependincies when building dockerfile but since were simulating cloud providers we are installing dependincies manually

# Install Nginx

```
apt-get update
apt-get install nginx
```

verify the installation by doing

```
nginx -v
```

# Install Rsync

```
apt-get install rsync
```

# Website

I asked v0.dev for a static portfolio website now i got a portfolio website schema you can use whatever website you want.

# Using rsync to send index.html to docker machine

```
rsync -a -e "ssh -p 2222" ./index.html root@localhost:/data/www/
```

# Configuring nginx to host website

```
mkdir -p /data/www
vim /etc/nginx/nginx.conf
```

and write this (you may need to install your favorite text editor we are gonna automate that later)

```
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

~
```

<!--i can use tee when writing bash script-->

and everything just works if we go to localhost:8000 we can see website is running

# Bash script time 
'''
chmod +x deploy.sh
./deploy.sh
'''
you can put this deploy.sh into path if you want to use this script anywhere
