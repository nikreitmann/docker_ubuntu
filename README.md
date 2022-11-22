# docker_ubuntu
A custom ubuntu jammy container

## Description
Custom Ubuntu jammy container:
- creates a user with userhome
- set locales UTF-8
- set timezone
- install some packages
- configure group sudo to use sudo without password

## Environment variables
```
$USER       default: ubuntu
$PASSWORD   default: password
$TIMEZONE   default: Europe/Zurich
```

## Run Container
```
docker run -d \
  --name ubuntu \
  -e USER=ubuntu \
  -e PASSWORD=password \
  -e TIMEZONE=Europe/Zurich \
nikreitmann/ubuntu:latest
```
