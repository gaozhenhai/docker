#!/bin/bash

REGISTRY="index.tenxcloud.com"
DOCKER_PACKAGE="docker-17.03.2-ce.tgz"
DOCKER_SERVICE_PATH="/usr/lib/systemd/system"
DOCKER_DAEMON_PATH="/etc/docker"
COMMAND=$*

CreateDockerServiceFile(){
cat > $DOCKER_SERVICE_PATH/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target firewalld.service

[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP \$MAINPID

LimitNOFILE=1500000
LimitNPROC=infinity
LimitCORE=infinity

TimeoutStartSec=0
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
}

CreateDockerDaemonJson(){
cat > $DOCKER_DAEMON_PATH/daemon.json <<EOF
{
  "insecure-registries":["$REGISTRY"],
  "hosts": ["unix:///var/run/docker.sock"],
  "storage-driver": "devicemapper",
  "storage-opts": ["dm.basesize=10G","dm.override_udev_sync_check=true"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "20m",
    "max-file": "10"
  },
  "live-restore": true
}
EOF
}


CheckDockerExist(){
    isExist=`ps -ef | grep dockerd | grep -v grep`
    if [ -z "$isExist" ]; then
        return 0
    fi
    return 1
}

# install docker-ce
InstallDocker(){
    curl -fSL http://192.168.4.200:9000/$DOCKER_PACKAGE > $DOCKER_PACKAGE
    mkdir -p $DOCKER_DAEMON_PATH
    CreateDockerDaemonJson && CreateDockerServiceFile && systemctl daemon-reload
    tar xf $DOCKER_PACKAGE -C /usr/bin && systemctl start docker
    if CheckDockerExist; then
        echo -e "install docker-CE is failed    [ failed ]"
        exit -1
    fi
}

# running tde handle
ClusterHandle(){
    if CheckDockerExist; then
        InstallDocker
    fi
    docker run --rm -v /tmp:/tmp $REGISTRY/tenx_containers/tde:v3.0.0 $COMMAND
    sudo bash -c "$(docker run --rm -v /tmp:/tmp $REGISTRY/tenx_containers/tde:v3.0.0 $COMMAND)"
}

#dispatch different parameters
 while(( $# > 0 ))
    do
        case "$1" in
          "--registry" )
              REGISTRY="$2"
              shift 2;;
          "Join" )
              ClusterHandle
              exit 0;;
          "Init" )
              ClusterHandle
              exit 0;;
            * )
              shift 2;;
        esac
    done


