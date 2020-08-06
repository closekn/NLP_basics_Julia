# NLP basics Julia

## Environment

- OS
  - Debian GNU/Linux 10.5 (buster)
- Langage
  - Julia version 1.5.0

## Directory

- ExtractingKeywords
  - Count the frequency of non-stop words from the text and pick out important words.
- VectorSpaceModel
  - A vector space model is constructed for multiple documents and keyword search is performed.

## Create a working container

You can work in the directory '/home/workspace' in the container using the julia language.  

- Local shell

```sh
# Create a container image
$ docker build -t [image-name] .
# Create and Enter the container
$ docker run -it --name [container-name] [image-name] /bin/bash
# Enter the container
$ docker exec -it [container-name] /bin/bash
```

- Container Shell

```sh
# Go to the working directory
$ cd home/woekspace
```
