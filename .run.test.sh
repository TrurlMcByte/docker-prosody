#!/bin/sh
#
CON_NAME=prosody_1
IMG_VER=0.9-hg
IMG_BASE_NAME="trurlmcbyte/prosody"
IMG_NAME="$IMG_BASE_NAME:$IMG_VER"

#test -f ./build.log && mv -b ./build.log ./build.log.old
#docker build -t $IMG_NAME . &> ./build.log || exit 1

docker stop $CON_NAME
docker rm $CON_NAME

docker run -d  --restart=always --name $CON_NAME \
    -p 5222:5222 \
    -l port.5222=xmpp-c2s \
    -p 5280:5280 \
    -l port.5280=xmpp-bosh \
    -p 5281:5281 \
    -l port.5281=xmpp-sbosh \
    -p 5347:5347 \
    -l port.5347=xmpp-component \
    -p 5269:5269 \
    -l port.5269=xmpp-server \
    -p 5002:5002 \
    -l port.5347=xmpp-proxy65 \
    -h $CON_NAME.$HOST \
    -e TZ=America/Los_Angeles \
    -v /etc/timezone:/etc/timezone:ro \
    -v /srv/docker/prosody/etc:/etc/prosody:ro \
    -v /srv/docker/prosody/etc/hosts:/etc/hosts:ro \
    -v /srv/docker/prosody/lib:/var/lib/prosody:rw \
    $IMG_NAME

#    --log-driver=syslog \
#    --log-opt syslog-address=udp://192.168.1.11:514 \
#    --log-opt syslog-facility=daemon \
#    --log-opt tag="$CON_NAME" \

#sleep 3s
#tail /var/log/messages
#docker export -o $CON_NAME.tar $CON_NAME

if curl -s http://home.mcbyte.net:5280/http-bind | grep -q "It works" ; then
   echo "Build $IMG_NAME is OK"
#   docker tag $IMG_NAME $IMG_BASE_NAME:latest
#   docker push $IMG_BASE_NAME
fi

echo -en "\007"
sleep 1s
echo -en "\007"
