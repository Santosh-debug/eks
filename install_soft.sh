#! /bin/bash
#Update all installed packages.
sudo apt-get update -y
sudo apt-get upgrade -y

# install curl
sudo apt-get install curl -y

#if you get an error similar to
#'[ERROR Swap]: running with swap on is not supported. Please disable swap', disable swap:
sudo swapoff -a

# install Kops
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Adding env variables in .bashrc file
sudo echo "export KOPS_CLUSTER_NAME=prudential.in" >> ~/.bashrc
sudo echo "export KOPS_STATE_STORE=s3://prudential-terrastate" >> ~/.bashrc
sudo source ~/.bashrc

