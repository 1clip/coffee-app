//
//  NewActivityViewController.m
//  coffee
//
//  Created by wang xuan on 14-12-1.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "NewActivityViewController.h"
#import "ActivityCollectionCell.h"
#import "Constants.h"

@interface NewActivityViewController ()

{
    ActivityCollectionCell *selectedCell;
}

@end

@implementation NewActivityViewController

@synthesize selectedActivity = _selectedActivity;


- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedActivity.image = [UIImage imageNamed:@"smile-22"];
    NSLog(@"%f, %f", _selectedActivity.frame.size.width, _selectedActivity.frame.origin.x);
    [_selectedActivity setBackgroundColor: [Constants ActivityGreenBackground]];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionCellID = @"ActivityCollectionCell";
    ActivityCollectionCell *cell = (ActivityCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell.activityView setBackgroundColor:[Constants ActivityGreenBackground]];
    switch (indexPath.section * 3 + indexPath.row) {
        case 0:
            cell.imageName = @"dinner-22";
            break;
        case 1:
            cell.imageName = @"coffee-22";
            break;
        case 2:
            cell.imageName = @"shopping-22";
            break;
        case 3:
            cell.imageName = @"movie-22";
            break;
        case 4:
            cell.imageName = @"KTV-22";
            break;
        case 5:
            cell.imageName = @"shower-22";
            break;

        default:
            cell.imageName = @"dinner-22";
            break;
    }
    [cell.activityView setImage: [UIImage imageNamed: cell.imageName]];
    return cell;
};


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.collectionView reloadData];
    if(selectedCell)
    {
        [selectedCell.activityView setBackgroundColor:[Constants ActivityGreenBackground]];
    }
    
    ActivityCollectionCell * cell = (ActivityCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.selectedActivity setImage:[UIImage imageNamed:@"dinner"]];
    
    [self.selectedActivity setBackgroundColor:[Constants RedBackgroundColor]];
    [cell.activityView setBackgroundColor:[Constants RedBackgroundColor]];
    
    selectedCell = cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
