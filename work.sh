#!/bin/bash

if [ "$1" = "up" ]; then
    if [ ! -x "$(which git)" ]; then
        echo "Install git"
        yum install git -y
    fi
    git clone https://github.com/maodahua/work.git

    if [ ! -x "$(which docker)" ]; then
        echo "Install Docker"
        curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
        systemctl start docker
        systemctl enable  docker
        
        echo "Install Docker compose"
        curl -L https://github.com/docker/compose/releases/download/1.29.0/docker-compose-Linux-x86_64 > docker-compose
        chmod +x docker-compose
        mv docker-compose /usr/local/bin/
    fi

    if [ -d "work" ]; then
        cd work/jenkins
        docker build -t jenkins:work .
        docker run -p 8090:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -d jenkins:work
        cd ../ha
        docker build -t haproxy:work .
    fi
fi

if [ "$1" = "dev" ]; then
    if [ -d "work" ]; then
        cd work/local_dev/web
        docker build -t web:work .
        cd ../app
        docker build -t app:work .
        cd ..
        docker-compose up -d
    fi
fi

if [ "$1" = "down" ]; then
    if [ -d "work" ]; then
        cd work/local_dev
        docker-compose down
    fi
fi