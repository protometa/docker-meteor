Docker Runtime for Meteor Apps
==============================

[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/codexsystems/meteor/latest.svg)](https://imagelayers.io/?images=codexsystems%2Fmeteor:latest)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/codexsystems/meteor/latest.svg)](https://imagelayers.io/?images=codexsystems%2Fmeteor:latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/codexsystems/meteor.svg)](https://hub.docker.com/r/codexsystems/meteor/)
[![Docker Stars](https://img.shields.io/docker/stars/codexsystems/meteor.svg)](https://img.shields.io/docker/pulls/codexsystems/meteor.svg)

Meteor Dockerized for Development and Production.


What is Meteor?
---------------

Meteor is an ultra-simple environment for building modern web applications.

With Meteor you write apps:

- in pure JavaScript;
- that send data over the wire, rather than HTML;
- using your choice of popular open-source libraries.

Documentation is available at [http://docs.meteor.com/](http://docs.meteor.com/).


What is this image?
-------------------

When working with Meteor and Docker, there are two most common tasks that you will face:

1. Local Meteor development with [docker-compose](https://docs.docker.com/compose/);
2. Building a production Docker image for your app.

This image is an attempt to solve both problems.


How to use this image?
----------------------

### Local development

When working with this image locally, all you need to do is to mount a folder with you source code to `/app` volume of the container.

Here is the `docker-compose` example:

```
meteor-app:
  image: codexsystems/meteor
  restart: unless-stopped
  links:
    - mongo
  volumes:
    - ./:/app
  ports:
    - 80:80
  environment:
    MONGO_URL: mongodb://mongo
    ROOT_URL: http://localhost
```

By doing this you will have you Meteor app listening on `http://localhost:80` and hot code pushes working.

### Building an image for your app

That's simple. Really. Just add the following `Dockerfile` into the root of your app:

```
FROM codexsystems/meteor
```

Then you can build the docker image with:

```
docker build -t yourname/app .
```

Then run it:

```
docker run -d \
    --link mongo \
    -e ROOT_URL=http://localhost \
    -e MONGO_URL=mongodb://mongo \
    -p 80:80 \
    yourname/app
```

And access it via `http://localhost:80`.

#### Running existing Meteor bundle

In case if you already have a Meteor bundle created for you app (for example with some CI service),
you can use it instead of building a new bundle from the source code.

All you need to do in such case is to have your `bundle` directory or your `bundle.tar.gz` file in the project
document root during Docker image build process.


Configuration
-------------

This image supports the [same environment variables](http://www.meteorpedia.com/read/Environment_Variables), as Meteor does.

However, there are also few additional environment variables supported that are used for better image usability:

- `METEOR_SETTINGS_FILE` - In the [Local development](#local-development) mode, this image will try to locate your `settings.json` file and attach it to the Meteor.
You can use this environment variable if your settings file is named somehow else.
Default value: *settings.json*.


Report
------

- Report any issues [on the GitHub](https://github.com/codexsystems/docker-meteor/issues).


License
-------

This image is released under the MIT License. See the bundled [LICENSE.md](https://raw.githubusercontent.com/codexsystems/docker-meteor/master/LICENSE.md) for details.


Resources
---------

- [DockerHub Page](https://hub.docker.com/r/codexsystems/meteor/)
- [Source Code](https://github.com/codexsystems/docker-meteor)