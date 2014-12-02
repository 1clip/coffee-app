//
//  HangoutViewController.m
//  coffee
//
//  Created by wang xuan on 14-11-30.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutViewController.h"
#import "HangoutCollectionCell.h"
#import "HangoutDetailViewController.h"
#import "AddHangoutCollectionCell.h"


@implementation HangoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpCollection];
}

-(void)setUpCollection{
    self.hangoutCollectionView.delegate = self;
    self.hangoutCollectionView.dataSource = self;
    
    
}
#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 && indexPath.row  == 0){
        static NSString *collectionCellID = @"AddHangoutCollectionCell";
        AddHangoutCollectionCell *cell = (AddHangoutCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        return cell;
    }
    else{
        static NSString *collectionCellID = @"HangoutCollectionCell";
        HangoutCollectionCell *cell = (HangoutCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
        [cell.avatorImage setImageWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"xiaowu.sample@2x" ofType:@"png"]]];
        [self setData: indexPath viewForCollection:cell];
        return cell;
    }
};

-(void)setData:(NSIndexPath *) indexPath viewForCollection:(HangoutCollectionCell *) cell
{
    long index = indexPath.section * 2 + indexPath.row;
    
    cell.acceptImage.image = [UIImage imageNamed:@"status_pending"];
    cell.acceptCount.text = @"3";

    switch (index) {
        case 0:
            [cell.view setBackgroundColor:[UIColor lightTextColor]];
            break;
        case 1:
            [cell.view setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0]];
            break;
        case 2:
            [cell.view setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:206.0/255.0 blue:180.0/255.0 alpha:1.0]];
            break;
        case 3:
            [cell.view setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:188.0/255.0 blue:164.0/255.0 alpha:1.0]];
            break;
        case 4:
            [cell.view setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
            break;
        case 5:
            [cell.view setBackgroundColor:[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]];
            break;
        default:
            break;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.navigationController pushViewController:[[HangoutDetailViewController alloc] init] animated:YES];
}

@end