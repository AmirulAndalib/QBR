#!/bin/bash

git clone https://github.com/AmirulAndalib/QBR

cd QBR

git clone --depth 1 --single-branch --branch latest-release https://github.com/WDaan/VueTorrent.git .VueTorrent

ls

mkdir .config
mkdir .config/rclone

chmod +x .config
chmod+x qBittorrent
chmod+x qBittorrent/qBittorrent.conf
chmod +x  qBittorrent/config/qBittorrent.conf

curl -L $RCLONE_CONFIG_IN_RAW_URL >.config/rclone/rclone.conf
echo $PORT >/PORT

cat qBittorrent/config/qBittorrent.conf >qBittorrent/qBittorrent.conf

echo -n "$WEBPASSWORD" |md5sum |sed 's|  -||g' >WEBHASHPASSWORD && mv WEBHASHPASSWORD /qBittorrent

cat qBittorrent/qBittorrent.conf |sed "s|devanaz:|$(rclone listremotes |head -1)|g" |

sed "s|developeranaz|$WEBUSER|g" |sed "s|bc89e64478e74b30bea280349e1220ce|$(cat qBittorrent/WEBHASHPASSWORD)|g" >qBittorrent/config/qBittorrent.conf


while :
do
qbittorrent-nox --profile= .--webui-port="$(cat /PORT)"
done
