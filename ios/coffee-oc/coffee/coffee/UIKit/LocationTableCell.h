//
//  LocationTableCell.h
//  coffee
//
//  Created by wang xuan on 14-12-2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView *locationImage;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) IBOutlet UILabel *addressLabel;

@end
