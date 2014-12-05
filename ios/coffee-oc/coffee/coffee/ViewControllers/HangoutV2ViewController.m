//
//  HangoutV2ViewController.m
//  coffee
//
//  Created by wang xuan on 14-12-5.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutV2ViewController.h"
#import "HangoutV2CollectionViewCell.h"
#import "Constants.h"
#import "NewActivityViewController.h"

@interface HangoutV2ViewController ()

@end

@implementation HangoutV2ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpCollection];
    
    [self.addHangoutView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    [self.addHangoutLabel setTextColor:[Constants AddActivityFontColor]];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view layoutIfNeeded];
    CGFloat width = self.addHangoutView.frame.size.width / 2;
    UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(width - 15, 5, 30, 30)];
    [addImage setImage:[UIImage imageNamed:@"add"]];
    [self.addHangoutView addSubview:addImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width - 50, addImage.frame.origin.y + 30, 100, 20)];
    [label setText:@"New Activity"];
    [label setTextColor:[Constants AddActivityFontColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.addHangoutView addSubview:label];

}

-(void)setUpCollection{
    self.hangoutCollectionView.delegate = self;
    self.hangoutCollectionView.dataSource = self;
    
    
}
#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionCellID = @"HangoutV2CollectionViewCell";
    HangoutV2CollectionViewCell *cell = (HangoutV2CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    [cell.activityImage setImage:[UIImage imageNamed:@"dinner-22"]];
    [cell.avatorImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"]];
    [cell.borderView setBackgroundColor:[Constants MainPageBorderColor]];
    
    [cell.userNameLabel setText: @"奥迪哥"];
    [cell.userNameLabel setTextColor:[Constants MainPageFontColor]];
    
    [cell.topicLabel1 setText: @"Today is my birthday"];
    [cell.topicLabel1 setTextColor:[Constants MainPageFontColor]];
    
    [cell.topicLabel2 setText: @"Today is my birthday"];
    [cell.topicLabel2 setTextColor:[Constants MainPageFontColor]];
    
    [cell.schedule setText: @"10/28"];
    
    switch (indexPath.row) {
        case 0:
            [cell.activityImage setBackgroundColor:[Constants OrangeBackgroundColor]];
            break;
        case 1:
            [cell.activityImage setBackgroundColor:[Constants ActivityGreenBackground]];
            break;
        case 2:
            [cell.activityImage setBackgroundColor:[Constants ActivityGreenBackground]];
            break;
        case 3:
            [cell.activityImage setBackgroundColor:[Constants RedBackgroundColor]];
            break;
        case 4:
            [cell.activityImage setBackgroundColor:[Constants GrayBackgroundColor]];
            break;
        default:
            [cell.activityImage setBackgroundColor:[Constants OrangeBackgroundColor]];
            break;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
