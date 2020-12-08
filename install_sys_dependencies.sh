#!/bin/bash

set -o errexit

apt-get -y update
apt-get -y dist-upgrade
apt-get -y install\
 gdal-bin\
 libgdal-dev\
 libjq-dev\
 libprotobuf-dev\
 libudunits2-dev\
 libnode-dev\
 libgeos-dev

