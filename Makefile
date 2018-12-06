ARCHS = arm64 
TARGET = iphone:clang:9.0:7.4
#CFLAGS = -fobjc-arc
#THEOS_PACKAGE_DIR_NAME = debs

#import <UIKit/UIKit.h>
#import <Cephei/Cephei.framework>
#import <CepheiPrefs/CepheiPrefs.framework>

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
