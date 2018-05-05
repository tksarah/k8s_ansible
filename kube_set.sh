#!/bin/bash

if [ -d $HOME/.kube ]; then
  echo ".kube exists"
else
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
fi


### For Dashboard
if [ -f kubecfg.crt ]; then
  echo "kubecfg.crt exists"
else
  grep 'client-certificate-data' $HOME/.kube/config | head -n 1 | awk '{print $2}' | base64 -d >> kubecfg.crt
fi

if [ -f kubecfg.key ]; then
  echo "kubecfg.key exists"
else
  grep 'client-key-data' ~/.kube/config | head -n 1 | awk '{print $2}' | base64 -d >> kubecfg.key
fi

if [ -f kubecfg.p12 ]; then
  echo "kubecfg.p12 exists"
else
  openssl pkcs12 -export -clcerts -inkey kubecfg.key -in kubecfg.crt -out kubecfg.p12 -name "kubernetes-client"
fi
