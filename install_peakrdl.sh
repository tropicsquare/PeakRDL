#!/bin/bash
###################################################################################################
# A quick and dirty PeakRDL install script via poetry
#
# Based on "ts-python-env" packaging by Henri lHote
#
# Ondrej Ille
###################################################################################################

# Tropic Packaging locates separately to avoid conflicts upon rebase to mainstream!
cd tropic

export PYTHON_VERSION="python3.8"

# Destination where to create virtual environment
export POETRY_CACHE_DIR=/tmp/PeakRDL
rm -rf $POETRY_CACHE_DIR
mkdir $POETRY_CACHE_DIR

# Poetry is installed in the user local directory
export PATH="$HOME/.local/bin:$PATH"

# Environment name
export ENV_NAME=$(basename "$(dirname "$(readlink -f "$0")")")

# Deploy path
export TROPIC_DEPLOY=/tools/opensource/peakrdl

# Install poetry if need be.
if [ "$(which poetry &>/dev/null; echo $?)" -ne 0 ]; then
    echo "Poetry not found. Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3.8 -
    if [ $? -ne 0 ]; then
        >&2 echo "ERROR: poetry could not be installed! Aborting..."
        exit 1
    fi
    echo "Poetry installed."
else
    echo "Poetry already installed."
fi


# Create virtual environment
poetry env use $PYTHON_VERSION

# Install dependencies
poetry install --no-interaction

# Print info about installed env
env_path=$(poetry env info --path)

cat << EOL
$ENV_NAME installed under '$env_path'.
To activate:
source $env_path/bin/activate
EOL

# Deploy to Tropic network
export GIT_VER=`poetry --no-ansi version | sed 's/peakrdl //g'`
export
mkdir -p $TROPIC_DEPLOY/peakrdl_$GIT_VER
cp -r $env_path/* $TROPIC_DEPLOY/peakrdl_$GIT_VER

cd ..

# Uninstall poetry
#curl -sSL https://install.python-poetry.org | python3 - --uninstall
