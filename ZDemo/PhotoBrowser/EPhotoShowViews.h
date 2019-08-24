//
//  EPhotoShowViews.h
//  HZPhotoBrowserDemo
//
//  Created by 李震 on 2017/10/17.
//  Copyright © 2017年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 屏幕宽度 */
#define deviceWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define deviceHeight [UIScreen mainScreen].bounds.size.height

@class EPhotoShowViews;
@protocol EPhotoShowViewsDelegate <NSObject>

- (void)clickDisVcWith:(EPhotoShowViews *)cell;

@end

@interface EPhotoShowViews : UICollectionViewCell

@property (nonatomic,strong)UIScrollView * scrollview;

@property (nonatomic,strong)UIImageView * imageview;

@property (nonatomic,weak)id<EPhotoShowViewsDelegate>delegate;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)adjustFrames;

@end
