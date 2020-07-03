# NLP basics Julia

## Creating the work environment

You can work in the directory '/home/workspace' in the container using the julia language.  
The way to create a container is as follows.  

- First time  

```zsh
> docker build -t [image-name] .
> docker run -it --name [container-name] [image-name] /bin/bash
```

- After the second time

```zsh
> docker exec -it [container-name] /bin/bash
```
