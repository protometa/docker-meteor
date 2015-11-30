FROM nodesource/trusty:0.10.40

# Install Meteor
RUN curl https://install.meteor.com/ | sh

# Expose resources
VOLUME /app
WORKDIR /app
EXPOSE 80

# Run application
CMD ["meteor", "--port", "80"]