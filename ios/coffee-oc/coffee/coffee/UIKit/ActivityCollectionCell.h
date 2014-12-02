//
//  ActivityCollectionCellCollectionViewCell.h
//  coffee
//
//  Created by wang xuan on 14-12-2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCollectionCell : UICollectionViewCell

@property(nonatomic, retain) IBOutlet UIImageView *activityView;
@property(nonatomic, weak) NSString *imageName;

@end
