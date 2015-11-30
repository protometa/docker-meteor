FROM nodesource/trusty:0.10.40

# Install Meteor
RUN curl https://install.meteor.com/ | sh

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
EXPOSE 80
CMD ["/usr/local/bin/node", "main.js"]