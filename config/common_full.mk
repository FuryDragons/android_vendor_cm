# Inherit common FURYDRAGONS stuff
$(call inherit-product, vendor/furydragons/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
