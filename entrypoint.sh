#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        cd $INPUT_SUBDIR
    fi
}

check_if_meta_yaml_file_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

build_package(){
    conda build -c conda-forge -c bioconda --output-folder . .
    conda convert -p all linux-64/*.tar.bz2    
#     conda convert -p osx-64 linux-64/*.tar.bz2
#     conda convert -p win-64 linux-64/*.tar.bz2
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    anaconda upload --label main osx-64/*.tar.bz2
    anaconda upload --label main osx-arm64/*.tar.bz2
    anaconda upload --label main linux-32/*.tar.bz2
    anaconda upload --label main linux-64/*.tar.bz2
    anaconda upload --label main linux-ppc64/*.tar.bz2
    anaconda upload --label main linux-ppc64le/*.tar.bz2
    anaconda upload --label main linux-s390x/*.tar.bz2
    anaconda upload --label main linux-armv6l/*.tar.bz2
    anaconda upload --label main linux-armv7l/*.tar.bz2
    anaconda upload --label main linux-aarch64/*.tar.bz2
    anaconda upload --label main win-32/*.tar.bz2
    anaconda upload --label main win-64/*.tar.bz2
}

go_to_build_dir
check_if_meta_yaml_file_exists
build_package
upload_package
