# Docker "Swarm Mode" cluster with Vagrant
This is a Vagrant configuration for a Docker **Swarm Mode** Cluster with the following topology:
* 1 drained manager node (no container will run on this node)
* 2 worker nodes
* 1 Nginx load balancer on port 8080, configured to listen to workers on port 80


## System prerequisites
* install Virtualbox >= 5.1
* install Git >= 2.9
* install Vagrant >= 1.8.5

## System configuration: Microsoft Windows
* configure ssh client for Vagrant using ssh in Git (cmd prompt as Admin)
    
    depending on your Git installation path
```
    setx PATH "%PATH%;%UserProfile%\AppData\Local\Programs\Git\usr\bin"
```
```
    setx PATH "%PATH%;%ProgramFiles%\git\usr\bin"
```
* optional, modify Vagrant global working dir (where Vagrant dowloads boxes) 
```
    setx VAGRANT_HOME "X:\your\path" /M
```

## Run
* clone this repository
* run Vagrant pointing the Vagrantfile folder (cmd prompt)
```
    vagrant up
```
* NOTE: in presence of a SSL error during initial box dowload phase, run the following commands
```
    vagrant box add --insecure ubuntu/trusty64
    vagrant up
```
* **Windows only**: if you still have problems downloading Vagrant box, try install [VC++ redist. package](https://www.microsoft.com/en-us/download/confirmation.aspx?id=8328)

## Verify cluster configuration
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

## Test cluster
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
    docker service ls #REPLICAS column should be 5/5
``` 
* point your browser to **http://localhost:8080**, should receive a JSON ok response
* point your browser to **http://localhost:8080/ping**, should receive a JSON response with container IP config details
* refresh several times: *instanceId* property should change in load balancing 

## Modify cluster configuration
* modify Vagrantfile to:
    * add more managers and workers
    * change port forwarding to Vagrant host
* change Nginx load balancer configuration file (for example if you add more workers you have to add the new ones in the *upstream* section)
* ...
