#!/bin/sh
cat << EOS > /etc/apt/preferences.d/k8s.pref
Package: kubernetes-cni
Pin: version 0.6.0-00*
Pin-Priority: 900
EOS
