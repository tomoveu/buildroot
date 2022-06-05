# EnactTrust fork of Buildroot

_This fork of Buildroot contains work that makes it easier to run EnactTrust on STM32MP157F-DK2 with ST33 TPM 2.0 support_

## How to use

1. Build and run the sdcard image
2. Run `enact onboard userID` to enroll your IoT device to EnactTrust
3. Just run `enact` to send a fresh evidece about the device health

You can receive your unique userID after registering at [EnactTrust](https://a3s.enacttrust.com "EnactTrust Security Cloud")

## How to build the sdcard image

The enact-stm32mp1-demo folder contains the following files for an out-of-the box experience:

* buildroot.config
* linux-5.13.config
* stm32mp157c-dk2.dts

The quickest path is to take the provided buildroot.config and build the default STM32MP1 image using the following commands:

```
cp enact-stm32mp1-demo/buildroot.config .config
make 2>&1 | tee build.log
```

Afterwards, apply the provided linux kernel config and device tree to enable ST33 TPM support like this:

```
cp enact-stm32mp1-demo/linux-5.13.config output/build/linux-5.13/.config
cp enact-stm32mp1-demo/stm32mp157c-dk2.dts output/build/linux-5.13/arch/arm/boot/dts/
```

Rebuild the linux kernel for TPM 2.0 support:

```
make linux-rebuild
```

Rebuild the buildroot image with the new kernel:

```
make 2>&1 | tee build.log
```

Flash a sdcard for booting STM32MP157F-DK2:

```
sudo umount /dev/sda?
sudo dd if=output/images/sdcard.img of=/dev/sda bs=4M conv=sync status=progress
sudo sync
sudo eject /dev/sda
```

Insert the sdcard into the STM32MP157F-DK2 board and power up using UBS-C on the CN7 connector.

Console is available using the built-in ST-LINK USB2Serial available on connector CN11.

Open the buildroot console:

```
sudo minicom -D /dev/ttyAMA0
```

## Troubleshooting

Most common errors and example solutions can be found below:

### Missing DNS configuration

```
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

### Missing internet connection

```
ifconfig eth0 up 192.168.0.250 netmask 255.255.255.0
route add default gw 192.168.0.1
```

### Inaccurate date and time

```
date 2022-06-05
date 12:00
```

### Forgot to refresh the dashboard

When at a3s.enacttrust.com, do not forget to refresh your browser window in order to see the latest device health status, evidence count, and other information.

### Modified demo folder

Red hearth with "Bad" status in the a3s.enacttrust.com dashboard means that the latest fresh evidence does not match the golden value we have created during enact onboarding. There are two ways to get back to a good state depending on what is your goal.

Option 1. Restore device health of the node

The default demo folder contains only one file named also 'demo'.

- If you have deleted or modified this file it has to be restored.
- If you have added other files, these files have to be deleted.
- Enact monitors the whole folder, anything inside at the time of onboarding is protected.

The default content of that file is:

this-secret-is-protected

No spaces.

```
echo this-secret-is-protected > /demo/demo
```

The command above should restore your demo folder to its original state. Then just run `enact` to send a fresh evidence.

Please note that the golden value includes any files in the demo folder at the time of execution of the `enact onboard userID` command.

Option 2. Re-enroll the node with a new golden value

Check the content of the /demo folder is the one you want to protect and then invoke `enact onboard userID`. This will associate the EK pub and AK pub with a new NodeID and in your dashboard you would see two nodes. Svet will enable node deletion, so you could remove the old node if you decide to go for this option.

### Let us know if you find other issues

See below on how to contact us.

## Questions and comments

Feel free to post your questions to [TPM.dev](https://tpm.dev "TPM.dev") or send us an [email](mailto:support@enacttrust.com "contact us over email") and we will respond.

We have tried to keep a basic demo flow and we are open to feedback on how to improve it.

## Original buildroot readme

Buildroot is a simple, efficient and easy-to-use tool to generate embedded
Linux systems through cross-compilation.

The documentation can be found in docs/manual. You can generate a text
document with 'make manual-text' and read output/docs/manual/manual.text.
Online documentation can be found at http://buildroot.org/docs.html

To build and use the buildroot stuff, do the following:

1) run 'make menuconfig'
2) select the target architecture and the packages you wish to compile
3) run 'make'
4) wait while it compiles
5) find the kernel, bootloader, root filesystem, etc. in output/images

You do not need to be root to build or run buildroot.  Have fun!

Buildroot comes with a basic configuration for a number of boards. Run
'make list-defconfigs' to view the list of provided configurations.

Please feed suggestions, bug reports, insults, and bribes back to the
buildroot mailing list: buildroot@buildroot.org
You can also find us on #buildroot on OFTC IRC.

If you would like to contribute patches, please read
https://buildroot.org/manual.html#submitting-patches
