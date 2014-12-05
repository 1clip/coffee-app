//
//  HangoutV2ViewController.h
//  coffee
//
//  Created by wang xuan on 14-12-5.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HangoutV2ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, strong) IBOutlet UIButton * addHangoutView;
@property(nonatomic, strong) IBOutlet UICollectionView * hangoutCollectionView;
@property(nonatomic, strong) IBOutlet UILabel* addHangoutLabel;

@end
