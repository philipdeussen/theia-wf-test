# Ready-to-run docker container with Eclipse Theia IDE

Starting the container can be done with the following command:
```
docker run --init --rm -it -v $("pwd"):/home/node/project -p 3000:3000 philipdeussen/theia-wf-test
```