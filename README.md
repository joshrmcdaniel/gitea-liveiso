# gitea runner live boot

build a debian live iso with act_runner and commonly used programs

designed to be an ephemeral runner; meant to run over pxe. i use WoL with baremetal to boot into the distro

**CI doesn't work, built locally**

## Usage

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
set boot_url your.host/path/to/files/
kernel ${boot_url}vmlinuz boot=live fetch=${boot_url}filesystem.squashfs username=act_runner initrd=initrd.magic ${cmdline}
initrd ${boot_url}initrd
boot
```

once booted mount nas and register runner manually

## TODO

- figure out persistence via nfs
- turn off machine after idle time.