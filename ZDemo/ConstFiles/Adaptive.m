//
//  Adaptive.m
//  CRM
//
//  Created by 李震 on 2018/4/16.
//  Copyright © 2018年 李震. All rights reserved.
//

#import "Adaptive.h"
#import "sys/utsname.h"

@implementation Adaptive

+ (APDeviceType)currentDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return APDeviceIphone4;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return APDeviceIphone4;
    if ([deviceString isEqualToString:@"iPhone3,3"])    return APDeviceIphone4;
    if ([deviceString isEqualToString:@"iPhone4,1"])    return APDeviceIphone4;
    if ([deviceString isEqualToString:@"iPhone5,1"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone5,2"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone5,3"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone5,4"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone6,1"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone6,2"])    return APDeviceIphone5;
    if ([deviceString isEqualToString:@"iPhone7,1"])    return APDeviceIphonePlus;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return APDeviceIphonePlus;
    if ([deviceString isEqualToString:@"iPhone8,4"])    return APDeviceIphone5;
    
    if ([deviceString isEqualToString:@"iPhone9,1"])    return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone9,2"])    return APDeviceIphonePlus;
    if ([deviceString isEqualToString:@"iPhone9,3"])    return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone9,4"])    return APDeviceIphonePlus;
    if ([deviceString isEqualToString:@"iPhone10,1"])   return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone10,4"])   return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone10,2"])   return APDeviceIphonePlus;
    if ([deviceString isEqualToString:@"iPhone10,5"])   return APDeviceIphone6;
    if ([deviceString isEqualToString:@"iPhone10,3"])   return APDeviceIphoneX;
    if ([deviceString isEqualToString:@"iPhone10,6"])   return APDeviceIphoneX;
    if ([deviceString isEqualToString:@"iPhone11,2"])   return APDeviceIphoneXS;
    if ([deviceString isEqualToString:@"iPhone11,4"])   return APDeviceIphoneXMax;
    if ([deviceString isEqualToString:@"iPhone11,6"])   return APDeviceIphoneXMax;
    if ([deviceString isEqualToString:@"iPhone11,8"])   return APDeviceIphoneXR;
                                                                
    
    
    if ([deviceString isEqualToString:@"x86_64"] || [deviceString isEqualToString:@"i386"]) {
        if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) {
            return APDeviceIphone5;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO) {
            return APDeviceIphone6;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)
                                                                                   || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO) {
            return APDeviceIphonePlus;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) {
            return APDeviceIphoneX;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO) {
            //XR
            return APDeviceIphoneXR;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) {
            //xs
            return APDeviceIphoneXS;
        } else if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) {
            //x max
            return APDeviceIphoneXMax;
        }else {
            return APDeviceIphoneOther;
        }
    }
    return APDeviceIphoneOther;
}


static inline BOOL isIPhoneXSeries() {
    
    BOOL iPhoneXSeries = NO;
    
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
         return iPhoneXSeries;
    }

    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
    
}


+ (CGFloat)apNavTopHeight
{
    if (isIPhoneXSeries()) {
        return 44.+44.;
    } else {
        return 20.+44.;
    }
}

+ (CGFloat)apNavStatusHeight
{
    if (isIPhoneXSeries()) {
        return 44.;
    } else {
        return 20.;
    }
}

+ (CGFloat)apNavHeight
{
    return 44.f;
}

+ (CGFloat)apBarSafeHeight
{
    if (isIPhoneXSeries()) {
        return 34.;
    } else {
        return 0.;
    }
}

+ (CGFloat)apBarBottomHeight
{
    //((APDeviceIphoneX == [Adaptive currentDeviceType]) || (APDeviceIphoneXR == [Adaptive currentDeviceType]) || (APDeviceIphoneXMax == [Adaptive currentDeviceType]))
    if (isIPhoneXSeries()) {
        return 34. + 49.;
    } else {
        return 49.;
    }
}


@end
