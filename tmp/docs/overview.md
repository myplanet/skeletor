# skeletor Project

Overview of client & project
----------------------------

Add some content about client here.

Assets & Access
---------------

### Environment Information

#### Production

- http://newproject.devcloud.acquia-sites.com
- Deployed: tagged as per Acquia Network Control Panel "Overview" page
- BasicAuth login: NONE
- Drupal admin login: `admin` / `sekret`
- Git: https://github.com/myplanetdigital/drupal-skeletor
- SSH: `newproject@srv-123.devcloud.hosting.acquia.com`

#### Staging

- http://newprojecttest.devcloud.acquia-sites.com
- Deployed: tagged as per Acquia Network Control Panel "Overview" page
- BasicAuth login: `admin` / `sekret`
- Drupal admin login: `admin` / `sekret`

#### Development/Integration

- http://newprojectdev.devcloud.acquia-sites.com
- Deployed: `develop` branch
- BasicAuth login: `admin` / `sekret` 
- Drupal admin login: `admin` / `sekret`


### Other Credentials

#### Jenkins

- http://ci.newproject.example.com:8080
- Login: `<your-github-username>` / `sekret`
- SSH: `<your-github-username>@ci.newproject.example.com`
- Jenkins' public key:

ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQDHacBh12EdFUnTj1JTUUTBAHVp5kzmfBjSn77kdX8DO6mWFv27Vj1x6hlml1Sh6tJ+tmMt24tHzp20epi86+cwr4vRBwAXoZF9Yib+DJyfJcCwV03fScZ2upSGlvDgkipZEZZlqNIhXL9WweB0gsqUJ/zI23sTlRL7WtNQdFhKaT1tTgkNNdHZHdoK39oNNrmf+oG+zKPJY4cYAA6f0ngIed7vbduptkBSsiQSmBob8F6KHSoGED02aHEO2TTum+lNYdkO49tMWH61Dx9EukkZLG0P4U/MbelqNePgl2IEawOS79cTDuhOTo8aYel3zAC0j4ThdOV5waFrmPi1E7zr
jenkins@newproject-ci

#### Acquia Git repo

This is pushed to by Jenkins, and you should rarely need to push
directly if everything is going smoothly:

- `newproject@svn-3.devcloud.hosting.acquia.com:newproject.git`
