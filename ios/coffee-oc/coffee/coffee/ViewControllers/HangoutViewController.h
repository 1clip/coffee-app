//
//  HangoutViewController.h
//  coffee
//
//  Created by wang xuan on 14-11-30.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#ifndef coffee_HangoutViewController_h
#define coffee_HangoutViewController_h


#endif


#import <UIKit/UIKit.h>

@interface HangoutViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>


@property (strong, nonatomic)NSMutableArray *dataMArr;
@property (weak, nonatomic) IBOutlet UICollectionView *hangoutCollectionView;



@end