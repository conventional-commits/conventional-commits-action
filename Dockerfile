FROM node:8-alpine

LABEL version="0.0.1"
LABEL repository="http://github.com/bcoe/conventional-commits-action"
LABEL homepage="http://github.com/bcoe/conventional-commits-action"
LABEL maintainer="Ben Coe <bencoe@gmail.com>"

LABEL com.github.actions.name="GitHub Action for Conventional Commits"
LABEL com.github.actions.description="Automatically tag releases and generate a CHANGELOG, based on the Conventional Commits spec."
LABEL com.github.actions.icon="checklist"
LABEL com.github.actions.color="yellow"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    git \
    bash \
    go \
    libc-dev

RUN mkdir /tmp/hub
RUN ["/bin/bash", "-c", "set -o pipefail \
    && git clone https://github.com/github/hub.git /tmp/hub \
    && cd /tmp/hub \
    && git fetch --tags \
    && git checkout v2.2.9 \
    && ./script/build" ]

RUN mv /tmp/hub/bin/hub /usr/bin/hub
COPY LICENSE.txt /LICENSE.txt
COPY README.md /README.md
COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
