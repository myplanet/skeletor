#!/bin/bash

# A script to scaffold the Skeletor profile and theme
echo Skeletor Initialization
echo Scaffolds assets for your project

function prompt {
    local promptReturn=1
    local label="$1 [y/n]: "
    local yn
    while true; do
        read -p "$label" yn
        case $yn in
            [y]* ) promptReturn=0; break;;
            [n]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done

    return $promptReturn
}

# COPY prod.gitignore
# Only prompt if it doesn't exist.
if prompt "Create a prod.gitignore?"; then
    # Check if prod.gitignore is already present.
    if [ ! -f prod.gitignore ]; then
        # copy file and report if successful.
        cp web/profiles/contrib/skeletor/project-scaffold/prod.gitignore .
        if [ ! $? -ne 0 ]; then
            echo "Created prod.gitignore at:"
            echo "$(pwd)/prod.gitignore"
        fi
    else
        echo "ERROR: prod.gitignore already exists"
    fi
fi

# COPY/OVERWRITE .travis.yml
# Mention it's a destructive task.
if prompt "Replace .travis.yml with skeletor default?"; then
    if [ -f .travis.yml ]; then
        rm .travis.yml
    fi
    cp web/profiles/contrib/skeletor/project-scaffold/.travis.yml .
    if [ ! $? -ne 0 ]; then
        echo "Created .travis.yml at:"
        echo "$(pwd)/.travis.yml"
    fi
fi

# travis
# Create travis dir and copy scripts.
if prompt "Create travis build assets and scripts?"; then
    # Create travis dir.
    if [ ! -d travis ]; then
        mkdir travis
    fi
    # Copy scripts into travis dir.
    cd travis
    cp ../web/profiles/contrib/skeletor/project-scaffold/travis/* .
    cd ..
    if [ ! $? -ne 0 ]; then
        echo "Created travis scripts in:"
        echo "$(pwd)/travis"
    fi
fi

# hooks
# Create hooks dir and copy hooks.
if prompt "Create Acquia cloud hooks?"; then
    # Create hooks dir.
    if [ ! -d hooks ]; then
        mkdir hooks
    fi
    # Copy scripts into hooks dir.
    cd hooks
    cp ../web/profiles/contrib/skeletor/project-scaffold/hooks/* .
    cd ..
    if [ ! $? -ne 0 ]; then
        echo "Created Acquia cloud hooks in:"
        echo "$(pwd)/hooks"
    fi
fi
