# need node for potential npm module building
# (even if you use `meteor npm`)
FROM node:8
MAINTAINER Luke Nimtz <lnimtz@gummicube.com>

# Install Meteor
ENV METEOR_VERSION 1.6
RUN cd /root && curl -fSL https://static-meteor.netdna-ssl.com/packages-bootstrap/${METEOR_VERSION}/meteor-bootstrap-os.linux.x86_64.tar.gz | \
  tar xz
ENV PATH $PATH:/root/.meteor

# Copy build tools
COPY ./scripts/tools/ /opt/meteor/tools/
COPY ./scripts/docker-entrypoint /usr/local/bin/

# Expose resources
VOLUME /app
EXPOSE 80

# Deploy and build the code
RUN /opt/meteor/tools/bootstrap
ONBUILD COPY ./ /usr/local/src/meteor/
ONBUILD RUN /opt/meteor/tools/bundle
ONBUILD RUN /opt/meteor/tools/finish

# Run application
ENTRYPOINT ["docker-entrypoint"]
CMD []
