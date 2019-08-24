//
//  Macros.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** 屏幕宽度 */
#define deviceWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define deviceHeight [UIScreen mainScreen].bounds.size.height
/** 16进制颜色值转换成UIColor */
#define zHex(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0x00FF00) >> 8))/255.0 blue:((float)(value & 0x0000FF))/255.0 alpha:1.f]
/** 带有透明度的16进制颜色值转换成UIColor */
#define zAlphaHex(value,alp) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0x00FF00) >> 8))/255.0 blue:((float)(value & 0x0000FF))/255.0 alpha:alp]

#endif /* Macros_h */
