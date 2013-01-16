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
    char* GetiOSMacAddress()
    {
        //return (char *)[[iOSDeviceInfo getMacAddress] cStringUsingEncoding:NSASCIIStringEncoding];
        return (char *)[[iOSDeviceInfo GetiOSMacAddress] UTF8String];
    }
}

#endif