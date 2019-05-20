containment-rpm-kata
===

### Overview
The goal of this repository is to allow OBS to generate a RPM package including a Kata Containers image.
This is a fork of [openSUSE/containment-rpm](https://github.com/openSUSE/containment-rpm).

To make this possible, the content of this repository is wrapped in a package.

This is what OBS does when building the main Kata Containers image package:
1. Install this package and osbuilder as prerequisites (achieved by specifying a `Preinstall: `
line with `osc meta -e prjconf`)
2. Use Kiwi to generate a rootfs from the package `.kiwi` file.
3. Run the code in this repository (installed at step 1.) using the `kiwi_post_run` hook. This will:
   - build a Kata Containers image (using osbuilder)
   - wrap the image into an RPM package

For more technical details refer to the original README.rst file.

### Usage

#### Prerequisites

You will need access to this / to a fork of this repository, and a containment-rpm package on OBS.

#### Howto
Deploy a new version of this package on OBS:
1. Commit and push changes to this upstream Git repository
2. Run:
```
./update-package -p OBS_PROJECT GIT_REVISION
```

`OBS_PROJECT`:  The name of the OBS project hosting the containment package.

`GIT_REVISION`: The Git tag / branch of this repository, used to
update the OBS project.
