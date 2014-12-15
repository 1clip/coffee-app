//
//  HangoutViewControllerV2.m
//  coffee
//
//  Created by wang xuan on 14-12-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutViewControllerV2.h"
#import "Constants.h"

@interface HangoutViewControllerV2 ()

@end

@implementation HangoutViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self InitTabBar];
    [self.personalAvator setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Sample_Rae.jpg"]];
    [self.userName setText:@"Rae911211"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)InitTabBar
{
    
    self.tabBarController.tabBar.barTintColor = [Constants StatusTableBackgroundColor];
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
    [borderView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    borderView.tag = 200;
    [self.tabBarController.tabBar addSubview:borderView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(self.tabBarController.tabBar.frame.size.width / 2.0 - 20, 0, 40, 40);
    [addButton setImage:[UIImage imageNamed:@"Main_Add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addNewActivity:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = 100;
    [self.tabBarController.tabBar addSubview:addButton];
    [self.bottomView setBackgroundColor:[Constants StatusTableBackgroundColor]];
    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.layer.cornerRadius = self.bottomView.frame.size.width / 2.0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self AddButtonForTabbar];
    [self.view layoutIfNeeded];    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"HangoutSWTableCell";
    HangoutSWTableCell *cell = [self.hangoutView  dequeueReusableCellWithIdentifier:identifier];
    if (cell != nil)
    {
        NSString *activityName;
        NSString *avator;
        NSString *user;
        NSString *time;
            
        [cell.topicLabel1 setText: @"Today is my birthday"];
        [cell.topicLabel1 setTextColor:[Constants MainPageFontColor]];
            
        [cell.topicLabel2 setText: @"Today is my birthday"];
        [cell.topicLabel2 setTextColor:[Constants MainPageFontColor]];
        
        [cell.borderView setBackgroundColor:[Constants StatusTableBackgroundColor]];
        
        switch (indexPath.section) {
                case 0:
                    activityName = @"Activity_Dinner";
                    avator = @"Sample_Audi.jpg";
                    user = @"奥迪哥";
                    time = @"10/28";
                    [cell.activityImage setBackgroundColor:[Constants OrangeBackgroundColor]];
                    break;
                case 1:
                    activityName = @"Activity_Coffee";
                    avator = @"Sample_Achie.jpg";
                    user = @"阿屌丝";
                    time = @"3 hours left";
                    [cell.activityImage setBackgroundColor:[Constants GreenBackgroundColor]];
                    break;
                case 2:
                    activityName = @"Activity_Movie";
                    avator = @"Sample_Glass.jpg";
                    user = @"so姐姐";
                    time = @"10/23";
                    [cell.activityImage setBackgroundColor:[Constants GreenBackgroundColor]];
                    break;
                case 3:
                    activityName = @"Activity_KTV";
                    avator = @"Sample_Rae.jpg";
                    user = @"瑞娥";
                    time = @"9/18";
                    [cell.activityImage setBackgroundColor:[Constants RedBackgroundColor]];
                    break;
                case 4:
                    activityName = @"Activity_Shower";
                    avator = @"Sample_Sofang.jpg";
                    user = @"方圆";
                    time = @"4/28";
                    [cell.activityImage setBackgroundColor:[Constants MainPageCancelColor]];
                    break;
                default:
                    activityName = @"Activity_Shopping";
                    avator = @"xiaowu";
                    user = @"吴母牛";
                    time = @"2/17";
                    [cell.activityImage setBackgroundColor:[Constants MainPageCancelColor]];
                    break;
        }
            
        [cell.activityImage setImage:[UIImage imageNamed:activityName]];
        [cell.userNameLabel setText: user];
        
        [cell.userNameLabel setTextColor:[Constants MainPageFontColor]];
        [cell.schedule setText: time];
        [cell.avatorImage setImageWithURL:nil placeholderImage:[UIImage imageNamed:avator]];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:45];
        
        cell.delegate = self;
    }
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants GreenBackgroundColor]
                                                icon:[UIImage imageNamed:@"Main_Accept_Temp"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants RedBackgroundColor]
                                                icon:[UIImage imageNamed:@"Main_Cancel_Temp"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants MainPageCancelColor]
                                                icon:[UIImage imageNamed:@"Main_Trash_Temp"]];
    return rightUtilityButtons;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.hangoutView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"HangoutDetails" sender:self];
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
