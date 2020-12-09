#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        ls
    fi
}

build_package(){
    conda build -c conda-forge -c bioconda --output-folder . .
    conda convert -p osx-64 linux-64/*.tar.bz2
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    anaconda upload --label main linux-64/*.tar.bz2
    anaconda upload --label main osx-64/*.tar.bz2
}

go_to_build_dir
build_package
upload_package
