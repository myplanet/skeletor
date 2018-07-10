#!/bin/bash

# A script to scaffold the Skeletor profile and theme

# Move all files in project-scaffold to the project root

ln -sfn ./web/profiles/contrib/skeletor/project-scaffold/hooks ./hooks

rm ./.gitignore
\cp ./web/profiles/contrib/skeletor/project-scaffold/.gitignore ./.gitignore

rm ./.gitignore
\cp ./web/profiles/contrib/skeletor/project-scaffold/.gitignore ./.gitignore