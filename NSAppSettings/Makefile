
THEOS = /Users/azozzalfiras/opt/theos
THEOS_MAKE_PATH = /Users/azozzalfiras/opt/theos

include $(THEOS)/makefiles/common.mk

ARCHS = armv7 armv7s arm64 arm64e



BUNDLE_NAME = NSApp

$(BUNDLE_NAME)_FILES = NSAppListController.mm
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
iResters_FRAMEWORKS = UIKit
$(BUNDLE_NAME)_FRAMEWORKS = UIKit QuartzCore CoreGraphics MessageUI Social Twitter Foundation
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_LIBRARIES = MobileGestalt
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_LDFLAGS = -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/iResters.plist$(ECHO_END)
