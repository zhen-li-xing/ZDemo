//
//  ZPhotoCollectionView.m
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import "ZPhotoCollectionView.h"
#import "ZWaterFlowLayout.h"
#import "ZPhotoCell.h"
#import "ERefreshHeader.h"
#import "ERefreshFooter.h"

@interface ZPhotoCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, ZWaterFlowLayoutDelegate>

/** 瀑布流 */
@property (nonatomic,strong)ZWaterFlowLayout * flowLayout;

@end

@implementation ZPhotoCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[ZPhotoCell class] forCellWithReuseIdentifier:@"ZPhotoCell"];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource
/** 组个数 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/** 组内成员个数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listDatas.count;
}
/** 返回每个cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZPhotoCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZPhotoCell alloc] init];
    }
    if (indexPath.row < self.listDatas.count) {
        [cell updateCellWithModel:self.listDatas[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.dataList.count > indexPath.row) {
//        YSmallVideoItemModel *itemModel = self.dataList[indexPath.row];
//        if (self.smallVideoClick) {
//            self.smallVideoClick(itemModel, indexPath);
//        }
//    }
}

#pragma mark -- ZWaterFlowLayoutDelegate
//返回每个item大小
- (CGSize)waterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDatas.count > indexPath.row) {
        PhotoModel * itemModel = self.listDatas[indexPath.row];
        return CGSizeMake((deviceWidth-30)/2, itemModel.height.floatValue/itemModel.width.floatValue*(deviceWidth-30)/2);
    }
    
    return CGSizeMake(0, 0);
}

/** 列数 */
-(CGFloat)lineCountInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout
{
    return 2;
}
/** 列间距*/
- (CGFloat)lineMarginInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout
{
    return 10;
}
/** 行间距 */
- (CGFloat)rowMarginInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout
{
    return 10;
}
/** 边缘之间的间距 */
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout
{
    return UIEdgeInsetsMake(10,10,10,10);
}






#pragma mark -- 设置是否有下拉刷新
- (void)setHasRefresh:(BOOL)hasRefresh
{
    _hasRefresh = hasRefresh;
    if (hasRefresh) {
        ERefreshHeader *header = [ERefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefreshData)];
        self.mj_header = header;
    }
}
#pragma mark - 设置是否有上拉加载
- (void)setHasMorePage:(BOOL)hasMorePage
{
    _hasMorePage = hasMorePage;
    if (hasMorePage) {
        ERefreshFooter * footer = [ERefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpMoreData)];
        self.mj_footer = footer;
    }
}
#pragma mark -- 下拉刷新
- (void)pullDownRefreshData
{
    [self.mj_footer resetNoMoreData];
    if (self.pullDownRefreshBlock) {
        self.pullDownRefreshBlock();
    }
}
#pragma mark - 上拉加载
- (void)pullUpMoreData
{
    if (self.pullUpMoreBlock) {
        self.pullUpMoreBlock();
    }
}

#pragma mark - 结束下拉/上拉加载状态
- (void)endTableLoadingStatus
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

#pragma mark - 设置是否还有更多数据的状态
- (void)setHasMoreDataStatus:(BOOL)hasMoreDataStatus
{
    _hasMoreDataStatus = hasMoreDataStatus;
    if (hasMoreDataStatus) {
        [self.mj_footer resetNoMoreData];
    } else {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}


- (ZWaterFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[ZWaterFlowLayout alloc] init];
        _flowLayout.delegate = self;
    }
    return _flowLayout;
}
- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [NSMutableArray arrayWithCapacity:0];
    }
    return _listDatas;
}




@end
