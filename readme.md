# Docker "Swarm Mode" Cluster with Vagrant on Windows
This is a Vagrant configuration for a Docker **Swarm Mode** Cluster with the following topology:
* 1 drained manager node (no container will run on this node)
* 2 worker nodes
* 1 Nginx load balancer on port 8080, configured to listen to workers on port 80

## Installation
* install Virtualbox >= 5.1
* install Git
* install Vagrant >= 1.8.5

## Configuration
* configure ssh client for Vagrant using ssh in Git (cmd prompt as Admin)
```
    setx PATH "%PATH%;C:\Users\<user_name>\AppData\Local\Programs\Git\usr\bin"
```
* optional, modify vagrant global working dir
```
    setx VAGRANT_HOME "X:/your/path" /M
```

## Run
* clone this repository
* run Vagrant pointing the Vagrantfile folder (cmd prompt)
```
    vagrant up
```
* NOTE: in presence of a SSL error during initial box dowload phase, run first the following commands
```
    vagrant box add --insecure ubuntu/trusty64
    vagrant up
```

## Test Cluster Configuration
* ssh into manager01
```
    vagrant ssh manager01
```
* at manager01 prompt [*vagrant@manager01:~$*]
```
    docker node ls
```
* should list 
    * 1 manager: Ready, Drain, Leader
    * 2 workers: Ready, Active
* exit manager
```
    exit
```

## Test Cluster
* ssh into manager01
```
    vagrant ssh manager01
```
* at manager01 prompt [*vagrant@manager01:~$*]
```
    docker network create -d overlay nodeping
    docker service create --name nodeping --network nodeping --publish 80:8080 --replicas 5 robymes/dockerswarm
```
* wait for service running
```
    docker service ls #**REPLICAS** should be **5/5**
``` 
* point your browser to **http://localhost:8080**, should receive a JSON ok response
* point your browser to **http://localhost:8080/ping**, should receive a JSON response with container IP config details
* refresh several times, *instanceId* property should change in load balancing 
