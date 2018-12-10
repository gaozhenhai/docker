
# Ansible install docker-ce

## DownLoad docker-ce

version v17.03.2-ce

## Create ansible inventory

cat << EOF > ./hosts  
[slave]  
192.168.1.1:22 hostname=vm-node-241 ansible_ssh_pass=root  
192.168.1.2:22 hostname=vm-node-241 ansible_ssh_pass=root  
EOF  

## Install docker-ce with ansible

docker run --rm --privileged -v $PWD:/app gaozhenhai/ansible:v2.4.6 ansible-playbook site-docker.yml --ssh-extra-args='-o StrictHostKeyChecking=no' --extra-vars "hosts=slave registry=192.168.2.1" -i hosts
