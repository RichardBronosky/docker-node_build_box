#!/bin/bash -eux

username="richardbronosky"

readonly script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly image_name="$(basename $script_dir)"
[[ -n "${username:-}" ]] && tag="$username/$image_name" || tag="$image_name"
cd "$script_dir"

docker build -t $tag .
