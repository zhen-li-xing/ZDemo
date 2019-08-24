//
//  EPhotoBrowser.m
//  HZPhotoBrowserDemo
//
//  Created by 李震 on 2017/10/16.
//  Copyright © 2017年 eamon. All rights reserved.
//

#import "EPhotoBrowser.h"
#import "EPhotoShowViews.h"

@interface EPhotoBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource,EPhotoShowViewsDelegate>

@property(nonatomic,strong) UICollectionView              * collocation;
@property(nonatomic,strong) UICollectionViewFlowLayout    * flowLayout;
@property(nonatomic,strong) UIPageControl                 * pageControl;
/** 设置这么个值  只是为了 隐藏启动时滚动的样子 */
@property (nonatomic,assign) BOOL isShowed;

/** 记录一个角标  item消失的时候 根据这个角标把之前的缩放值改回去 然后把角标改为当前最新的值 */


/** *********************  动态中的控件   ************************** */
///**阴影视图 */
//@property (nonatomic,strong)UIView * bgView;
///** 分享按钮 */
//@property (nonatomic,strong)UIButton * shareBtn;
///** 评论按钮 */
//@property (nonatomic,strong)UIButton * discussBtn;
///** 点赞按钮 */
//@property (nonatomic,strong)UIButton * praiseBtn;
///** 横线 */
//@property (nonatomic,strong)UIView * midView;
///** 点赞图片  */
//@property (nonatomic,strong)UIImageView * praiseImage;
///** 点赞数量 */
//@property (nonatomic,strong)UILabel * praiseNumLabel;
///** 评论图片 */
//@property (nonatomic,strong)UIImageView * commentImage;
///** 评论数量 */
//@property (nonatomic,strong)UILabel * commentNumLabel;
///** 时间 */
//@property (nonatomic,strong)UILabel * timeLabel;
///** 内容 */
//@property (nonatomic,strong)YYLabel * contentLabel;
///** 查看更多按钮 */
//@property (nonatomic,strong)UIButton * moreBtn;
///** 昵称 */
//@property (nonatomic,strong)UILabel * nameLabel;

@end

@implementation EPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isShowed = NO;
    [self createCollectionView];
    
//    self.pageControl.hidden = _isShowPageControl;
    [self.view addSubview:self.pageControl];
}
/*
- (void)setDataModel:(ERecommendDetailModel *)dataModel
{
    _dataModel = dataModel;
    //创建UI
    [self createDynamicUI];
    //赋值
    [self setupDynamicData];
    //设置frame
    [self setupDynamicFrame];
}

#pragma mark -- 如果是动态看图  增加的UI
- (void)createDynamicUI
{
    //背景视图
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        [self.view addSubview:_bgView];
    }
    //分享按钮
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[EDynamicTheme eRecommentFullScreenShare] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[ETxtColor goldBtnTxtColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = eFont(14.f);
        [_shareBtn addTarget:self action:@selector(clickedShare:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setImagePosition:EImagePositionLeft spacing:5.f];
        [self.view addSubview:_shareBtn];
    }
    //评论
    if (!_discussBtn) {
        _discussBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _discussBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_discussBtn setImage:[EDynamicTheme eRecommentFullScreenDiscuss] forState:UIControlStateNormal];
        [_discussBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_discussBtn setTitleColor:[ETxtColor goldBtnTxtColor] forState:UIControlStateNormal];
        [_discussBtn addTarget:self action:@selector(clickedDiscuss:) forControlEvents:UIControlEventTouchUpInside];
        _discussBtn.titleLabel.font = eFont(14.f);
        [_discussBtn setImagePosition:EImagePositionLeft spacing:5.f];
        [self.view addSubview:_discussBtn];
    }
    //点赞
    if (!_praiseBtn) {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseBtn setImage:[EDynamicTheme eRecommentFullScreenPraise] forState:UIControlStateNormal];
        [_praiseBtn setImage:[EDynamicTheme eRecommentFullScreenAlreadyPraise] forState:UIControlStateSelected];
        [_praiseBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:[ETxtColor goldBtnTxtColor] forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(clickedPraise:) forControlEvents:UIControlEventTouchUpInside];
        _praiseBtn.titleLabel.font = eFont(14.f);
        [_praiseBtn setImagePosition:EImagePositionLeft spacing:5.f];
        [self.view addSubview:_praiseBtn];
    }
    //中间线
    if (!_midView) {
        _midView = [UIView new];
        _midView.backgroundColor = [EUIColor segmentLineColor];
        [self.view addSubview:_midView];
    }
    //点赞图片
    if (!_praiseImage) {
        _praiseImage = [UIImageView new];
        _praiseImage.contentMode = UIViewContentModeScaleAspectFit;
        _praiseImage.image = [EDynamicTheme eZhaiJianghuListUnLoveImage];
        [self.view addSubview:_praiseImage];
    }
    //点赞数量
    if (!_praiseNumLabel) {
        _praiseNumLabel = [UILabel labelWithTitle:@"" color:[ETxtColor minorViewTxtColor] fontSize:12.f alignment:NSTextAlignmentLeft];
        [self.view addSubview:_praiseNumLabel];
    }
    //评论图片
    if (!_commentImage) {
        _commentImage = [UIImageView new];
        _commentImage.contentMode = UIViewContentModeScaleAspectFit;
        _commentImage.image = [EDynamicTheme eSameRecommentDynamicDiscuss];
        [self.view addSubview:_commentImage];
    }
    //评论数量
    if (!_commentNumLabel) {
        _commentNumLabel = [UILabel labelWithTitle:@"" color:[ETxtColor minorViewTxtColor] fontSize:12.f alignment:NSTextAlignmentLeft];
        [self.view addSubview:_commentNumLabel];
    }
    //时间
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithTitle:@"" color:[ETxtColor minorViewTxtColor] fontSize:12.f alignment:NSTextAlignmentLeft];
        [self.view addSubview:_timeLabel];
    }
    //内容
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _contentLabel.displaysAsynchronously = YES; /// enable async display
        _contentLabel.font = eFont(14.f);
        _contentLabel.textColor = [ETxtColor mainViewTxtColor];
        _contentLabel.numberOfLines = 1;
        _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        NSMutableDictionary *mapper = [NSMutableDictionary new];
        for (int i = 1; i <= 77; i++) {
            [mapper setObject:[UIImage imageNamed:[NSString stringWithFormat:@"[%d]",i]] forKey:[NSString stringWithFormat:@"[%d]",i]];
        }
        YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
        parser.emoticonMapper = mapper;
        _contentLabel.textParser = parser;
        [self.view addSubview:_contentLabel];
    }
    //查看更多按钮
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithTitle:@"查看更多" txtColor:[ETxtColor goldTxtColor] font:12.f image:nil target:self action:@selector(showMoreDetails:)];
        [self.view addSubview:_moreBtn];
    }
    //用户昵称
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithTitle:@"" color:[ETxtColor mainViewTxtColor] fontSize:14.f alignment:NSTextAlignmentLeft];
        [self.view addSubview:_nameLabel];
    }
}
- (void)setupDynamicData
{
    _nameLabel.text = _dataModel.user.uname;
    _timeLabel.text = _dataModel.time_str;
    
    NSString * contentStr = _dataModel.content;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [content yy_setFont:eFont(12.f) range:content.yy_rangeOfAll];
    [content yy_setMaximumLineHeight:18.f range:content.yy_rangeOfAll];
    [content yy_setColor:[ETxtColor mainViewTxtColor] range:content.yy_rangeOfAll];
    //对@人循环判断添加点击事件
    if (_dataModel.ats) {
        id atArr = _dataModel.ats;
        if ([atArr isKindOfClass:[NSArray class]]) {
            for (EDynamicAtUserInfoModel * atUserModel in atArr) {
                NSUInteger length = [contentStr length];
                NSRange range = NSMakeRange(0, length);
                while(range.location != NSNotFound){
                    range = [contentStr rangeOfString: [NSString stringWithFormat:@"@%@",atUserModel.uname] options:0 range:range];
                    if(range.location != NSNotFound){
                        [content yy_setColor:[ETxtColor goldTxtColor] range:range];
                        range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                    }
                }
            }
        }
        
    }
    //对个债循环判断添加高亮
    if (_dataModel.bonds) {
        id atArr = _dataModel.bonds;
        if ([atArr isKindOfClass:[NSArray class]]) {
            for (EDynamicBondModel * bondModel in atArr) {
                NSUInteger length = [contentStr length];
                NSRange range = NSMakeRange(0, length);
                while(range.location != NSNotFound){
                    range = [contentStr rangeOfString: [NSString stringWithFormat:@"$%@(%@)$",bondModel.bname,bondModel.bcode] options:0 range:range];
                    if(range.location != NSNotFound){
                        [content yy_setColor:[ETxtColor orangeTxtColor] range:range];
                        range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                    }
                }
                
            }
        }
    }
    
    NSArray * linkArr = _dataModel.links;
    for (id linkId in linkArr) {
        NSString * linkStr = eFormatterString(@"%@",linkId);
        NSUInteger length = [contentStr length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound){
            range = [contentStr rangeOfString: linkStr options:0 range:range];
            if(range.location != NSNotFound){
                [content yy_setColor:[ETxtColor goldTxtColor] range:range];
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            }
        }
    }
    
    _contentLabel.attributedText = content;
    
    _praiseNumLabel.text = _dataModel.likes;
    _commentNumLabel.text = _dataModel.comments;
    
    if (_dataModel.is_like.integerValue == 1) {
        _praiseBtn.selected = YES;
        _praiseImage.image = [EDynamicTheme eZhaiJianghuListLoveImage];
    }else{
        _praiseBtn.selected = NO;
        _praiseImage.image = [EDynamicTheme eZhaiJianghuListUnLoveImage];
    }
}
- (void)setupDynamicFrame
{
    CGFloat btnW = deviceWidth / 3;
    CGFloat btnY = deviceHeight - 40.f;
    CGFloat btnH = 40.f;
    _praiseBtn.frame = CGRectMake(0, btnY, btnW, btnH);
    _discussBtn.frame = CGRectMake(btnW, btnY, btnW, btnH);
    _shareBtn.frame = CGRectMake(btnW * 2, btnY, btnW, btnH);
    
    _midView.frame = CGRectMake(10, btnY - 1, deviceWidth - 20, 1);
    
    CGFloat timeX = 14.f;
    CGFloat timeH = 18.f;
    CGFloat timeY = CGRectGetMinY(_midView.frame) - 21.f - timeH;
    _timeLabel.frame = CGRectMake(timeX, timeY, deviceWidth - 28.f, timeH);
    
    CGSize moreS = [CalculateSize sizeWithFont:eFont(12.f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) text:@"查看更多"];
    CGFloat moreW = moreS.width + 2.f;
    CGFloat moreH = 24.f;
    CGFloat moreX = deviceWidth - 14.f - moreW;
    CGFloat moreY = CGRectGetMinY(_timeLabel.frame) - moreH;
    _moreBtn.frame = CGRectMake(moreX, moreY, moreW, moreH);
    
    CGFloat contentX = timeX;
    CGFloat contentY = moreY;
    CGFloat contentW = moreX - 28.f;
    CGFloat contentH = moreH;
    _contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat nameX = contentX;
    CGFloat nameY = contentY - 24.f;
    CGFloat nameH = 24.f;
    CGFloat nameW = deviceWidth - 28.f;
    _nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat praiseImageX = nameX;
    CGFloat praiseImageY = CGRectGetMaxY(_timeLabel.frame) + 1.f;
    CGFloat praiseImageW = 12.f;
    CGFloat praiseImageH = 14.f;
    _praiseImage.frame = CGRectMake(praiseImageX, praiseImageY, praiseImageW, praiseImageH);
    
    CGSize praiseNumS = [_praiseNumLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat praiseNumX = CGRectGetMaxX(_praiseImage.frame)+2.f;
    _praiseNumLabel.frame = CGRectMake(praiseNumX, praiseImageY, praiseNumS.width + 10.f, praiseImageH);
    
    CGFloat commentImageX = CGRectGetMaxX(_praiseNumLabel.frame) + 10.f;
    CGFloat commentImageY = praiseImageY;
    CGFloat commentImageW = praiseImageW;
    CGFloat commentImageH = praiseImageH;
    _commentImage.frame = CGRectMake(commentImageX, commentImageY, commentImageW, commentImageH);
    
    CGSize commentNumS = [_commentNumLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat commentNumX = CGRectGetMaxX(_commentImage.frame) + 2.f;
    _commentNumLabel.frame = CGRectMake(commentNumX, commentImageY, commentNumS.width + 10.f, commentImageH);
    
    _bgView.frame = CGRectMake(0, nameY - 10, deviceWidth, deviceHeight - nameY + 10);
}
#pragma mark -- 点击分享
- (void)clickedShare:(UIButton *)btn
{
    __eWeak(weakSelf);
    if ([[UserInfoManage getUserBundlingPhoneNumState] integerValue] == 2) {
        [ECertificationTool popBongdingTelInViewController:weakSelf];
    } else {
        if ([[UserInfoManage getUserCeritificationStatus] integerValue] == 3) {
            [ECertificationTool verifyNickNameIsSet:self AndBlock:^(BOOL isSuccessfully) {
                if (isSuccessfully) {
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(photoClickShare:)]) {
                        [weakSelf.delegate photoClickShare:btn];
                    }
                }
            }];
        } else {
            [[ECertificationTool sharedECertificationTool] promptRenZhengWitnVC:self showAlertView:YES];
        }
    }
}
#pragma mark -- 点击评论
- (void)clickedDiscuss:(UIButton *)btn
{
    __eWeak(weakSelf);
    if ([_dataModel.comments integerValue] == 0) {
        if ([[UserInfoManage getUserBundlingPhoneNumState] integerValue] == 2) {
            [ECertificationTool popBongdingTelInViewController:weakSelf];
        } else {
            if ([[UserInfoManage getUserCeritificationStatus] integerValue] == 3) {
                [ECertificationTool verifyNickNameIsSet:self AndBlock:^(BOOL isSuccessfully) {
                    if (isSuccessfully) {
                        [weakSelf dismissViewControllerAnimated:NO completion:nil];
                        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(photoClickComment:)]) {
                            [weakSelf.delegate photoClickComment:btn];
                        }
                    }
                }];
                
            }else{
                [[ECertificationTool sharedECertificationTool] promptRenZhengWitnVC:self showAlertView:YES];
            }
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(photoClickComment:)]) {
            [self.delegate photoClickComment:btn];
        }
    }
}
#pragma mark -- 点赞
- (void)clickedPraise:(UIButton *)btn
{
    __eWeak(weakSelf);
    if ([[UserInfoManage getUserBundlingPhoneNumState] integerValue] == 2) {
        [ECertificationTool popBongdingTelInViewController:weakSelf];
    } else {
        if ([[UserInfoManage getUserCeritificationStatus] integerValue] == 3) {
            [ECertificationTool verifyNickNameIsSet:self AndBlock:^(BOOL isSuccessfully) {
                if (isSuccessfully) {
                    [weakSelf clickedPraiseBtn:btn];
                }
            }];
            
        }else{
            [[ECertificationTool sharedECertificationTool] promptRenZhengWitnVC:self showAlertView:YES];
        }
    }
}
- (void)clickedPraiseBtn:(UIButton *)btn
{
    NSString * titleStr = _dataModel.likes; //当前点赞数量
    NSInteger temp;
    NSString * islikes = nil; //是点赞还是取消点赞的参数
    
    if (btn.selected) {
        temp = [titleStr intValue] - 1;
        islikes = @"2";
    }else{
        temp = [titleStr intValue] + 1;
        islikes = @"1";
    }
    
    NSString * wid = nil;  //动态id
    if (_dataModel.dynamicType == 1) {
        wid = _dataModel.obj_id ? _dataModel.obj_id : @"";
    }else{
        wid = _dataModel.wid ? _dataModel.wid : @"";
    }
    
    NSDictionary * likeParam = @{@"act":islikes,
                                 @"type":@"2",
                                 @"info_id":wid,
                                 @"uid":[UserInfoManage getUserid]};
    
    btn.userInteractionEnabled = NO;
    
    __eWeak(weakSelf);
    [ENetwork postRequestWithApi:eApi_NewsLikes param:likeParam result:^(id data) {
        btn.userInteractionEnabled = YES;
        if (data) {
            if ([data[@"status"] integerValue] == 0) {
                btn.selected = !btn.selected;
                if (btn.selected) {
                    weakSelf.praiseImage.image = [EDynamicTheme eZhaiJianghuListLoveImage];
                }else{
                    weakSelf.praiseImage.image = [EDynamicTheme eZhaiJianghuListUnLoveImage];
                }
                weakSelf.dataModel.is_like = islikes;
                weakSelf.dataModel.likes = [NSString stringWithFormat:@"%zd",temp];
                weakSelf.praiseNumLabel.text = weakSelf.dataModel.likes;
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(photoClickPraiseLikes:isLike:)]) {
                    [weakSelf.delegate photoClickPraiseLikes:weakSelf.dataModel.likes isLike:weakSelf.dataModel.is_like];
                }
                
            }else{
                [EHubLoading showText:data[@"msg"]];
            }
        }
    }];
}

#pragma mark -- 查看更多
- (void)showMoreDetails:(UIButton *)btn
{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoClickMoreGotoDetails)]) {
        [self.delegate photoClickMoreGotoDetails];
    }
}
*/

#pragma mark --
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.currentImageIndex inSection:0];
    [_collocation scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    if (!_isShowed) {//只是为了一个动画
        [self showPhotoBrowser];
    }else{
        _isShowed = YES;
        _collocation.hidden = NO;
    }
    
}
#pragma mark -- 显示图片
- (void)showPhotoBrowser
{
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    UIView *parentView = [self getParsentView:sourceView];
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:parentView];
    
    //如果是tableview，要减去偏移量
    if ([parentView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)parentView;
        rect.origin.y =  rect.origin.y - tableview.contentOffset.y;
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = rect;
    tempImageView.image = [self placeholderImageForIndex:self.currentImageIndex];
    [self.view addSubview:tempImageView];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat placeImageSizeW = tempImageView.image.size.width;
    CGFloat placeImageSizeH = tempImageView.image.size.height;
    CGRect targetTemp;
    
    if (!kIsFullWidthForLandScape) {
        if (deviceWidth < deviceHeight) {
            CGFloat placeHolderH = (placeImageSizeH * deviceWidth)/placeImageSizeW;
            if (placeHolderH <= deviceHeight) {
                targetTemp = CGRectMake(0, (deviceHeight - placeHolderH) * 0.5 , deviceWidth, placeHolderH);
            } else {
                targetTemp = CGRectMake(0, 0, deviceWidth, placeHolderH);
            }
        } else {
            CGFloat placeHolderW = (placeImageSizeW * deviceHeight)/placeImageSizeH;
            if (placeHolderW < deviceWidth) {
                targetTemp = CGRectMake((deviceWidth - placeHolderW)*0.5, 0, placeHolderW, deviceHeight);
            } else {
                targetTemp = CGRectMake(0, 0, placeHolderW, deviceHeight);
            }
        }
        
    } else {
        CGFloat placeHolderH = (placeImageSizeH * deviceWidth)/placeImageSizeW;
        if (placeHolderH <= deviceHeight) {
            targetTemp = CGRectMake(0, (deviceHeight - placeHolderH) * 0.5 , deviceWidth, placeHolderH);
        } else {
            targetTemp = CGRectMake(0, 0, deviceWidth, placeHolderH);
        }
    }
    
    _collocation.hidden = YES;
    
    [UIView animateWithDuration:.2f animations:^{
        tempImageView.frame = targetTemp;
    } completion:^(BOOL finished) {
        self.isShowed = YES;
        [tempImageView removeFromSuperview];
        self.collocation.hidden = NO;
    }];
}

#pragma mark 获取控制器的view
- (UIView *)getParsentView:(UIView *)view{
    if ([[view nextResponder] isKindOfClass:[UIViewController class]] || view == nil) {
        
        NSLog(@"%@",[view nextResponder]);
        return view;
    }
    return [self getParsentView:view.superview];
}

#pragma mark -- collection 的相关创建及设置
- (void)createCollectionView
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.f;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = self.view.frame.size;
    
    _collocation = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, deviceHeight) collectionViewLayout:_flowLayout];
    _collocation.pagingEnabled = YES;
    _collocation.clipsToBounds = YES;
    _collocation.backgroundColor = [UIColor blackColor];
    _collocation.showsVerticalScrollIndicator = NO;
    _collocation.showsHorizontalScrollIndicator = NO;
    
    //注册cell
    [_collocation registerClass:[EPhotoShowViews class] forCellWithReuseIdentifier:@"ahaha"];
    
    _collocation.delegate = self;
    _collocation.dataSource = self;
    _collocation.hidden = YES;
    [self.view addSubview:_collocation];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPhotoShowViews *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ahaha" forIndexPath:indexPath];
    
    
    [self setupImageWith:cell IndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    
    return cell;
}

- (void)setupImageWith:(EPhotoShowViews *)cell IndexPath:(NSIndexPath *)indexPath
{
    if ([self highQualityImageURLForIndex:indexPath.row]) {
        [cell setImageWithURL:[self highQualityImageURLForIndex:indexPath.row] placeholderImage:[self placeholderImageForIndex:indexPath.row]];
    } else {
        cell.imageview.image = [self placeholderImageForIndex:indexPath.row];
        [cell adjustFrames];
    }
}

#pragma mark -- EPhotoShowViewsDelegate 单击返回
- (void)clickDisVcWith:(EPhotoShowViews *)cell
{
    UIImageView *currentImageView = cell.imageview;
    
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    UIView *parentView = [self getParsentView:sourceView];
    CGRect targetTemp = [sourceView.superview convertRect:sourceView.frame toView:parentView];
    
    // 减去偏移量
    if ([parentView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)parentView;
        targetTemp.origin.y =  targetTemp.origin.y - tableview.contentOffset.y;
    }
    
    
    CGFloat appWidth;
    CGFloat appHeight;
    if (deviceWidth < deviceHeight) {
        appWidth = deviceWidth;
        appHeight = deviceHeight;
    } else {
        appWidth = deviceHeight;
        appHeight = deviceWidth;
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.image = currentImageView.image;
    if (self.isScaleAspectFit) {
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    if (tempImageView.image) {
        CGFloat tempImageSizeH = tempImageView.image.size.height;
        CGFloat tempImageSizeW = tempImageView.image.size.width;
        CGFloat tempImageViewH = (tempImageSizeH * appWidth)/tempImageSizeW;
        if (tempImageViewH < appHeight) {
            tempImageView.frame = CGRectMake(0, (appHeight - tempImageViewH)*0.5, appWidth, tempImageViewH);
        } else {
            tempImageView.frame = CGRectMake(0, 0, appWidth, tempImageViewH);
        }
    } else {
        tempImageView.backgroundColor = [UIColor whiteColor];
        tempImageView.frame = CGRectMake(0, (appHeight - appWidth)*0.5, appWidth, appWidth);
    }
    
    [self.view.window addSubview:tempImageView];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [UIView animateWithDuration:.2f animations:^{
        tempImageView.frame = targetTemp;
        
    } completion:^(BOOL finished) {
        [tempImageView removeFromSuperview];
    }];
    
}

#pragma mark -- scrollview代理 在滚动结束后 把之前改变的缩放值给改回去
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int autualIndex = scrollView.contentOffset.x  / scrollView.bounds.size.width;
    //设置当前下标
    self.currentImageIndex = autualIndex;
    self.pageControl.currentPage = autualIndex;
    for (EPhotoShowViews * view in _collocation.subviews) {
        if (view.imageview.tag != autualIndex) {
            view.scrollview.zoomScale = 1.f;
        }
    }
}

#pragma mark 获取低分辨率（占位）图片
- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoPlaceholderImageForIndex:)]) {
        return [self.delegate photoPlaceholderImageForIndex:index];
    }
    return nil;
}

#pragma mark 获取高分辨率图片url
- (NSURL *)highQualityImageURLForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoHighQualityImageURLForIndex:)]) {
        return [self.delegate photoHighQualityImageURLForIndex:index];
    }
    return nil;
}


- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.f, deviceHeight - 50.f, deviceWidth, 30.f)];
        _pageControl.hidden = _isShowPageControl;
//        _pageControl.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _pageControl.numberOfPages = _imageCount;
        //当前页，取值范围为0 ..... ( pc.numberOfPages - 1 )
        _pageControl.currentPage = _currentImageIndex;
        //颜色
//        //未选中时小圆点的颜色
//        pc.pageIndicatorTintColor = [UIColor redColor];
//        //选中时小圆点的颜色
//        pc.currentPageIndicatorTintColor = [UIColor greenColor];
//
//
//        [pc addTarget:self action:@selector(pagging:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
