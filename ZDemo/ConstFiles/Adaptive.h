//
//  Adaptive.h
//  CRM
//
//  Created by 李震 on 2018/4/16.
//  Copyright © 2018年 李震. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark - 设备类型枚举
typedef NS_ENUM(NSInteger,APDeviceType) {
    APDeviceIphone4 = 0, //iphone4系列设备
    APDeviceIphone5, //iphone5系列设备
    APDeviceIphone6, //iphone6系列设备
    APDeviceIphonePlus, //iphonePlus系列设备
    APDeviceIphoneX, //iphoneX系列设备
    APDeviceIphoneXS, //iphoneX
    APDeviceIphoneXR, //iphoneXR
    APDeviceIphoneXMax, ////iphoneXMax
    APDeviceIphoneSimulator, //iphone模拟器
    APDeviceIphoneOther //其他iphone系列设备
};

@interface Adaptive : NSObject

/** 获取手机设备型号 */
+ (APDeviceType)currentDeviceType;

/** 顶部状态栏+导航栏: iphoneX为44.f+44.f，其他手机为20.f+44.f */
+ (CGFloat)apNavTopHeight;

/** 顶部状态栏: iphoneX为44.f，其他手机为20.f */
+ (CGFloat)apNavStatusHeight;

/** 顶部导航栏: iphoneX为44.f，其他手机为44.f */
+ (CGFloat)apNavHeight;

/** 底部安全区域: iphoneX底部安全区为34.f，其他手机为0.f */
+ (CGFloat)apBarSafeHeight;

/** 底部tab+安全区域: iphoneX为34.f + 49.f，其他手机为49.f */
+ (CGFloat)apBarBottomHeight;

@end
