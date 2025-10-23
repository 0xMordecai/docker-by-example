# Building and managing Docker images

some best practices to write Dockerfiles and create Docker images:

Always add the layers that do not change frequently first, followed by the layers that may change often. For example, install your packages and dependencies first and copy the source code later. Docker builds the Dockerfile from the part you change until the end, so if you change a line that comes later, Docker takes all the existing layers from the cache. Adding more frequently changing parts later in the build helps reduce the build time and will result in a faster CI/CD experience.

• Combine multiple commands to create as few layers as possible. Avoid multiple consecutive RUN directives. Instead, combine them into a single RUN directive using the && clauses. This will help reduce the overall container footprint.

• Only add the required files within your container. Your container does not need the heavyweight package managers and the Go toolkit while running your containers if you have already compiled the code into a binary. We will discuss how to do this in detail in the following sections.