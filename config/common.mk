PRODUCT_BRAND ?= FuryDragons

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/furydragons/CHANGELOG.mkdn:system/etc/CHANGELOG-FURYDRAGONS.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/furydragons/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/furydragons/prebuilt/common/bin/50-furydragons.sh:system/addon.d/50-furydragons.sh \
    vendor/furydragons/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/furydragons/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/furydragons/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# FURYDRAGONS-specific init file
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/etc/init.local.rc:root/init.furydragons.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/furydragons/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is FURYDRAGONS!
PRODUCT_COPY_FILES += \
    vendor/furydragons/config/permissions/com.furydragons.android.xml:system/etc/permissions/com.furydragons.android.xml

# Include FURYDRAGONS audio files
include vendor/furydragons/config/furydragons_audio.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/furydragons/config/cmsdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/furydragons/config/twrp.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required FURYDRAGONS packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional FURYDRAGONS packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable 
	
# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom FURYDRAGONS packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    Eleven \
    ExactCalculator \
    Jelly \
    LockClock \
    Trebuchet \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in FURYDRAGONS
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.furydragons
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/furydragons/overlay/common

PRODUCT_VERSION_MAJOR = 7
PRODUCT_VERSION_MINOR = 2
PRODUCT_VERSION_MAINTENANCE := 1

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    FURYDRAGONS_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    FURYDRAGONS_VERSION_MAINTENANCE := 0
endif

# Set FURYDRAGONS_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef FURYDRAGONS_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "FURYDRAGONS_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^FURYDRAGONS_||g')
        FURYDRAGONS_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(FURYDRAGONS_BUILDTYPE)),)
    FURYDRAGONS_BUILDTYPE :=
endif

ifdef FURYDRAGONS_BUILDTYPE
    ifneq ($(FURYDRAGONS_BUILDTYPE), SNAPSHOT)
        ifdef FURYDRAGONS_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            FURYDRAGONS_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from FURYDRAGONS_EXTRAVERSION
            FURYDRAGONS_EXTRAVERSION := $(shell echo $(FURYDRAGONS_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to FURYDRAGONS_EXTRAVERSION
            FURYDRAGONS_EXTRAVERSION := -$(FURYDRAGONS_EXTRAVERSION)
        endif
    else
        ifndef FURYDRAGONS_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            FURYDRAGONS_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from FURYDRAGONS_EXTRAVERSION
            FURYDRAGONS_EXTRAVERSION := $(shell echo $(FURYDRAGONS_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to FURYDRAGONS_EXTRAVERSION
            FURYDRAGONS_EXTRAVERSION := -$(FURYDRAGONS_EXTRAVERSION)
        endif
    endif
else
    # If FURYDRAGONS_BUILDTYPE is not defined, set to UNOFFICIAL
    FURYDRAGONS_BUILDTYPE := UNOFFICIAL
    FURYDRAGONS_EXTRAVERSION :=
endif

ifeq ($(FURYDRAGONS_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        FURYDRAGONS_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(FURYDRAGONS_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(FURYDRAGONS_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(FURYDRAGONS_VERSION_MAINTENANCE),0)
                FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(FURYDRAGONS_BUILD)
            else
                FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FURYDRAGONS_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(FURYDRAGONS_BUILD)
            endif
        else
            FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(FURYDRAGONS_BUILD)
        endif
    endif
else
    ifeq ($(FURYDRAGONS_VERSION_MAINTENANCE),0)
        FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(FURYDRAGONS_BUILDTYPE)$(FURYDRAGONS_EXTRAVERSION)-$(FURYDRAGONS_BUILD)
    else
        FURYDRAGONS_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FURYDRAGONS_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(FURYDRAGONS_BUILDTYPE)$(FURYDRAGONS_EXTRAVERSION)-$(FURYDRAGONS_BUILD)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.furydragons.version=$(FURYDRAGONS_VERSION) \
    ro.furydragons.releasetype=$(FURYDRAGONS_BUILDTYPE) \
    ro.furydragons.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(FURYDRAGONS_VERSION) \
    ro.cmlegal.url=https://lineageos.org/legal

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/furydragons/build/target/product/security/furydragons

-include vendor/furydragons-priv/keys/keys.mk

FURYDRAGONS_DISPLAY_VERSION := $(FURYDRAGONS_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(FURYDRAGONS_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(FURYDRAGONS_EXTRAVERSION),)
                # Remove leading dash from FURYDRAGONS_EXTRAVERSION
                FURYDRAGONS_EXTRAVERSION := $(shell echo $(FURYDRAGONS_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(FURYDRAGONS_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(FURYDRAGONS_VERSION_MAINTENANCE),0)
            FURYDRAGONS_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(FURYDRAGONS_BUILD)
        else
            FURYDRAGONS_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(FURYDRAGONS_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(FURYDRAGONS_BUILD)
        endif
    endif
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.furydragons.display.version=$(FURYDRAGONS_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/furydragons/config/partner_gms.mk
-include vendor/cyngn/product.mk

# Include FuryDragons Makefile
-include vendor/furydragons/config/furydragons.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
