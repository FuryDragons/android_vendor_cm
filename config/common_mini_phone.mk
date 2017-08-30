$(call inherit-product, vendor/furydragons/config/common_mini.mk)

# Required FURYDRAGONS packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/furydragons/config/telephony.mk)
