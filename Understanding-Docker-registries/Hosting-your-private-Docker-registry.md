# Hosting your private Docker registry

**Docker provides an image that you can run on any server that has Docker installed. Once the container is up and running, you can use that as the `Docker registry`**. Let’s have a look:
```shell
    docker run -d -p 80:5000 --restart=always --name registry registry:2
    Unable to find image 'registry:2' locally
    2: Pulling from library/registry
    44cf07d57ee4: Pull complete 
    bbbdd6c6894b: Pull complete 
    8e82f80af0de: Pull complete 
    3493bf46cdec: Pull complete 
    6d464ea18732: Pull complete 
    Digest: sha256:a3d8aaa63ed8681a604f1dea0aa03...
    Status: Downloaded newer image for registry:2
    bb1c1a0c934142ca23a6cd44585b2b9db728d2a4e2093d...
```

**Since the registry runs on localhost:80, we need to tag our image to specify that registry before pushing it. The tag format is `<registry_url>/<user>/<image_name>:<image_version>`, and we use the `docker tag` command to assign this new name to the existing image.**
