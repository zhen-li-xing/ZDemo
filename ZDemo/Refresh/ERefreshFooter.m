//
//  ERefreshFooter.m
//  alphain
//
//  Created by 李震 on 2016/10/28.
//  Copyright © 2016年 afcatstar. All rights reserved.
//

#import "ERefreshFooter.h"
#import "UIView+Extension.h"
#import "Macros.h"
@interface ERefreshFooter ()

/** 文字 */
@property (nonatomic,strong)UILabel * stateLabel;
/** 图片\动画 */
@property (nonatomic,strong)UIImageView * gifImage;
/** 动态图片数组 */
@property (nonatomic,copy)NSArray * idleImages;

@end

@implementation ERefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 90;
    
    // 图片
    if (!_gifImage) {
        _gifImage = [UIImageView new];
        _gifImage.image = self.idleImages.firstObject;
        _gifImage.animationImages = self.idleImages;
        _gifImage.animationDuration = self.idleImages.count * 0.1;
        [self addSubview:_gifImage];
    }
    
    // 文字
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithTitle:@"" color:zHex(0x99C3C7) fontSize:10.f alignment:NSTextAlignmentCenter];
        [self addSubview:_stateLabel];
    }
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    _gifImage.frame = CGRectMake((self.width - 25.f) / 2, 10.f, 25.f, 25.f);
    
    _stateLabel.frame = CGRectMake(0, CGRectGetMaxY(_gifImage.frame), self.width, 30.f);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            _stateLabel.text = @"上拉加载";
            [_gifImage stopAnimating];
            _stateLabel.hidden = YES;
            _gifImage.hidden = YES;
            break;
        case MJRefreshStatePulling:
            _stateLabel.text = @"松开加载";
            [_gifImage stopAnimating];
            _stateLabel.hidden = NO;
            _gifImage.hidden = NO;
            break;
        case MJRefreshStateRefreshing:
            _stateLabel.text = @"加载中";
            [_gifImage startAnimating];
            _stateLabel.hidden = NO;
            _gifImage.hidden = NO;
            break;
        case MJRefreshStateNoMoreData:
            _stateLabel.text = @"已加载完，无更多数据";
            [_gifImage stopAnimating];
            _stateLabel.hidden = NO;
            _gifImage.hidden = YES;
            
            
        default:
            break;
    }
}

- (NSArray *)idleImages
{
    if (!_idleImages) {
        _idleImages = @[
                        [UIImage imageNamed:@"loading01"],
                        [UIImage imageNamed:@"loading02"],
                        [UIImage imageNamed:@"loading03"],
                        [UIImage imageNamed:@"loading04"],
                        [UIImage imageNamed:@"loading05"],
                        [UIImage imageNamed:@"loading06"],
                        [UIImage imageNamed:@"loading07"],
                        [UIImage imageNamed:@"loading08"],
                        [UIImage imageNamed:@"loading09"],
                        [UIImage imageNamed:@"loading10"],
                        [UIImage imageNamed:@"loading11"],
                        [UIImage imageNamed:@"loading12"],
                        [UIImage imageNamed:@"loading13"],
                        [UIImage imageNamed:@"loading14"],
                        [UIImage imageNamed:@"loading15"],
                        [UIImage imageNamed:@"loading16"],
                        [UIImage imageNamed:@"loading17"],
                        [UIImage imageNamed:@"loading18"],
                        [UIImage imageNamed:@"loading19"],
                        [UIImage imageNamed:@"loading20"],
                        [UIImage imageNamed:@"loading21"]
                        ];
    }
    return _idleImages;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
