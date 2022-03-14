# Container image that runs your code
FROM mikefarah/yq:4.18.1

#USER root
#RUN apk add --no-cache bash
#USER yq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY unity-pack.sh /unity-pack.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/unity-pack.sh"]
