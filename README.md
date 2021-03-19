# Ready-to-run docker container with Eclipse Theia IDE

The image can be found on [Docker Hub](https://hub.docker.com/r/philipdeussen/theia-wf-test).

It is necessary to have [Docker](https://www.docker.com/products/docker-desktop) installed to be able to use one of the following commands to start a container. 
This will start a new container and mounts your current directory in the container to be used with Theia.
Theia can be accessed via _localhost:3000_.


Linux:
```
docker run --init --rm -it -v $("pwd"):/home/node/project -p 3000:3000 philipdeussen/theia-wf-test
```

Windows (cmd):
```
docker run --init --rm -it -v %cd%:/home/node/project -p 3000:3000 philipdeussen/theia-wf-test
```

