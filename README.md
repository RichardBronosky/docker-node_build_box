# docker-node_build_box
This container is designed for running `npm install` in preparation for running in node:11, node:latest, node:stretch-slim, etc.

The build of this container can be found at https://hub.docker.com/r/richardbronosky/node_build_box

To fetch this container:

    docker pull richardbronosky/node_build_box

To use this container:

    # Build your node app
    cd node_app
    docker run --rm --workdir /usr/src/app --volume $PWD:/usr/src/app richardbronosky/node_build_box npm install

    # Run your node app
    docker run --rm --workdir /usr/src/app --volume $PWD:/usr/src/app node:11 npm start
