//
//  ZWaterFlowLayout.m
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import "ZWaterFlowLayout.h"

@interface ZWaterFlowLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong)NSMutableArray * attrsArray;

/** 存放每一列的最大y值进行布局 */
@property (nonatomic, strong)NSMutableArray * lineHeights;

/** 内容的高度 */
@property (nonatomic, assign)CGFloat maxLineHeight;
/** 内容的宽度 */
@property (nonatomic, assign)CGFloat maxRowWidth;


@end

@implementation ZWaterFlowLayout

/** 每一列之间的间距 */
- (CGFloat)lineMargin
{
    if ([self.delegate respondsToSelector:@selector(lineMarginInWaterFlowLayout:)]) {
        return [self.delegate lineMarginInWaterFlowLayout:self];
    } else {
        return  10.0;
    }
}
/** 每一行之间的间距 */
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    } else {
        return 10.0;
    }
}
/** 列数 */
- (NSInteger)lineCount
{
    if ([self.delegate respondsToSelector:@selector(lineCountInWaterFlowLayout:)]) {
        return [self.delegate lineCountInWaterFlowLayout:self];
    } else {
        return  2;
    }
}
///** 行数 */
//- (NSInteger)rowCount
//{
//    if ([self.delegate respondsToSelector:@selector(rowCountInWaterFlowLayout:)]) {
//        return [self.delegate rowCountInWaterFlowLayout:self];
//    } else {
//        return  2;
//    }
//}
/** 边缘之间的间距 */
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetInWaterFlowLayout:self];
    } else {
        return  UIEdgeInsetsMake(5, 5, 5, 5);
    }
}

#pragma mark -- 重写布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.maxLineHeight = 0;
    [self.lineHeights removeAllObjects];
    for (NSInteger i = 0; i < self.lineCount; i++) {
        [self.lineHeights addObject:@(self.edgeInsets.top)];
    }
    
    [self.attrsArray removeAllObjects];
    
    //开始创建每一组cell的布局属性
    NSInteger sectionCount =  [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < sectionCount; section++){
        //开始创建组内的每一个cell的布局属性
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger row = 0; row < rowCount; row++) {
            //创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
            //获取indexPath位置cell对应的布局属性
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes  layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = [self itemFrameOfVerticalWaterFlow:indexPath];
    return attrs;
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxLineHeight + self.edgeInsets.bottom);
}

#pragma mark --
- (CGRect)itemFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath
{
    //collectionView的宽度
    CGFloat collectionW = self.collectionView.frame.size.width;
    //设置布局属性item的frame
    CGFloat w = (collectionW - self.edgeInsets.left - self.edgeInsets.right - (self.lineCount - 1) * self.lineMargin) / self.lineCount;
    CGFloat h = [self.delegate waterFlowLayout:self sizeForItemAtIndexPath:indexPath].height;
    
    //找出高度最短的那一列
    NSInteger destline = 0;
    CGFloat minlineHeight = [self.lineHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.lineCount; i++) {
        //取出第i列
        CGFloat lineHeight = [self.lineHeights[i] doubleValue];
        if (minlineHeight > lineHeight) {
            minlineHeight = lineHeight;
            destline = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destline * (w + self.lineMargin);
    CGFloat y = minlineHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    
    //更新最短那列的高度
    self.lineHeights[destline] = @(CGRectGetMaxY(CGRectMake(x, y, w, h)));
    //记录内容的高度
    CGFloat lineHeight = [self.lineHeights[destline] doubleValue];
    if (self.maxLineHeight < lineHeight) {
        self.maxLineHeight = lineHeight;
    }
    
    return CGRectMake(x, y, w, h);
}


- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _attrsArray;
}
- (NSMutableArray *)lineHeights
{
    if (!_lineHeights) {
        _lineHeights = [NSMutableArray arrayWithCapacity:0];
    }
    return _lineHeights;
}


@end
