//
//  ZPhotoViewController.m
//  ZDemo
//
//  Created by 李震 on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import "ZPhotoViewController.h"
#import "ZPhotoCollectionView.h"
#import "PhotoModel.h"

#define getPhotoApi @"photos?client_id=7babfa1738fc5d780def7f1404efed7af9ea600970680b698d5b13cba05dca13"

@interface ZPhotoViewController ()

/** 分页加载的当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
/** collection */
@property (nonatomic,strong)ZPhotoCollectionView * waterList;

@end

@implementation ZPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.waterList];
    [self requestListData];
}


/** 数据请求 */
- (void)requestListData
{
    NSLog(@"show loading");
    NSDictionary * param = @{
                             @"page":[NSString stringWithFormat:@"%ld",self.currentPage],
                             @"per_page":@"20"
                             };
    __weak typeof(self) weakSelf = self;
    [NetWork getRequestWithApi:getPhotoApi param:param result:^(id data) {
        //结束loading 结束刷新动画
        NSLog(@"end loading");
        [weakSelf.waterList endTableLoadingStatus];
        
        if ([data isKindOfClass:[NSArray class]]) {
            if (weakSelf.currentPage == 1) {
                [weakSelf.waterList.listDatas removeAllObjects];
            }
            NSArray * list =  [PhotoModel mj_objectArrayWithKeyValuesArray:data];
            [weakSelf.waterList.listDatas addObjectsFromArray:list];
            [weakSelf.waterList reloadData];
        }else{
            NSLog(@"网络请求失败");
        }
    }];
}




- (ZPhotoCollectionView *)waterList
{
    if (!_waterList) {
        _waterList = [[ZPhotoCollectionView alloc] initWithFrame:CGRectMake(0.0, [Adaptive apNavTopHeight], deviceWidth, deviceHeight - [Adaptive apNavTopHeight])];
        _waterList.hasRefresh = YES;
        _waterList.hasMorePage = YES;
        __weak typeof(self) weakSelf = self;
        //下拉刷新
        _waterList.pullDownRefreshBlock = ^{
            weakSelf.currentPage = 1;
            [weakSelf requestListData];
        };
        //上拉加载
        _waterList.pullUpMoreBlock = ^{
            weakSelf.currentPage ++;
            [weakSelf requestListData];
        };
        
    }
    return _waterList;
}

@end
