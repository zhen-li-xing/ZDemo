//
//  PhotoSponsorshipSponsorModel.h
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PhotoSponsorshipSponsorLinksModel;
@class PhotoSponsorshipSponsorProfileImageModel;

@interface PhotoSponsorshipSponsorModel : NSObject
//bid
/**  */
@property (nonatomic,copy)NSString * accepted_tos;
/**  */
@property (nonatomic,copy)NSString * bio;
/**  */
@property (nonatomic,copy)NSString * first_name;
/**  */
@property (nonatomic,copy)NSString * bid;
/**  */
@property (nonatomic,copy)NSString * instagram_username;
/**  */
@property (nonatomic,copy)NSString * last_name;
/**  */
@property (nonatomic,strong)PhotoSponsorshipSponsorLinksModel * links;
/**  */
@property (nonatomic,copy)NSString * location;
/**  */
@property (nonatomic,copy)NSString * name;
/**  */
@property (nonatomic,copy)NSString * portfolio_url;
/**  */
@property (nonatomic,strong)PhotoSponsorshipSponsorProfileImageModel * profile_image;
/**  */
@property (nonatomic,copy)NSString * total_collections;
/**  */
@property (nonatomic,copy)NSString * total_likes;
/**  */
@property (nonatomic,copy)NSString * total_photos;
/**  */
@property (nonatomic,copy)NSString * twitter_username;
/**  */
@property (nonatomic,copy)NSString * updated_at;
/**  */
@property (nonatomic,copy)NSString * username;
@end

@interface PhotoSponsorshipSponsorLinksModel : NSObject
//selfS
/**  */
@property (nonatomic,copy)NSString * followers;
/**  */
@property (nonatomic,copy)NSString * following;
/**  */
@property (nonatomic,copy)NSString * html;
/**  */
@property (nonatomic,copy)NSString * likes;
/**  */
@property (nonatomic,copy)NSString * photos;
/**  */
@property (nonatomic,copy)NSString * portfolio;
/**  */
@property (nonatomic,copy)NSString * selfS;

@end

@interface PhotoSponsorshipSponsorProfileImageModel : NSObject

/**  */
@property (nonatomic,copy)NSString * large;
/**  */
@property (nonatomic,copy)NSString * medium;
/**  */
@property (nonatomic,copy)NSString * small;

@end

NS_ASSUME_NONNULL_END
