#!/bin/bash

cd /opt
git clone https://github.com/rizl-ad/shvirtd-example-python
cd /opt/shvirtd-example-python
docker compose up -d
