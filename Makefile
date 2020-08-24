THEOS = /Users/azozzalfiras/opt/theos
THEOS_MAKE_PATH = /Users/azozzalfiras/opt/theos


ARCHS = armv7 armv7s arm64 arm64e

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NSApp

NSApp_FILES = $(wildcard *.xm)
NSApp_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += NSAppSettings
include $(THEOS_MAKE_PATH)/aggregate.mk
