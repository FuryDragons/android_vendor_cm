# Permissions for cmsdk services
PRODUCT_COPY_FILES += \
    vendor/furydragons/config/permissions/org.furydragons.appsuggest.xml:system/etc/permissions/org.furydragons.appsuggest.xml \
    vendor/furydragons/config/permissions/org.furydragons.audio.xml:system/etc/permissions/org.furydragons.audio.xml \
    vendor/furydragons/config/permissions/org.furydragons.livedisplay.xml:system/etc/permissions/org.furydragons.livedisplay.xml \
    vendor/furydragons/config/permissions/org.furydragons.partner.xml:system/etc/permissions/org.furydragons.partner.xml \
    vendor/furydragons/config/permissions/org.furydragons.performance.xml:system/etc/permissions/org.furydragons.performance.xml \
    vendor/furydragons/config/permissions/org.furydragons.profiles.xml:system/etc/permissions/org.furydragons.profiles.xml \
    vendor/furydragons/config/permissions/org.furydragons.statusbar.xml:system/etc/permissions/org.furydragons.statusbar.xml \
    vendor/furydragons/config/permissions/org.furydragons.telephony.xml:system/etc/permissions/org.furydragons.telephony.xml \
    vendor/furydragons/config/permissions/org.furydragons.weather.xml:system/etc/permissions/org.furydragons.weather.xml

# FURYDRAGONS Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# FURYDRAGONS Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# JNI Libraries
PRODUCT_PACKAGES += \
    libcmsdk_platform_jni

ifndef CM_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  CM_PLATFORM_SDK_VERSION := 7
endif

ifndef CM_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each CM_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  CM_PLATFORM_REV := 0
endif

# CyanogenMod Platform SDK Version
PRODUCT_PROPERTY_OVERRIDES += \
  ro.fds.build.version.plat.sdk=$(CM_PLATFORM_SDK_VERSION)

# CyanogenMod Platform Internal
PRODUCT_PROPERTY_OVERRIDES += \
  ro.fds.build.version.plat.rev=$(CM_PLATFORM_REV)

