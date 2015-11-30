FROM codexsystems/meteor:latest

# Build meteor project
ONBUILD COPY . /srv/meteor/src
ONBUILD WORKDIR /srv/meteor/src
ONBUILD RUN meteor build .. --directory \
    && cd ../bundle/programs/server \
    && npm install \
    && rm -rf /srv/meteor/src
ONBUILD WORKDIR /srv/meteor/bundle

# Run application
ONBUILD USER nobody
ONBUILD ENV PORT 80
CMD ["/usr/local/bin/node", "main.js"]