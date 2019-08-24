//
//  ZPhotoCell.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZPhotoCell : UICollectionViewCell

- (void)updateCellWithModel:(PhotoModel *)model;

@end

NS_ASSUME_NONNULL_END
