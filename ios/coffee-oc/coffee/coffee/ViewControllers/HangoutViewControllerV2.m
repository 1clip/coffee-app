//
//  HangoutViewControllerV2.m
//  coffee
//
//  Created by wang xuan on 14-12-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutViewControllerV2.h"
#import "ViewEnums.h"
#import "FakeData.h"
#import "UIHelper.h"
#import "HangoutHelper.h"
#import "HangoutDetailViewController.h"

@interface HangoutViewControllerV2 ()

@end

@implementation HangoutViewControllerV2

NSMutableArray<HangoutSummary> *activeHangout;
NSMutableArray<HangoutSummary> *overdueHangout;
User *currentUser;
HangoutHelper *hangoutHelper;
long selectHangoutId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self InitTabBar];
    [self LoadData];
    [self.personalAvator setImageWithURL:nil placeholderImage:[UIImage imageNamed:currentUser.avatarInfo.imageUrl]];
    [self.userName setText:currentUser.loginName];
    
}

-(void)LoadData
{
    hangoutHelper = [[HangoutHelper alloc] init];
    currentUser = [hangoutHelper GetCurrentUser];
    activeHangout = [hangoutHelper GetActiveHangoutSummary];
    overdueHangout = [hangoutHelper GetOverdueHangoutSummary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)InitTabBar
{
    
    self.tabBarController.tabBar.barTintColor = [CoffeeUIColor GrayBackgroundColor];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self AddButtonForTabbar];
    [self.view layoutIfNeeded];
}


-(void)AddButtonForTabbar
{

    for(UIView *subView in self.tabBarController.tabBar.subviews)
    {
        if([subView isKindOfClass:[UIButton class]] && ((UIButton*)subView).tag == 100)
        {
            NSLog(@"Already add button for tab bar, skip it");
            return;
        }
    }
    
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, -2, self.tabBarController.tabBar.frame.size.width, 3)];
    [borderView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    borderView.tag = 200;
    [self.tabBarController.tabBar addSubview:borderView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(self.tabBarController.tabBar.frame.size.width / 2.0 - 20, -10, 40, 40);
    [addButton setImage:[UIImage imageNamed:@"Main_Add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addNewActivity:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = 100;
    [self.tabBarController.tabBar addSubview:addButton];
    [self.bottomView setBackgroundColor:[CoffeeUIColor GrayBackgroundColor]];
    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.layer.cornerRadius = self.bottomView.frame.size.width / 2.0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return activeHangout.count + overdueHangout.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"HangoutSWTableCell";
    HangoutSWTableCell *cell = [self.hangoutView  dequeueReusableCellWithIdentifier:identifier];
    if (cell != nil)
    {
        HangoutSummary *hangoutSummary = indexPath.section < activeHangout.count ? activeHangout[indexPath.section]:overdueHangout[indexPath.section - activeHangout.count];
        Hangout *hangout = [hangoutHelper GetHangoutDetails:hangoutSummary.id];
        Participator *myState = [HangoutHelper FindParticipatorByUserId:hangout UserId:currentUser.id];
        
        [cell setData:hangout CurrentHangoutSummary:hangoutSummary UserParticipate:myState];
        cell.delegate = self;
        cell.tag = hangout.id;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.hangoutView deselectRowAtIndexPath:indexPath animated:YES];
    selectHangoutId = [self.hangoutView cellForRowAtIndexPath:indexPath].tag;
    [self performSegueWithIdentifier:@"HangoutDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"HangoutDetails"])
    {
        HangoutDetailViewController * theSegue = segue.destinationViewController;
        [theSegue LoadHangout:selectHangoutId];
    }
}


-(void) addNewActivity: (UIButton *) sender
{
    NSLog(@"Add New Activity");
    [self performSegueWithIdentifier:@"NewActivity" sender:self];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
