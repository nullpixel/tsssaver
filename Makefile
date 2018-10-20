TARGET = iphone:latest:9.0

rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = TSSSaver
TSSSaver_FILES = $(call rwildcard, src/, *.swift *.m)
TSSSaver_CFLAGS = -fobjc-arc
TSSSaver_FRAMEWORKS = UIKit CoreGraphics
TSSSaver_PRIVATE_FRAMEWORKS = IOKit
TSSSaver_SWIFT_BRIDGING_HEADER = src/TSSsaver-Bridging-Header.h
TSSSaver_CODESIGN_FLAGS = -SEntitlements.xml

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"TSSSaver\"; sblaunch co.dynastic.tsssaver" || true
