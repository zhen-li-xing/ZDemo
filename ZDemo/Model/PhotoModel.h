//
//  PhotoModel.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class PhotoLinksModel;
@class PhotoSponsorshipModel;
@class PhotoUrlsModel;
@interface PhotoModel : NSObject
//photoid //descriptionStr
/**  */
@property (nonatomic,copy)NSString * alt_description;
/**  */
@property (nonatomic,copy)NSArray * categories;
/**  */
@property (nonatomic,copy)NSString * color;
/**  */
@property (nonatomic,copy)NSString * created_at;
/**  */
@property (nonatomic,copy)NSArray * current_user_collections;
/**  */
@property (nonatomic,copy)NSString * descriptionStr;
/**  */
@property (nonatomic,copy)NSString * height;
/**  */
@property (nonatomic,copy)NSString * photoid;
/**  */
@property (nonatomic,copy)NSString * liked_by_user;
/**  */
@property (nonatomic,copy)NSString * likes;
/**  */
@property (nonatomic,strong)PhotoLinksModel * links;
/**  */
@property (nonatomic,strong)PhotoSponsorshipModel * sponsorship;
/**  */
@property (nonatomic,copy)NSString * updated_at;
/**  */
@property (nonatomic,strong)PhotoUrlsModel * urls;
/**  */
@property (nonatomic,copy)NSString * width;
@end



@interface PhotoLinksModel : NSObject
//selfS
/**  */
@property (nonatomic,copy)NSString * download;
/**  */
@property (nonatomic,copy)NSString * download_location;
/**  */
@property (nonatomic,copy)NSString * html;
/**  */
@property (nonatomic,copy)NSString * selfS;

@end

@class PhotoSponsorshipSponsorModel;

@interface PhotoSponsorshipModel : NSObject

/**  */
@property (nonatomic,copy)NSString * impressions_id;
/**  */
@property (nonatomic,strong)PhotoSponsorshipSponsorModel * sponsor;
/**  */
@property (nonatomic,copy)NSString * tagline;

@end




NS_ASSUME_NONNULL_END
