#!/bin/bash

# A script to scaffold the Skeletor profile and theme
echo Skeletor Initialization
echo Scaffolds and Symlinks assets for your project

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
# Create travis dir and symlink scripts.
if prompt "Symlink travis build assets and scripts?"; then
    # Create travis dir.
    if [ ! -d travis ]; then
        mkdir travis
    fi
    # Symlink scripts into travis dir.
    ln -s web/profiles/contrib/skeletor/project-scaffold/travis/* travis/
    if [ ! $? -ne 0 ]; then
        echo "Symlinked travis scripts into:"
        echo "$(pwd)/travis"
    fi
fi

# hooks
# Create hooks and symlink hooks.
if prompt "Symlink Acquia cloud hooks?"; then
    # Create hooks dir.
    if [ ! -d hooks ]; then
        mkdir hooks
    fi
    # Symlink scripts into hooks dir.
    ln -s web/profiles/contrib/skeletor/project-scaffold/hooks/* hooks/
    if [ ! $? -ne 0 ]; then
        echo "Symlinked Acquia cloud hooks into:"
        echo "$(pwd)/hooks"
    fi
fi
