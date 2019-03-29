#!/bin/bash -eux

# Put common options here
docker_run_options="--volume $PWD/.npm:/root/.npm -p 8000:8000 --memory 4096m"

# Use env var DOCKER_RUN_OPTIONS to overwrite ^^them^^ at invocation time
docker_run_options="${DOCKER_RUN_OPTIONS:-$docker_run_options}"

readonly script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly image_name="$(basename $script_dir)"

# Generic run command
docker run -it --rm --name rtg --workdir /usr/src/app --volume $PWD:/usr/src/app $docker_run_options $image_name bash
