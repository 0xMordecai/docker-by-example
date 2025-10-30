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

```shell
    docker tag <username>/go-hello-world:multi_stage localhost/<username>/go-hello-world:multi_stage
```

**Now, we can go ahead and push the image to the local Docker registry:**

```shell
    docker push localhost/<username>/go-hello-world:multi_stage
    The push refers to repository [localhost/<username>/go-hello-world]
    d10e0340acf3: Pushed 
    0c517899a3b6: Pushed 
    bb01bd7e32b5: Pushed 
    multi_stage: digest: sha256:85a41870c5775f5868529231f0e0c8aac40a4cae... size: 945
```
And that’s it! It is as simple as that!

**There are other considerations as well since this is too simplistic. You will also have to `mount volumes`; otherwise, you will lose all the images when you restart the registry container. Also, there is no authentication in place, so anyone accessing this server can push or pull images, but we don’t desire this. Also, communication is insecure, and we want to encrypt the images during transit.**

First, let’s create the local directories that we will mount to the containers:
```shell
     sudo mkdir -p /mnt/registry/certs
     sudo mkdir -p /mnt/registry/auth
     sudo chmod -R 777 /mnt/registry
```

**Now, let’s generate an `htpasswd` file for adding authentication to the registry. For this, we will run the `htpasswd` command within a new Docker registry container to create a file on our local directory**
```shell
    docker run --entrypoint htpasswd registry:2.7.0 -Bbn user pass > /mnt/registry/auth/htpasswd
```
**This command runs a temporary container to generate an `htpasswd` authentication file for your private Docker registry, creating a `bcrypt-encrypted` `username/password` entry and saving it to `/mnt/registry/auth/htpasswd`**

**The next step is to generate some self-signed certificates for enabling `TLS(Transport Layer Security)` on the repository. Add your server name or IP when asked for a `Fully Qualified Domain Name (FQDN)`. You can leave the other fields blank or add appropriate values for them.**

```shell
    openssl req -newkey rsa:4096 -nodes -sha256 -keyout /mnt/registry/certs/domain.key -x509 -days 365 -out /mnt/registry/certs/domain.crt
```