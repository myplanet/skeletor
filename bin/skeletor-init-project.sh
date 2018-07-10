#!/bin/bash

# A script to scaffold the Skeletor profile and theme

# Symlink to hooks

ln -sfn ./web/profiles/contrib/skeletor/project-scaffold/hooks ./hooks

# Copy .travis.yml to root

rm ./.travis.yml
\cp ./web/profiles/contrib/skeletor/project-scaffold/.gitignore ./.travis.yml

# Copy .gitignore to root

rm ./.gitignore
\cp ./web/profiles/contrib/skeletor/project-scaffold/.gitignore ./.gitignore

