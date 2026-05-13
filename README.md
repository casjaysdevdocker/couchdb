## 👋 Welcome to couchdb 🚀  

couchdb README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update couchdb
```
  
## Install and run container
  
```shell
dockerHome="/var/lib/srv/$USER/docker/casjaysdevdocker/couchdb/couchdb/latest/rootfs"
mkdir -p "/var/lib/srv/$USER/docker/couchdb/rootfs"
git clone "https://github.com/dockermgr/couchdb" "$HOME/.local/share/CasjaysDev/dockermgr/couchdb"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/couchdb/rootfs/." "$dockerHome/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-couchdb-latest \
--hostname couchdb \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$dockerHome/data:/data:z" \
-v "$dockerHome/config:/config:z" \
-p 80:80 \
casjaysdevdocker/couchdb:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/couchdb
    container_name: casjaysdevdocker-couchdb
    environment:
      - TZ=America/New_York
      - HOSTNAME=couchdb
    volumes:
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/couchdb/couchdb/latest/rootfs/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/couchdb/couchdb/latest/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/couchdb
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/couchdb" "$HOME/Projects/github/casjaysdevdocker/couchdb"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/couchdb"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
