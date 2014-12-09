//
//  NewActivityViewControllerV2.m
//  coffee
//
//  Created by wang xuan on 14-12-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "NewActivityViewControllerV2.h"
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"


@interface NewActivityViewControllerV2 ()

@end

@implementation NewActivityViewControllerV2

NSInteger lastCurrentIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.activityView setBackgroundColor:[Constants NewActivityTableBackgroundColor]];
    
    //self.activityView.alignment = SwipeViewAlignmentEdge;
    //self.activityView.pagingEnabled = YES;
    //self.activityView.truncateFinalPage = YES;
    
    
    self.activityView.type = iCarouselTypeCoverFlow2;
    
    [self InitTextBoxBorder:self.descView];
    [self InitTextBoxBorder:self.addressView];
    [self InitTextBoxBorder:self.dateView];
    [self InitTextBoxBorder:self.timeView];
    
    [self.inviteFriend setTextColor:[Constants AddActivityFontColor]];
    [self.inviteFriendBorder setBackgroundColor:[Constants InviteFriendBorderColor]];
    
    [self.avatorView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"]];
    
    lastCurrentIndex = -1;
    
}

-(void) InitTextBoxBorder:(UIView *) textView
{
    textView.layer.cornerRadius=8.0f;
    textView.layer.masksToBounds=YES;
    textView.layer.borderColor = [Constants OrangeBackgroundColor].CGColor; // set color as you want.
    textView.layer.borderWidth = 1.0;

}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
//Swipe view
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 6;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //if (!view)
    //{
    //NSLog(@"%d %d", index, self.activityView.currentItemIndex);
    
    CGFloat width = self.activityView.frame.size.width / 3;

    
    NSString *imageName = @"coffee-22";
    UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.activityView.frame.size.height)];
    [myview setBackgroundColor:[Constants StatusTableBackgroundColor]];    UIView* view1;
    CGFloat width1 = width - 10;
    
    CGFloat hight = MIN(width1, self.activityView.frame.size.height - 20);

    if(index == self.activityView.currentItemIndex || index == self.activityView.currentItemIndex + 1
       || index == self.activityView.currentItemIndex + 2)
    {
    if(index == self.activityView.currentItemIndex)
    {
        view1 = [[Trapezoid alloc]initWithFrame:CGRectMake(15, (self.activityView.frame.size.height - hight) / 2, width1, hight)];
        
        [view1 setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:0.5]];
        
    }
    
    else if(index == self.activityView.currentItemIndex + 1)
    {
        view1 = [[UIView alloc] initWithFrame:CGRectMake(5, (self.activityView.frame.size.height - hight) / 2, width1, hight)];
        
        [view1 setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:1.0]];
        
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(5, self.activityView.frame.size.height - 2, width1, 2)];
        
        [borderView setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:1.0]];
        
        [myview addSubview:borderView];

    }
    
    
    else
    {
        view1 = [[Trapezoid1 alloc] initWithFrame:CGRectMake(0, (self.activityView.frame.size.height - hight) / 2, width1 - 3, hight)];
        
        [view1 setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:0.5]];
            }
    switch(index)
    {
        case 0:
            imageName = @"dinner-22";
            break;
        case 1:
            imageName = @"coffee-22";
            break;
        case 2:
            imageName = @"shopping-22";
            break;
        case 3:
            imageName = @"shower-22";
            break;
        case 4:
            imageName = @"movie-22";
            break;
        case 5:
            imageName = @"KTV-22";
            break;

            
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view1.frame.size.width, view1.frame.size.height)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    
    [imageView setImage:[UIImage imageNamed:imageName]];
    
    [view1 addSubview:imageView];
    //[view1 setImage:[UIImage imageNamed:@"dinner-22"]];
    //load new item view instance from nib
    //control events are bound to view controller in nib file
    //note that it is only safe to use the reusingView if we return the same nib for each
    //item view, if different items have different contents, ignore the reusingView value
    
    
    [myview addSubview:view1];
    }
    

    
    return myview;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    CGSize size;
    size.height = self.activityView.frame.size.height;
    size.width = self.activityView.frame.size.width / 3;
    
    return size;
}


- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate;
{
    if(lastCurrentIndex != self.activityView.currentItemIndex)
    {
        [self.activityView reloadData];
    }
    
    lastCurrentIndex = self.activityView.currentItemIndex;
}
*/
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 7;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        CGFloat width = self.activityView.frame.size.width / 3.0;
        
        CGFloat hight = MIN(width, self.activityView.frame.size.height - 10);
        NSString *imageName = @"coffee-22";
        switch(index)
        {
            case 0:
                imageName = @"dinner-22";
                break;
            case 1:
                imageName = @"coffee-22";
                break;
            case 2:
                imageName = @"shopping-22";
                break;
            case 3:
                imageName = @"shower-22";
                break;
            case 4:
                imageName = @"movie-22";
                break;
            case 5:
                imageName = @"KTV-22";
                break;
                
                
        }

        NSLog(@"%f %f", width, hight);
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, hight, hight)];
        if(index == self.activityView.currentItemIndex)
        {
            [view setBackgroundColor:[Constants OrangeBackgroundColor]];
        }
        else
        {
            [view setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:0.5]];
        }
        [((UIImageView *)view) setImage: [UIImage imageNamed:imageName]];
        //view.contentMode = UIViewContentModeCenter;
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}



- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //[self.activityView scrollToItemAtIndex:self.activityView.currentItemIndex animated:YES];
    [self.activityView reloadData];
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
