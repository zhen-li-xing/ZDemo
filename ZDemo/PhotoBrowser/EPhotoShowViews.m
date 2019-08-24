//
//  EPhotoShowViews.m
//  HZPhotoBrowserDemo
//
//  Created by 李震 on 2017/10/17.
//  Copyright © 2017年 eamon. All rights reserved.
//

#import "EPhotoShowViews.h"
#import "UIImageView+WebCache.h"

#define kIsFullWidthForLandScape YES

@interface EPhotoShowViews ()<UIScrollViewDelegate>

/** 双击手势 */
@property (nonatomic,strong)UITapGestureRecognizer * doubleTap;
/** 单击手势 */
@property (nonatomic,strong)UITapGestureRecognizer * singleTap;
/** 长按手势 */
@property (nonatomic,strong)UILongPressGestureRecognizer * longTap;

@end

@implementation EPhotoShowViews

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    if (!_scrollview) {
        _scrollview = [UIScrollView new];
        _scrollview.frame = CGRectMake(0, 0, deviceWidth, deviceHeight);
        [_scrollview addSubview:self.imageview];
        _scrollview.delegate = self;
        _scrollview.clipsToBounds = YES;
        _scrollview.minimumZoomScale = .5f;
        _scrollview.maximumZoomScale = 2.f;
        _scrollview.zoomScale = 1.f;
        _scrollview.backgroundColor = [UIColor blackColor];
    }
    [self.contentView addSubview:_scrollview];
    
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
        _imageview.frame = CGRectMake(0, 0, deviceWidth, deviceHeight);
        _imageview.userInteractionEnabled = YES;
    }
    [_scrollview addSubview:_imageview];
    
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    }
    _doubleTap.numberOfTapsRequired = 2;
    _doubleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:_doubleTap];
    
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    }
    //只能有一个手势存在
    [_singleTap requireGestureRecognizerToFail:_doubleTap];
    [self addGestureRecognizer:_singleTap];
    
    //添加长安手势
    if (!_longTap) {
        _longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressed:)];
    }
    [_longTap requireGestureRecognizerToFail:_singleTap];
    [_longTap requireGestureRecognizerToFail:_doubleTap];
    [self addGestureRecognizer:_longTap];
}
#pragma mark -- 点击事件
/** 双击 */
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"双击");
    if (self.scrollview.zoomScale <= 1.f) {
        [self.scrollview setZoomScale:2.f animated:YES];
    } else {
        [self.scrollview setZoomScale:1.f animated:YES]; //还原
    }
}
/** 单击 */
- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickDisVcWith:)]) {
        [_delegate clickDisVcWith:self];
    }
}
/** 长按 */
- (void)longPressed:(UILongPressGestureRecognizer *)longTap
{
    if (longTap.state == UIGestureRecognizerStateBegan) {
        /*__eWeak(weakSelf);
        [ESheetView showSheetViewWithTitles:@[@"保存图片"] images:nil resultData:^(id result, NSInteger index) {
            if (index == 0) {
                [weakSelf saveTheImage];
            }
        }];*/
    }
    
}
- (void)saveTheImage
{
    UIImageWriteToSavedPhotosAlbum(_imageview.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"";
    if (!error) {
        message = @"保存成功";
    }else{
        message = [error description];
    }
    
//    [EHubLoading showText:message];
}


- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    __weak __typeof(self)weakSelf = self;
    [_imageview sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf adjustFrames];
    }];
    _scrollview.frame = self.bounds;
    [self adjustFrames];
}

- (void)adjustFrames
{
    CGRect frame = self.scrollview.frame;
    if (self.imageview.image) {
        CGSize imageSize = self.imageview.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (kIsFullWidthForLandScape) {
            CGFloat ratio = frame.size.width / imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height * ratio;
            imageFrame.size.width = frame.size.width;
        }else{
            if (frame.size.width <= frame.size.height) {
                CGFloat ratio = frame.size.width/imageFrame.size.width;
                imageFrame.size.height = imageFrame.size.height*ratio;
                imageFrame.size.width = frame.size.width;
            }else{
                CGFloat ratio = frame.size.height / imageFrame.size.height;
                imageFrame.size.width = imageFrame.size.width * ratio;
                imageFrame.size.height = frame.size.height;
            }
        }
        
        self.imageview.frame = imageFrame;
        self.scrollview.contentSize = self.imageview.frame.size;
        self.imageview.center = [self centerOfScrollView:_scrollview];
        
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        maxScale = maxScale>2.f?maxScale:2.f;
        
        self.scrollview.minimumZoomScale = .5f;
        self.scrollview.maximumZoomScale = maxScale;
        self.scrollview.zoomScale = 1.f;
        
    }else{
        frame.origin = CGPointZero;
        self.imageview.frame = frame;
        self.scrollview.contentSize = self.imageview.frame.size;
    }
    self.scrollview.contentOffset = CGPointZero;
}

- (CGPoint)centerOfScrollView:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark -- UIScrollView代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _imageview.center = [self centerOfScrollView:scrollView];
    NSLog(@"%f",scrollView.zoomScale);
}

@end
