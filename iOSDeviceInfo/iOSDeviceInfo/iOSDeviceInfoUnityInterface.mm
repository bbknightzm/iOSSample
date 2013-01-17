//
//  iosDeviceInfoUnityInterface.m
//  iosDeviceInfo
//
//  Created by bb on 1/15/13.
//  Copyright (c) 2013 bb. All rights reserved.
//

#ifndef __IOSDeviceInfoUnityInterface__H__
#define __IOSDeviceInfoUnityInterface__H__

#include "iOSDeviceInfo.h"
extern "C"
{
    const char* GetiOSMacAddress()
    {
        // return (char *)[[iOSDeviceInfo GetiOSMacAddress] UTF8String]; // error : memory leak
        // return (char *)[[iOSDeviceInfo GetiOSMacAddress] cStringUsingEncoding:NSASCIIStringEncoding]; // error : memory leak
        NSString* macStr = [iOSDeviceInfo GetiOSMacAddress];
        char* mac = (char *)malloc([macStr length]);
        strcpy(mac, [macStr UTF8String]);
        return mac;
    }
}

#endif