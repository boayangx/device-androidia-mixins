#TARGET_NO_RECOVERY ?= false

TARGET_BOARD_PLATFORM := android_ia

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512

ifeq ($(SPARSE_IMG),true)
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
else
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
endif

BOARD_SYSTEMIMAGE_PARTITION_SIZE = 3758096384

BOARD_BOOTLOADER_PARTITION_SIZE ?= 62914560
BOARD_BOOTLOADER_BLOCK_SIZE := 512
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

# Kernel Flinger
TARGET_UEFI_ARCH := x86_64
# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true
# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true
# Tell Kernelflinger to ignore ACPI RSCI table
KERNELFLINGER_IGNORE_RSCI := true
KERNELFLINGER_SSL_LIBRARY := boringssl
# Specify system verity partition
#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/system

# Avoid Watchdog truggered reboot
BOARD_KERNEL_CMDLINE += iTCO_wdt.force_no_reboot=1

# Specify file for creating final flashfiles
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(PRODUCT_OUT)/system.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(PRODUCT_OUT)/boot.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/kernelflinger.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/startup.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.cmd
BOARD_FLASHFILES += $(PRODUCT_OUT)/bootloader
BOARD_FLASHFILES += $(PRODUCT_OUT)/fastboot-usb.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/recovery.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/cache.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/config.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/vendor.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/factory.img
BOARD_FLASHFILES += $(TARGET_DEVICE_DIR)/flash.json

# -- OTA RELATED DEFINES --
# tell build system where to get the recovery.fstab.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab 
# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= device/intel/common/recovery
# Adds edify commands swap_entries and copy_partition for robust
# update of the EFI system partition
TARGET_RECOVERY_UPDATER_LIBS := libupdater_esp
# Extra libraries needed to be rolled into recovery updater
# libgpt_static and libefivar are needed by libupdater_esp
TARGET_RECOVERY_UPDATER_EXTRA_LIBS := libcommon_recovery libgpt_static libefivar
# By default recovery minui expects RGBA framebuffer
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
