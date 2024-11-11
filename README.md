# gitea runner live boot

build a debian live iso with act_runner and commonly used programs

designed to be an ephemeral runner; meant to run over pxe. i use WoL with baremetal to boot into the distro

**CI doesn't work, blame github. built locally**

## Usage


**prior to running**, ensure your config is stored remoted. modify [these 2 lines](./hooks/normal/9995-add-act-gitea.chroot#L31-L32) to the proper path

the config should store the runner yaml, and the auth json for runner auth.

>if your config is not remote, ¯\_(ツ)_/¯

``` shell
apt install live-build

sudo ./build.sh

# wherever the files are
7z x live-image-amd64.hybrid.iso live/filesystem.squashfs live/initrd.img live/vmlinuz

```

`live/filesystem.squashfs`, `live/initrd.img `, `live/vmlinuz` needed for pxe

``` s
# in pxe
imgfree
set boot_url http://your.host/path/to/files/
kernel ${boot_url}vmlinuz boot=live fetch=${boot_url}filesystem.squashfs username=act_runner initrd=initrd.magic ${cmdline}
initrd ${boot_url}initrd
boot
```

once booted, the act runner will be on succesfully

## TODO

- turn off machine after idle time.