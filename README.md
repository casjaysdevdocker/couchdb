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
mkdir -p "$HOME/.local/share/srv/docker/couchdb/rootfs"
git clone "https://github.com/dockermgr/couchdb" "$HOME/.local/share/CasjaysDev/dockermgr/couchdb"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/couchdb/rootfs/." "$HOME/.local/share/srv/docker/couchdb/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-couchdb \
--hostname couchdb \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/srv/docker/casjaysdevdocker-couchdb/rootfs/data:/data:z \
-v $HOME/.local/share/srv/docker/casjaysdevdocker-couchdb/rootfs/config:/config:z \
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
      - $HOME/.local/share/srv/docker/casjaysdevdocker-couchdb/rootfs/data:/data:z
      - $HOME/.local/share/srv/docker/casjaysdevdocker-couchdb/rootfs/config:/config:z
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
