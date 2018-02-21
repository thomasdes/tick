#!/bin/sh

set -e -x

# Copy tick source from host to container
cp -R /io src
cd src

apt-get update;
apt-get install -y libgeos*;

eval "$(pyenv init -)"

pyenv global ${PYVER}
pyenv local ${PYVER}

python -m pip install  https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz
python setup.py cpplint build_ext --inplace cpptest pytest

export PYTHONPATH=${PYTHONPATH}:`pwd` && (cd doc && make doctest)
