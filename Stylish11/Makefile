ARCHS = arm64
TARGET = iphone:clang;9.0:7.4
include theos/makefiles/common.mk

#import <Cephei/Cephei>
#import <CepheiPrefs/CepheiPrefs>

BUNDLE_NAME = Stylish11
Stylish11_FILES = $(wildcard *.m) 
Stylish11_INSTALL_PATH = /Library/PreferenceBundles
Stylish11_FRAMEWORKS = UIKit Foundation 
Stylish11_PRIVATE_FRAMEWORKS = Preferences
Stylish11_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
Stylish11_CFLAGS = -fobjc-arc
Stylish11_LDFLAGS += -lCSColorPicker
Stylish11_LIBRARIES += cepheiprefs cephei

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Stylish11.plist$(ECHO_END)
