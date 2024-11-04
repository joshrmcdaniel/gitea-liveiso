# gitea runner live boot

build a debian live iso with act_runner and commonly used programs

designed to be an ephemeral runner; meant to run over pxe. i use WoL with baremetal to boot into the distro

**CI doesn't work, built locally**

## Usage

``` shell
apt install live-build

sudo ./build.sh
```

once booted mount nas and register runner manually

## TODO

- figure out persistence via nfs
- turn off machine after idle time.