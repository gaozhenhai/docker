
# Ansible install docker-ce

## DownLoad docker-ce

wget https://download.docker.com/linux/static/stable/x86_64/docker-17.03.2-ce.tgz  

## Copy docker-ce package to ansible file directory

cp docker-17.03.2-ce.tgz roles/install-docker/files/  

## Create ansible inventory

cat << EOF > ./hosts  
[slave]  
192.168.1.241:22 hostname=vm-node-241 ansible_ssh_pass=root  
192.168.1.241:22 hostname=vm-node-241 ansible_ssh_pass=root  
EOF  

## Install docker-ce with ansible

docker run --rm -v $PWD:/app gaozhenhai/ansible:v2.4.6 ansible-playbook site-docker.yml --ssh-extra-args='-o StrictHostKeyChecking=no' --extra-vars "hosts=slave" -i hosts
