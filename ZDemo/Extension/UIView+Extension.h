//
//  UIView+Extension.h
//  SomeFunction
//
//  Created by 李震 on 16/8/4.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


@end


@interface UILabel (Extension)

/** 初始化UILabel */
+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;

@end

