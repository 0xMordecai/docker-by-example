# Understanding Docker registries

A **`Docker registry` is a stateless, highly scalable server-side application that stores and lets you distribute `Docker images`**. The registry is open source under the permissive Apache license. **It is a storage and distribution system where all your Docker servers can connect and upload and download images when needed**. It acts as a distribution site for your images.

**A Docker registry contains several Docker repositories. A Docker repository holds several versions of a specific image. For example, all the versions of the `nginx` image are stored within a single repository within Docker Hub called `nginx`.**

**By default, Docker interacts with its public Docker registry instance, called `Docker Hub`, which helps you distribute your images to the broader open source community.**

**Docker allows you to use a private Docker registry for a scenario you can host within your infrastructure called `Docker Trusted Registry`.** Several online options are available, including using a SaaS service, such as ***`GCR`***, or **`creating private repositories at Docker Hub`**.
