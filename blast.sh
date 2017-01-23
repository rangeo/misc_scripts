#!/bin/sh

mkdir /mnt/sd
mkdir /mnt/emmc
mkdir /mnt/sata
mkdir /tmp/logs

ln -s /sbin/fw_printenv /sbin/fw_setenv

### MicroSD ###
if [ -e /mnt/usb/sdimage.tar.bz2 ]; then
	echo "======= Writing SD card filesystem ========"

	(
# Don't touch the newlines or add tabs/spaces from here to EOF
fdisk /dev/mmcblk1 <<EOF
o
n
p
1


w
EOF
# </fdisk commands>
		if [ $? != 0 ]; then
			echo "fdisk mmcblk1" >> /tmp/failed
		fi

		mke2fs -t ext4 /dev/mmcblk1p1 -q < /dev/null
		if [ $? != 0 ]; then
			echo "mke2fs mmcblk1" >> /tmp/failed
		fi
		mount /dev/mmcblk1p1 /mnt/sd/
		if [ $? != 0 ]; then
			echo "mount mmcblk1" >> /tmp/failed
		fi
		tar xjf /mnt/usb/sdimage.tar.bz2 -C /mnt/sd/
		if [ $? != 0 ]; then
			echo "tar mmcblk1" >> /tmp/failed
		fi
		sync

		if [ -e "/mnt/sd/md5sums.txt" ]; then
			# Drop caches so we have to reread all files
			echo 3 > /proc/sys/vm/drop_caches
			cd /mnt/sd/
			md5sum -c md5sums.txt > /tmp/sd_md5sums
			if [ $? != 0 ]; then
				echo "==========SD VERIFY FAILED==========="
				echo "mmcblk1 filesystem verify" >> /tmp/failed
			fi
			cd /
		fi

		umount /mnt/sd/
	) > /tmp/logs/sd-writefs 2>&1 &
elif [ -e /mnt/usb/sdimage.dd.bz2 ]; then
	echo "======= Writing SD card disk image ========"
	(
		bzcat /mnt/usb/sdimage.dd.bz2 | dd bs=4M of=/dev/mmcblk1
		if [ -e /mnt/usb/sdimage.dd.md5 ]; then
			BYTES="$(bzcat /mnt/usb/sdimage.dd.bz2  | wc -c)"
			EXPECTED="$(cat /mnt/usb/sdimage.dd.md5 | cut -f 1 -d ' ')"
			ACTUAL=$(dd if=/dev/mmcblk1 bs=4M | dd bs=1 count=$BYTES | md5sum)
			if [ "$ACTUAL" != "$EXPECTED" ]; then
				echo "mmcblk1 dd verify" >> /tmp/failed
			fi
		fi
	) > /tmp/logs/sd-writeimage 2>&1 &
fi

### EMMC ###
if [ -e /mnt/usb/emmcimage.tar.bz2 ]; then
	echo "\n***********************************************************************"
	echo "\n                       UPDATING OS ON eMMC                      "
	echo "\n***********************************************************************"	
	echo "\n"
	echo "please wait ................................."
	echo 255 > /sys/class/leds/en-led8/brightness
	echo 255 > /sys/class/leds/en-led7/brightness
	echo 255 > /sys/class/leds/en-led6/brightness
	echo 255 > /sys/class/leds/en-led5/brightness
	(

# Don't touch the newlines or add tabs from here to EOF
fdisk /dev/mmcblk2 <<EOF
o
n
p
1


w
EOF
# </fdisk commands>
		if [ $? != 0 ]; then
			echo "fdisk mmcblk2" >> /tmp/failed
		fi

		mke2fs -t ext4 /dev/mmcblk2p1 -q < /dev/null
		if [ $? != 0 ]; then
			echo "mke2fs mmcblk2" >> /tmp/failed
		fi
		mount /dev/mmcblk2p1 /mnt/emmc/
		if [ $? != 0 ]; then
			echo "mount mmcblk2" >> /tmp/failed
		fi
		tar xjf /mnt/usb/emmcimage.tar.bz2 -C /mnt/emmc/
		if [ $? != 0 ]; then
			echo "tar mmcblk2" >> /tmp/failed
		fi
		sync

		if [ -e "/mnt/emmc/md5sums.txt" ]; then
			# Drop caches so we have to reread all files
			echo 3 > /proc/sys/vm/drop_caches
			cd /mnt/emmc/
			md5sum -c md5sums.txt > /tmp/emmc_md5sums
			if [ $? != 0 ]; then
				echo "mmcblk2 filesystem verify" >> /tmp/failed
			fi
			cd /
		fi

		umount /mnt/emmc/
	) > /tmp/logs/emmc-writefs 2>&1 &
elif [ -e /mnt/usb/emmcimage.dd.bz2 ]; then
	echo "======= Writing eMMC disk image ========"
	(
		bzcat /mnt/usb/emmcimage.dd.bz2 | dd bs=4M of=/dev/mmcblk2
		if [ -e /mnt/usb/emmcimage.dd.md5 ]; then
			BYTES="$(bzcat /mnt/usb/emmcimage.dd.bz2  | wc -c)"
			EXPECTED="$(cat /mnt/usb/emmcimage.dd.md5 | cut -f 1 -d ' ')"
			ACTUAL=$(dd if=/dev/mmcblk2 bs=4M | dd bs=1 count=$BYTES | md5sum)
			if [ "$ACTUAL" != "$EXPECTED" ]; then
				echo "mmcblk2 dd verify" >> /tmp/failed
			fi
		fi
	) > /tmp/logs/emmc-writeimage 2>&1 &
fi


### SATA ###
if [ -e /mnt/usb/sataimage.tar.bz2 ]; then
	echo "======= Writing SATA drive filesystem ========"
	(

# Don't touch the newlines or add tabs from here to EOF
fdisk /dev/sda <<EOF
o
n
p
1


w
EOF
# </fdisk commands>
		if [ $? != 0 ]; then
			echo "fdisk sda1" >> /tmp/failed
		fi

		mke2fs -t ext4 /dev/sda1 -q < /dev/null
		if [ $? != 0 ]; then
			echo "mke2fs sda1" >> /tmp/failed
		fi
		mount /dev/sda1 /mnt/sata/
		if [ $? != 0 ]; then
			echo "mount sda1" >> /tmp/failed
		fi
		tar xjf /mnt/usb/sataimage.tar.bz2 -C /mnt/sata/
		if [ $? != 0 ]; then
			echo "tar sda1" >> /tmp/failed
		fi
		sync

		if [ -e "/mnt/sata/md5sums.txt" ]; then
			# Drop caches so we have to reread all files
			echo 3 > /proc/sys/vm/drop_caches
			cd /mnt/sata/
			md5sum -c md5sums.txt > /tmp/sata_md5sums
			if [ $? != 0 ]; then
				echo "sda1 filesystem verify" >> /tmp/failed
			fi
			cd /
		fi

		umount /mnt/sata/
	) > /tmp/logs/sata-writefs 2>&1 &
elif [ -e /mnt/usb/sataimage.dd.bz2 ]; then
	echo "======= Writing SATA drive disk image ========"
	(
		bzcat /mnt/usb/sataimage.dd.bz2 | dd bs=4M of=/dev/sda
		if [ -e /mnt/usb/sataimage.dd.md5 ]; then
			BYTES="$(bzcat /mnt/usb/sataimage.dd.bz2  | wc -c)"
			EXPECTED="$(cat /mnt/usb/sataimage.dd.md5 | cut -f 1 -d ' ')"
			ACTUAL=$(dd if=/dev/sda bs=4M | dd bs=1 count=$BYTES | md5sum)
			if [ "$ACTUAL" != "$EXPECTED" ]; then
				echo "sda1 dd verify" >> /tmp/failed
			fi
		fi
	) > /tmp/logs/sata-writeimage 2>&1 &
fi

### SPI (U-boot) ###
if [ -e /mnt/usb/u-boot.imx ]; then
	(
		dd if=/mnt/usb/u-boot.imx of=/dev/mtdblock0 bs=1024 seek=1
		if [ -e /mnt/usb/u-boot.imx.md5 ]; then
			sync
			# Flush any buffer cache
			echo 3 > /proc/sys/vm/drop_caches

			BYTES="$(ls -l /mnt/usb/u-boot.imx | sed -e 's/[^ ]* *[^ ]* *[^ ]* *[^ ]* *//' -e 's/ .*//')"
			EXPECTED="$(cat /mnt/usb/u-boot.imx.md5 | cut -f 1 -d ' ')"

			# Read back from spi flash
			dd if=/dev/mtdblock0 of=/tmp/uboot-verify.dd bs=1024 skip=1 count=$(($BYTES/1024))
			# truncate extra from last block
			dd if=/tmp/uboot-verify.dd of=/tmp/uboot-verify.imx bs=1 count="$BYTES"
			UBOOT_FLASH="$(md5sum /tmp/uboot-verify.imx | cut -f 1 -d ' ')"

			if [ "$UBOOT_FLASH" != "$EXPECTED" ]; then
				echo "u-boot verify failed" >> /tmp/failed
			fi
		fi
	) > /tmp/logs/spi-bootimg &
fi

if [ -e /mnt/usb/env.txt ]; then
	(
	# Wipe original ENV, use env.txt
	dd if=/dev/zero bs=1024 of=/dev/mtdblock1 count=1
	fw_setenv -s /mnt/usb/env.txt
	) > /tmp/logs/spi-ubootenv 2>&1 &
fi
sync

wait

(
# Blink green led if it works.  Blink red if bad things happened
if [ ! -e /tmp/failed ]; then
	echo 0 > /sys/class/leds/red-led/brightness
	
	echo "\n***********************************************************************"
	echo "\n                       SATA FORMAT AND PARTITION                       "
	echo "\n***********************************************************************"	
	echo "\n"


	# Delete all partions
	dd if=/dev/zero of=/dev/sda  bs=512  count=1
	fdisk -l /dev/sda

	# Create partitions 
	fdisk /dev/sda <<EOF
	n
	p
	1
	2048
	41688863
	n
	p
	2
	41688864
	52111078
	n
	p
	3
	52111079
	62533295
	w
	
	EOF
	
	# Format partitions
	mkfs.ext4 /dev/sda1 <<EOF
	y
	EOF
	mkfs.ext4 /dev/sda2 <<EOF
	y
	EOF
	mkfs.ext4 /dev/sda3 <<EOF
	y
	EOF
	
        mkdir /db
        mount /dev/sda1 /db
	tar xjf /mnt/usb/couchDB.tar.bz2 -C /db/
	sync
	umount /db
        
	
		echo "All images wrote correctly!"
		echo "DataBase deployed sucessfully"
		
		while true; do
			sleep 1
			echo 255 > /sys/class/leds/en-led8/brightness
			echo 255 > /sys/class/leds/en-led7/brightness
			echo 255 > /sys/class/leds/en-led6/brightness
			echo 255 > /sys/class/leds/en-led5/brightness
			sleep 1
			echo 0	> /sys/class/leds/en-led8/brightness
			echo 0	> /sys/class/leds/en-led7/brightness
			echo 0	> /sys/class/leds/en-led6/brightness
			echo 0	> /sys/class/leds/en-led5/brightness
		done
	else
		
		echo "One or more images failed! $(cat /tmp/failed)"
		echo "Check /tmp/logs for more information."
		while true; do
			sleep 1
			echo 255 > /sys/class/leds/en-led1/brightness
			echo 255 > /sys/class/leds/en-led2/brightness
			echo 255 > /sys/class/leds/en-led3/brightness
			echo 255 > /sys/class/leds/en-led4/brightness
			sleep 1
			echo 0	> /sys/class/leds/en-led1/brightness
			echo 0	> /sys/class/leds/en-led2/brightness
			echo 0	> /sys/class/leds/en-led3/brightness
			echo 0	> /sys/class/leds/en-led4/brightness
		done
	fi
	) &		
