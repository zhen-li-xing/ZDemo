//
//  ZPhotoCell.m
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import "ZPhotoCell.h"
#import "UIImageView+WebCache.h"
#import "PhotoUrlsModel.h"
#import "EPhotoBrowser.h"

@interface ZPhotoCell ()<EPhotoBrowserDelegate>

/**  */
@property (nonatomic,strong)UIImageView * logoImage;
/**  */
@property (nonatomic,strong)PhotoModel * model;

@end

@implementation ZPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initCell];
    }
    return self;
}

- (void)initCell
{
    [self.contentView addSubview:self.logoImage];
}

- (void)layoutSubviews
{
    self.logoImage.frame = self.bounds;
}

/** 更新UI 显示图片 */
- (void)updateCellWithModel:(PhotoModel *)model
{
    self.model = model;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:model.urls.thumb]];
}


#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView *)tap.view;
    EPhotoBrowser *browserVc = [[EPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.imageCount = 1; // 图片总数
    browserVc.currentImageIndex = (int)tapView.tag;
    browserVc.delegate = self;
    
    [[self findViewController] presentViewController:browserVc animated:NO completion:nil];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoPlaceholderImageForIndex:(NSInteger)index
{
    return self.logoImage.image;
}
- (NSURL *)photoHighQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.model.urls.raw];
}


- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (UIImageView *)logoImage
{
    if (!_logoImage) {
        _logoImage = [UIImageView new];
        _logoImage.layer.cornerRadius = 4.0;
        _logoImage.userInteractionEnabled = YES;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_logoImage addGestureRecognizer:tap];
    }
    return _logoImage;
}


@end
