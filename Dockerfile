FROM centos:7.6.1810

RUN yum install zsh epel-release git unzip docker jq -y

RUN curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz  && \
  tar xvf ./helm.tar.gz && \
  mv ./linux-amd64/helm /usr/local/bin/helm && \
  rm -rf ./linux-amd64

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo && \
  yum install azure-cli -y && \
  az aks install-cli

RUN curl -o terraform.zip https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && \
  unzip ./terraform.zip && \
  rm terraform.zip && \
  chmod u+x ./terraform

RUN chsh -s /bin/zsh

RUN git config credential.helper store && \
  git config --global user.name "Ray Crawford (Insight)" && \
  git config --global user.email "ray.crawford@insight.com" && \
  git config --global push.default simple

COPY shell/ /root/

WORKDIR /Users/racrawford/workarea

CMD ["/bin/zsh"]

# Commands:
# cp ~/.zsh* ./shell/
# cp -rp ~/.oh-my-zsh ./shell/
# export version=v1.0; docker build --tag magicmix:${version} .; docker tag magicmix:${version} magicmix:latest
# docker run --rm --name magicmix -it \
#   -v /Users:/Users \
#   magicmix:latest

