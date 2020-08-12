# NLP basics Julia

## Environment

- OS
  - Debian GNU/Linux 10.5 (buster)
- Langage
  - Julia version 1.5.0

## Directory

- AhoCorasickMethod
  - Implementation of Aho-Corasick based on the original paper and its implementation.
- ExtractingKeywords
  - Count the frequency of non-stop words from the text and pick out important words.
- VectorSpaceModel
  - A vector space model is constructed for multiple documents and keyword search is performed.

## Creating the Environment

- container image in Docker hub
  - [closekn/nlp_basics_julia](https://hub.docker.com/repository/docker/closekn/nlp_basics_julia)

Create a container with the environment of this repository by using Docker.  
You can work in the directory '/home/workspace' in the container using the julia language.  

- Local shell

```sh
# Create a container image
$ docker pull closekn/nlp_basics_julia
# Create and Enter the container
$ docker run -it --rm closekn/nlp_basics_julia /bin/bash
```

- Container Shell

```sh
# Go to the working directory
$ cd home/woekspace
```
