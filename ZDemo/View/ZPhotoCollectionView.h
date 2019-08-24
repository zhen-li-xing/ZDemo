//
//  ZPhotoCollectionView.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPhotoCollectionView : UICollectionView

/** 列表数据源 */
@property (nonatomic, strong) NSMutableArray * listDatas;
/** 是否有下拉刷新 */
@property (nonatomic, assign) BOOL hasRefresh;
/** 是否有上拉加载 */
@property (nonatomic, assign) BOOL hasMorePage;

/** 是否还有更多数据状态 */
@property (nonatomic, assign) BOOL hasMoreDataStatus;

/** 列表停止加载EndLoading */
- (void)endTableLoadingStatus;

/** 下拉刷新回调 */
@property (nonatomic,copy)void (^pullDownRefreshBlock)(void);

/** 上拉加载回调 */
@property (nonatomic,copy)void (^pullUpMoreBlock)(void);


@end

NS_ASSUME_NONNULL_END
