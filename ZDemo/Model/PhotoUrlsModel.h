//
//  PhotoUrlsModel.h
//  
//
//  Created by zhen on 2019/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoUrlsModel : NSObject

/**  */
@property (nonatomic,copy)NSString * full;
/**  */
@property (nonatomic,copy)NSString * raw;
/**  */
@property (nonatomic,copy)NSString * small;
/**  */
@property (nonatomic,copy)NSString * thumb;

@end

NS_ASSUME_NONNULL_END
