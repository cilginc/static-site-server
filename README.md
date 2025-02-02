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
