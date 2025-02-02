#!/usr/bin/env bash
rsync -a -e "ssh -p 2222" ./index.html root@localhost:/data/www/index.html
ssh root@localhost -p 2222 "nginx -s reload"
