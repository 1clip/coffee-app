//
//  HangoutCollectionCellCollectionViewCell.h
//  coffee
//
//  Created by wang xuan on 14-11-30.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFAvatarView.h"

@interface HangoutCollectionCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet CFAvatarView *avatorImage;
@property(nonatomic, retain) IBOutlet UIView *view;

@property(nonatomic, retain) IBOutlet UIImageView *acceptImage;
@property(nonatomic, retain) IBOutlet UILabel *acceptCount;

@end
