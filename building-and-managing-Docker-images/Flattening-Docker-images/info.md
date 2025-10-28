# Flattening Docker images

Docker inherently uses a layered filesystem, and we have already discussed why it is necessary and how it is beneficial in depth. However, in some particular use cases, Docker practitioners have observed that a Docker image with fewer layers performs better. You can reduce layers in an image by flattening it. However, it is still not a best practice, and you need to do this only if you see a performance improvement, as this would result in a filesystem overhead.

**To flatten a Docker image, follow these steps:**

**1.Run a Docker container with the usual image.**

**2.Do a `docker export` of the running container to a `.tar` file.**

**3.Do a `docker import` of the `.tar` file into another image.**

Let’s use the **go-hello-world** image to flatten it and export it to another image; that is, **`<your_dockerhub_user>/go-hello-world:flat`**.