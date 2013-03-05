Usage of Skeletor
-----------------

This project is intended to be used as a template for all install
profile based Drupal projects at Myplanet Digital. (Please be attentive
not to push an project-specific changes back into this repository. See
below.)

Use the command below to rename all relevant files and perform
search-and-replace within project files:

    git clone --recursive https://github.com/myplanetdigital/drupal-skeletor.git
    cd drupal-skeletor
    export PATH=$PATH:$PWD/tmp/scripts/rerun/core
    export RERUN_MODULES=$PWD/tmp/scripts/rerun/custom_modules
    rerun renamer:rename --to DESIRED_PROJECT_NAME_HERE

**Note:** This README file will be removed during the renaming process.

- To ensure that your project-specific changes are not pushed back into
the public repo, be sure to point the remote to your (private) project
repo:

        git remote set-url origin git@github.com:myplanetdigital/PROJECT_NAME_HERE.git

- Your first commit to the new project should probably use this command:

        git add --all
