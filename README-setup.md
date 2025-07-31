#### What is imputationserver2?

This is a fork of https://github.com/genepi/imputationserver2.


#### Install Packages

```
sudo dnf update -y
sudo dnf install -y emacs git
sudo dnf install -y java-21-amazon-corretto java-21-amazon-corretto-devel java-21-amazon-corretto-headless
```


#### Install Nextflow

```
# install
curl -s https://get.nextflow.io | bash
chmod 755 nextflow
sudo mv nextflow /usr/local/bin/
export PATH=/usr/local/bin:$PATH

# smoke test
nextflow run hello
```


#### Install Docker

```
sudo dnf install -y docker

# add user to docker group
sudo usermod -a -G docker $USER

systemctl status docker
sudo systemctl start docker
```


#### Clone Imputation Server

```
git clone git@github.com:KailosGenetics/imputationserver2.git

# Not sure we'll use this below
cd imputationserver2
docker build -t genepi/imputationserver2:latest . 

