# Understanding Docker images

**Docker images form the blueprint of Docker containers**.a Docker image **specifies what packages,source code, dependencies, and libraries it needs to use**. It also determines what it needs to do for the source code to run effectively.

Technically, it consists of a series of steps you would perform on a base OS image to get your application up and running. This may include installing packages and dependencies, copying the source code to the correct folder, building your code to generate a binary, and so on.

You can store Docker images in a container registry, a centralized location from where your Docker machines can pull images to create containers.

Docker images use a layered filesystem. Instead of a huge monolithic block on the filesystem that comprises the template to run containers, we have many layers, one on top of the other.

# The layered filesystem

When you build a Docker image using a **Dockerfile**, Docker doesn’t create one big image at once — instead, it builds it **step by step**, and each step becomes a **layer**.

You can think of it like a **stack of transparent sheets**: each Dockerfile instruction adds one more sheet (layer) on top of the previous ones. The final image is the combination of all those layers.