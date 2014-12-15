//
//  HangoutInvationViewController.m
//  coffee
//
//  Created by wang xuan on 14-12-4.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutInvationViewController.h"
#import "CFAvatarView.h"
#import "Constants.h"
#import "Placeholder.h"
#import "NewActivityViewControllerV2.h"

@interface HangoutInvationViewController ()
@end

@implementation HangoutInvationViewController

NSIndexPath* selectedIndex;
SwipeView* expandSwipView;
bool expandCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    expandCell = NO;
    selectedIndex = nil;
    
    [self.closeButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//perform your expand stuff (may include animation) for cell here. It will be called when the user touches a cell




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(bool) ExpandCell: (NSIndexPath *) indexPath
{
    if(selectedIndex != nil && selectedIndex.row == indexPath.row)
    {
        return expandCell;
    }
    
    return NO;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self ExpandCell:indexPath] ? 120 : 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"GroupViewCell";
    InvationTableCell *cell = [self.tableView  dequeueReusableCellWithIdentifier:identifier];
    cell.detailsView.hidden = ![self ExpandCell:indexPath];
    if(cell.detailsView.hidden == NO)
    {
        [self ProcessSwipeView:cell];
        [cell.detailsView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    }
    [cell.groupName setFont:[UIFont systemFontOfSize:18]];
    cell.countView.layer.masksToBounds = YES;
    cell.countView.layer.cornerRadius = cell.countView.frame.size.height / 2.0;
    [cell.countView setBackgroundColor:[Constants GreenBackgroundColor]];
    [cell.countLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    switch (indexPath.row) {
        case 0:
            [cell.groupName setText: @"加利福利亚"];
            [cell.countLabel setText: @"3"];
            break;
        case 1:
            [cell.groupName setText: @"闵行帮"];
            [cell.countLabel setText: @"5"];
            break;
        case 2:
            [cell.groupName setText: @"雀友"];
            cell.countView.hidden = YES;
            break;
        case 3:
            [cell.groupName setText: @"桑拿"];
            cell.countView.hidden = YES;
            break;
        case 4:
            [cell.groupName setText: @"其它"];
            cell.countView.hidden = YES;
            break;
        default:
            break;
    }
    
    return cell;
}

-(void) ProcessSwipeView:(InvationTableCell *) cell
{
    expandSwipView = cell.detailsView;
    expandSwipView.delegate = self;
    expandSwipView.dataSource = self;
    [expandSwipView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectedIndex != nil && selectedIndex.row == indexPath.row)
    {
        expandCell = !expandCell;
    }
    else
    {
        selectedIndex = indexPath;
        expandCell = YES;
    }
    
    if(expandSwipView != nil)
    {
        expandSwipView.dataSource = nil;
        expandSwipView.delegate = nil;
    }
    
    [self.tableView reloadData];
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        CGFloat height = 50;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height + 10, expandSwipView.frame.size.height)];
        [view setBackgroundColor:[Constants StatusTableBackgroundColor]];
        
        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, (expandSwipView.frame.size.height - height) / 2 - 5, height, height)];
        UIColor *bg = [UIColor whiteColor];
        NSString *imageName = @"Sample_Audi";
        NSString *badgeName = @"Deatails_Accept";
        NSString *userName = @"奥迪哥";
        switch(index)
        {
            case 0:
                imageName = @"Sample_Rae.jpg";
                badgeName = @"Details_Accept";
                userName = @"瑞娥";
                break;
            case 1:
                imageName = @"Sample_Audi.jpg";
                badgeName = @"Details_Accept";
                userName = @"奥迪哥";
                break;
            case 2:
                imageName = @"Sample_Achie.jpg";
                badgeName = @"Details_Accept";
                userName = @"阿屌丝";
                break;
            case 3:
                imageName = @"Sample_Sofang.jpg";
                badgeName = @"Details_Pending";
                userName = @"方圆";
                break;
            case 4:
                imageName = @"Sample_Glass.jpg";
                badgeName = @"Details_Pending";
                userName = @"So姐姐";
                break;
            case 5:
                imageName = @"xiaowu";
                badgeName = @"Details_Cancel";
                userName = @"吴母牛";
                break;
        }
        [avator setImageWithURL: nil placeholderImage:[UIImage imageNamed:imageName]];
        [avator setBorderColor:bg];
        [avator setBorderWidth:2.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(avator.frame.origin.x, avator.frame.origin.y + avator.frame.size.height + 2.5, height, 10)];
        [label setText:userName];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:avator];
        [view addSubview:label];
    }
    
    return view;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    if([segue.identifier isEqualToString:@"AddFriends"]) //"goView2"是SEGUE连线的标识
    {
        NewActivityViewControllerV2 * theSegue = segue.destinationViewController;
        for(int i = 1; i < 3; i++)
        {
            PlaceholderUser *user = [PlaceholderUser alloc];
            switch (i) {
                case 1:
                    user.avatorImage = @"Sample_Rae.jpg";
                    user.userName = @"Rae911221";
                    break;
                case 2:
                    user.avatorImage = @"Sample_Sofang.jpg";
                    user.userName = @"方圆";
                    break;
                case 3:
                    user.avatorImage = @"Sample_Achie.jpg";
                    user.userName = @"阿屌丝";
                    break;
                case 4:
                    user.avatorImage = @"Sample_Glass.jpg";
                    user.userName = @"So姐姐";
                    break;
                case 5:
                    user.avatorImage = @"xiaowu";
                    user.userName = @"吴母牛";
                    break;
                default:
                    break;
            }
            [theSegue addNewFriend:user];
        }
    }
}


-(void) backButtonAction: (UIButton *) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
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
