# Running Apache Storm 0.9.3 on High Availability mode

This project shows how to launch a Storm cluster in high availability mode, which can be used for production, staging or development. This project contains Marathon recipes which are used to launch Storm-Docker containers on Apache Mesos with Marathon. We are using the base Docker image of Debian Wheezy. With Marathon we can deploy a cluster through Marathon REST Api or through Marathon Web UI in high availability mode.

Deploying or scaling a new Storm cluster is very fast and easy (running a single script or just Marathon UI). Docker allows us to deploy any version of an App (Storm in our case) on Apache Mesos while isolating the processes. Similar approach can be used to deploy any other distributed App on Apache Mesos in high availability mode i.e Hadoop, Spark etc. 

## Benefits
* Running Storm over Marathon provides fault tolerance for machine failures i.e High Availability. 
* Docker containers provides resource isolation for Storm processes.
* Deploy multiple (e.g 3) instances of Storm Nimbus server, Zookeeper or Supervisor easily without changing storm.yaml file.
* Service Discovery mechanism of HAProxy and Marathon enables very fast and easy cluster deployment and scaling, where we dont really worry about the hostname/ip of where a specific instance will be launched. The cluster will smartly find all the new instances/containers and glue them together (HAProxy). 

## Prerequisites
* Install [Mesosphere Cluster] (http://mesosphere.com/docs/getting-started/datacenter/install/). This will install [Apache Mesos]( http://mesos.apache.org/) and [Marathon]( https://mesosphere.github.io/marathon/).
* Install [Docker] (https://docs.docker.com/installation/debian/) on each Debian cluster node.

## Cluster Setup 
Before launching the Storm Docker containers, make sure Docker support is enabled and HAProxy is installed and configured as following:

### Enable Docker support on Mesos cluster:
Follow the Mesosphere [tutorial](https://mesosphere.github.io/marathon/docs/native-docker.html) for enabling Docker support on Mesos. Make sure to increase the execution timeout for a possible delay in pulling a Docker image on each slave node and also while re-launching Marathon ('--task_launch_timeout 5mins').

###  Enable HAProxy on Mesos cluster
Mesosphere cluster is shipped with a script ['haproxy_marathon_bridge'](https://github.com/mesosphere/marathon/blob/master/bin/haproxy-marathon-bridge) which installs and configures HAProxy automatically. It essentially pings Marathon REST API ones a minute (cron job) and parse the list of tasks,IPs and ports into a new HAProxy configuration file and reload HAProxy to load the new changes. Replace Marathon host name in 'yourmarathonhostname' and execute the following command on each cluster node:

    ./usr/local/bin/haproxy_marathon_bridge install_haproxy_system yourmarathonhostname:8080

For more options and configurations, see this [tutorial](https://mesosphere.github.io/marathon/docs/service-discovery-load-balancing.html).


## Launching the Cluster

Clone the repository:

    git clone https://github.com/obaidsalikeen/storm-marathon.git
    cd storm-marathon

Update each Marathon recipe (zookeeper.json, storm-nimbus.json etc) with your Mesos Master hostname/IP. Each Docker image will use this environment variable to replace the zookeeper and nimbus host name in storm.yaml configuration file. Just using this hostname along with the default ports, supervisors and UI will be able to locate nimbus or zookeeper. HAProxy will round-robin the requests to any appropiate Nimbus instance or zookeeper instance, providing load-balancing incase or multiple nimbus or zookeeper instances:

    "env": {"MASTER_HOSTNAME": "yourmasterhostname"}

Using the Marathon REST API with the correct Marathon hostname, launch Zookeeper, Nimbus, UI and Supervisor instances (it takes 1 min for loading new configurations to HAProxy where as few more minutes for the Docker images to be downloaded to a slave):

    curl -H "Content-Type: application/json"  -d @marathon/zookeeper.json http://yourmarathonhostname:8080/v2/apps
    curl -H "Content-Type: application/json"  -d @marathon/storm-nimbus.json http://yourmarathonhostname:8080/v2/apps
    curl -H "Content-Type: application/json"  -d @marathon/storm-ui.json http://yourmarathonhostname:8080/v2/apps
    curl -H "Content-Type: application/json"  -d @marathon/storm-supervisor.json http://yourmarathonhostname:8080/v2/apps

## Verify Installation

Since Marathon runs on port 8080, the Storm UI is configured to run on port 8888:

    http://yourMesosMasterHostname:8888/

UI might take a minute to connect to Nimbus, depending on how much time it takes for the cron job to update and reload HAProxy on Mesos Master and other nodes in the cluster.

## Launching a Topology

You can either launch a topology from any other Docker container within the cluster or install Storm on any slave machine and launch a topology using the same mesos master hostname for zookeeper and nimbus. Simply launch your topology from a slave machine with your jar and class name :

    /etc/init.d/storm jar youtJarFile.jar com.your.driver.class.name 


## Docker Images
Docker images are accessible on docker hub : 

    https://hub.docker.com/u/obaidsalikeen/

## References

* Help for scripting and docker image files was taken from  [wurstmeister/storm-docker](https://github.com/wurstmeister/storm-docker) 
* Mesosphere tutorial on Docker Clustering: [Docker Clustering on Mesos with Marathon](https://www.youtube.com/watch?v=hZNGST2vIds)
* HAProxy tutorial : [HAProxy and load balancing concepts](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts)



