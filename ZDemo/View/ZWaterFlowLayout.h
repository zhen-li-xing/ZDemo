//
//  ZWaterFlowLayout.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZWaterFlowLayout;
@protocol ZWaterFlowLayoutDelegate <NSObject>

/** 返回item的大小 */
- (CGSize)waterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 列数*/
-(CGFloat)lineCountInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout;
/** 行数*/
//-(CGFloat)rowCountInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout;

/** 列间距*/
-(CGFloat)lineMarginInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZWaterFlowLayout *)waterFlowLayout;


@end


@interface ZWaterFlowLayout : UICollectionViewLayout

/** delegate*/
@property (nonatomic, weak) id<ZWaterFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
