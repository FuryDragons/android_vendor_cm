# Inherit common FURYDRAGONS stuff
$(call inherit-product, vendor/furydragons/config/common_full.mk)

# Required FURYDRAGONS packages
PRODUCT_PACKAGES += \
    LatinIME

# Include FURYDRAGONS LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/furydragons/overlay/dictionaries

$(call inherit-product, vendor/furydragons/config/telephony.mk)
