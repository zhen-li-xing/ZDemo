//
//  EPhotoBrowser.h
//  HZPhotoBrowserDemo
//
//  Created by 李震 on 2017/10/16.
//  Copyright © 2017年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kIsFullWidthForLandScape YES

@protocol EPhotoBrowserDelegate <NSObject>
/** 占位图 */
- (UIImage *)photoPlaceholderImageForIndex:(NSInteger)index;
/** 高清图URL */
- (NSURL *)photoHighQualityImageURLForIndex:(NSInteger)index;

@end

@interface EPhotoBrowser : UIViewController

/** 图片来源的父视图 */
@property (nonatomic, weak) UIView *sourceImagesContainerView;

/** 当前图片 只有一张时传0 */
@property (nonatomic, assign) NSInteger currentImageIndex;
/** 图片总数 */
@property (nonatomic, assign) NSInteger imageCount;
/** 小图时是否按比例显示缩放图 默认为NO */
@property (nonatomic, assign) BOOL isScaleAspectFit;
/** 是否显示PageControl */
@property (nonatomic, assign) BOOL isShowPageControl;


@property (nonatomic,weak)id<EPhotoBrowserDelegate>delegate;

@end
