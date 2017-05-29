//
//  ECID.m
//  TSSsaver
//
//  Created by Jamie Bishop on 13/04/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

@import Foundation;
#import <IOKit/IOKitLib.h>

CFStringRef get_ecid() {
    CFMutableDictionaryRef matching;
    io_service_t service;
    CFDataRef ecidData;
    //const void *ecidDataPtr;
    CFStringRef ecidString;
    
    matching = IOServiceMatching("IOPlatformExpertDevice");
    service = IOServiceGetMatchingService(kIOMasterPortDefault, matching);
    
    if(!service) {
        printf("unable to find platform expert service\n");
        return NULL;
    }
    
    ecidData = IORegistryEntrySearchCFProperty(service, kIODeviceTreePlane, CFSTR("unique-chip-id"), kCFAllocatorDefault, kIORegistryIterateRecursively);
    if(!ecidData) {
        printf("unable to find unique-chip-id property\n");
        IOObjectRelease(service);
        return NULL;
    }
    
    // ecidDataPtr = CFDataGetBytePtr(ecidData);
    //size_t length = CFDataGetLength(ecidData);
    const UInt8 *bytes = CFDataGetBytePtr(ecidData);
    UInt64* b = (UInt64*)bytes;
    ecidString = CFStringCreateWithFormat(kCFAllocatorDefault,NULL,CFSTR("%llu"),*b);
    
    CFRelease(ecidData);
    IOObjectRelease(service);
    
    return ecidString;
}

