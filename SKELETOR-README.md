Usage of Skeletor
-----------------

This project is intended to be used as a template for all install
profile based Drupal projects at Myplanet Digital.

Use the commands below to rename all relevant files and perform
search-and-replace within project files. It will also update the git
remote URL, and make the first project-specific commit.

    git clone --recursive https://github.com/myplanetdigital/drupal-skeletor.git
    cd drupal-skeletor
    export PATH=$PATH:$PWD/tmp/scripts/rerun/core
    export RERUN_MODULES=$PWD/tmp/scripts/rerun/custom_modules
    rerun renamer:rename --to DESIRED_PROJECT_NAME_HERE

This will edit `build-DESIRED_PROJECT_NAME_HERE.make` to point to a
GitHub repo at
`git@github.com:myplanetdigital/DESIRED_PROJECT_NAME_HERE.git` by
default. You may point it to another repo url like by instead using this
command:

    rerun renamer:rename --to DESIRED_PROJECT_NAME_HERE --repo myusername/custom-repo-name
    
The above command will NOT create the repo on GitHub; this must be done manually before pushing.

The command WILL automatically commit the renaming changes locally, but you will need
to set the git remote url before pushing those changes:

    git remote set-url origin git@github.com:myusername/custom-repo-name.git

**Note:** This README file will be removed during the renaming process.
