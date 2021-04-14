# Distributed Database Systems TP

In this repository, we will try to solve the assignments of an ENSIAS module that tackles distributed databases. The lab will be created using Docker and we will have three oracle databases running on the same host. We will use the express version because this is just for educational purposes and we don't require maximal entreprise performance.

I made a video explaining my thought process making this project [here](https://youtu.be/kx9Q3PFNnlo).

## Setting up the environment

### 1. Install [Docker](https://docs.docker.com/engine/install/) on your machine.

### 2. Clone this repository and then navigate into it

    git clone https://github.com/Ignema/BDD-R.git
    cd BDD-R

### 3. Pull the Oracle XE image from Docker Hub

    docker pull oracleinanutshell/oracle-xe-11g

### 4. Create the cluster

    docker-compose up

### 5. Complete the TP1 with a script

#### windows

    > cd main/TP1
    > windows.bat

#### linux

    # source main/TP1/linux.sh

And you're done.