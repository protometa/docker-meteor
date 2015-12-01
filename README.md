Docker Runtime for Meteor Apps
==============================

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

In case if you already have a Meteor bundle created for you app (for example in some CI service),
you can use it instead of building a new bundle from the source code.

Currently, two options of doing that are supported:

##### Directory bundle

Use the following `Dockerfile`

```
FROM codexsystems/meteor

COPY ./your_bundle_dir/* ./app
```

##### Archived bundle

Use the following `Dockerfile`

```
FROM codexsystems/meteor

COPY ./bundle.tar.gz ./app
```


Configuration
-------------

This image supports the [same environment variables](http://www.meteorpedia.com/read/Environment_Variables), as Meteor does.

However, there are also few additional environment variables supported that are used for better image usability:

- `METEOR_BUNDLE_FILE` - The name of the archived bundle file (see "[Archived bundle](#archived-bundle)" section).
Default value: *bundle.tar.gz*.
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