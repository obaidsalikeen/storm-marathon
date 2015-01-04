# Apache Storm Docker clustering on Apache Mesos with Marathon

This project contains Marathon recipes and Docker images to launch Apache Storm (0.9.3-rc1) Docker cluster on Apache Mesos with Marathon. We are using the base image of Debian Wheezy. With Marathon we can deploy a development, production or staging Storm cluster through Marathon REST Api or through Marathon Web UI. 

Deploying or scaling a new Storm cluster is very fast and easy (running a single script or just Marathon UI). Docker allows us to deploy any version of Apache Storm on Apache Mesos. Similar approach can be used to deploy any other distributed framework on Apache Mesos i.e Hadoop, Spark etc.

## Benefits
* Running Storm over Marathon provides fault tolerance for machine failures. 
* Docker containers provides resource isolation for Storm processes.
* Run Storm on High Availability mode i.e run multiple (3) instances of Storm Nimbus server, or Zookeeper.
* Deploying or Scaling cluster is very easy and quick.

## Prerequisites
* Install [Mesosphere Cluster] (http://mesosphere.com/docs/getting-started/datacenter/install/). This will install [Apache Mesos]( http://mesos.apache.org/) and [Marathon]( https://mesosphere.github.io/marathon/).
* Install [Docker] (https://docs.docker.com/installation/debian/) on each Debian cluster node.

## Cluster Setup

* For 

## Launch Storm Cluster 
