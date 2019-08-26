//
//  ViewController.m
//  ZDemo
//
//  Created by zhen on 2019/8/24.
//  Copyright © 2019 zhen. All rights reserved.
//

#import "ViewController.h"
#import "ZPhotoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"UICollectionView" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 200, deviceWidth - 20, 40);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(presentWaterFlow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

/** 点击跳转到collection瀑布流 */
- (void)presentWaterFlow
{
    ZPhotoViewController * phptoVc = [ZPhotoViewController new];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:phptoVc];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
