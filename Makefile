ARCHS = arm64 armv7
TARGET = iphone:clang:11.2:9.0
DEBUG = 0
#CFLAGS = -fobjc-arc
#THEOS_PACKAGE_DIR_NAME = debs

include theos/makefiles/common.mk

TWEAK_NAME = Stylish11
Stylish11_FILES = Tweak.xm
Stylish11_CFLAGS = -fobjc-arc
Stylish11_FRAMEWORKS = UIKit Foundation 
Stylish11_EXTRA_FRAMEWORKS += Cephei, CepheiPrefs
Stylish11_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += Stylish11
include $(THEOS_MAKE_PATH)/aggregate.mk
