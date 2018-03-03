TARGET = iphone:latest:9.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = TSSSaver
TSSSaver_FILES = $(wildcard src/*.swift) $(wildcard src/*.m)
TSSSaver_CFLAGS = -fobjc-arc
TSSSaver_FRAMEWORKS = UIKit CoreGraphics
TSSSaver_PRIVATE_FRAMEWORKS = IOKit
TSSSaver_SWIFT_BRIDGING_HEADER = src/TSSsaver-Bridging-Header.h
TSSSaver_CODESIGN_FLAGS = -SEntitlements.xml

include $(THEOS_MAKE_PATH)/application.mk

$(THEOS_OBJ_DIR)/%.storyboardc:: %.storyboard
	$(ECHO_COMPILING)xcrun -sdk iphoneos ibtool --errors --warnings --notices --output-format human-readable-text --module TSSSaver --target-device iphone --minimum-deployment-target 9.0 --compile "$@" "$<"$(ECHO_END)

before-TSSSaver-all:: $(THEOS_OBJ_DIR)/src/LaunchScreen.storyboardc $(THEOS_OBJ_DIR)/src/Main.storyboardc

stage::
	cp -r $(THEOS_OBJ_DIR)/src/LaunchScreen.storyboardc $(THEOS_STAGING_DIR)/Applications/TSSsaver.app/LaunchScreen.storyboardc
	cp -r $(THEOS_OBJ_DIR)/src/Main.storyboardc $(THEOS_STAGING_DIR)/Applications/TSSsaver.app/Main.storyboardc

after-install::
	install.exec "killall \"TSSSaver\"" || true
