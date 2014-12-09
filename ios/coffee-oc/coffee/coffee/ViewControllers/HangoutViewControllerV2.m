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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
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
    
    [self.view setNeedsLayout];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"HangoutSWTableCell";
    HangoutSWTableCell *cell = [self.hangoutView  dequeueReusableCellWithIdentifier:identifier];
    if (cell != nil)
    {
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
        
        cell.rightUtilityButtons = [self rightButtons];
        
        cell.delegate = self;
        
        switch (indexPath.section) {
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
        
    }
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants SWButtonBackgroundColor]
                                                icon:[UIImage imageNamed:@"rightAccept"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants SWButtonBackgroundColor]
                                                icon:[UIImage imageNamed:@"rightAccept"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [Constants SWButtonBackgroundColor]
                                                icon:[UIImage imageNamed:@"rightAccept"]];
    return rightUtilityButtons;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.hangoutView deselectRowAtIndexPath:indexPath animated:YES];
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
