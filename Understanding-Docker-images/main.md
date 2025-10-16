# Understanding Docker images

**Docker images form the blueprint of Docker containers**.a Docker image **specifies what packages,source code, dependencies, and libraries it needs to use**. It also determines what it needs to do for the source code to run effectively.

Technically, it consists of a series of steps you would perform on a base OS image to get your application up and running. This may include installing packages and dependencies, copying the source code to the correct folder, building your code to generate a binary, and so on.

You can store Docker images in a container registry, a centralized location from where your Docker machines can pull images to create containers.

Docker images use a layered filesystem. Instead of a huge monolithic block on the filesystem that comprises the template to run containers, we have many layers, one on top of the other.

# The layered filesystem

When you build a Docker image using a **Dockerfile**, Docker doesn’t create one big image at once — instead, it builds it **step by step**, and each step becomes a **layer**. The current layer contains just the differences between the previous and current filesystem. A container image comprises several layers.

Containers contain an additional writable filesystem on top of the image layers. This is the layer where your containers modify the filesystem to provide the expected functionality.

There are several advantages of using layers instead of merely copying the entire filesystem of the container. `Since image layers are read-only, multiple containers created from an image share the same layered filesystem, decreasing the overall disk and network footprint`. **Layers also allow you to share filesystems between images**. For example, if two images come from a single base image, both images share the same base layer.