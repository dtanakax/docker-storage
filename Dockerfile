# Set the base image
FROM progrium/busybox

# File Author / Maintainer
MAINTAINER tanaka@infocorpus.com

# Install packages
RUN opkg-install bash

# Define mountable directories.
VOLUME ["/var/log"]

CMD ["/bin/bash"]
