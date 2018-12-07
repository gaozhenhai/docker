#!/bin/bash

GCR="k8s.gcr.io"
GAOZHENHAI="gaozhenhai"
IMAGES=(
    "kube-proxy:v1.12.3" \
    "kube-apiserver:v1.12.3" \
    "kube-controller-manager:v1.12.3" \
    "kube-scheduler:v1.12.3" \
    "etcd:3.2.24" \
    "coredns:1.2.2" \
    "pause:3.1"
)

push(){
    for i in ${IMAGES[@]}
    do
        docker tag $GCR/$i $GAOZHENHAI/$i
        docker push $GAOZHENHAI/$i
        docker rmi $GAOZHENHAI/$i
    done
}

pull(){
    for i in ${IMAGES[@]}
    do
        docker pull $GAOZHENHAI/$i
        docker tag $GAOZHENHAI/$i $GCR/$i
        docker rmi $GAOZHENHAI/$i
    done
}

Usage(){
cat <<EOF
Command: \n
    [Option] push \n
    [Option] pull \n
EOF
}

if [ "$#" -le 0 ]; then
    echo -e $(Usage)
    exit 0
fi

if [ "$1" == "pull" ]; then
    pull
elif [ "$1" == "push" ]; then
    push
else
    echo -e $(Usage)
fi
