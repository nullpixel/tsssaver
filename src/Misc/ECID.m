//
//  ECID.m
//  TSSsaver
//
//  Created by nullpixel on 13/04/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

@import Foundation;
#import <IOKit/IOKitLib.h>

CFStringRef getECID() {
    
    CFMutableDictionaryRef matching = IOServiceMatching("IOPlatformExpertDevice");
    io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, matching);
    if (!service) {
       NSLog(@"unable to find platform expert service");
       return NULL;
    }

    CFDataRef ecidData = IORegistryEntrySearchCFProperty(service, kIODeviceTreePlane, CFSTR("unique-chip-id"), kCFAllocatorDefault, kIORegistryIterateRecursively);
    if (!ecidData) {
       NSLog(@"unable to find unique-chip-id property");
       IOObjectRelease(service);
       return NULL;
    }

    const UInt8 *bytes = CFDataGetBytePtr(ecidData);
    UInt64* b = (UInt64*)bytes;
    CFStringRef ecidString = CFStringCreateWithFormat(kCFAllocatorDefault,NULL,CFSTR("%llu"),*b);

    CFRelease(ecidData);
    IOObjectRelease(service);

    return ecidString;
}

