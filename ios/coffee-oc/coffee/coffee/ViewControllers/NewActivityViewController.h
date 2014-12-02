//
//  NewActivityViewController.h
//  coffee
//
//  Created by wang xuan on 14-12-1.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewActivityViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIImageView *selectedActivity;
}

@property(nonatomic, strong) IBOutlet UIImageView *selectedActivity;
@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
