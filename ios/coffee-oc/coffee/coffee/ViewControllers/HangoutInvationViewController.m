//
//  HangoutInvationViewController.m
//  coffee
//
//  Created by wang xuan on 14-12-4.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutInvationViewController.h"
#import "CFAvatarView.h"
@interface HangoutInvationViewController ()

{
    NSIndexPath* selectedPath;
    SwipeView * _swipeView;
}

@end

@implementation HangoutInvationViewController


@synthesize searchBar;
@synthesize tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"InvationCell";
    InvationTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell) {
        for(UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width * 0.1, 10, cell.frame.size.width * 0.6, 50)];
        [label setText:@"加利福利亚"];
        [cell addSubview:label];
        if(selectedPath && indexPath == selectedPath)
        {
            if(_swipeView == nil)
            {
                _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 50, cell.frame.size.width, 50)];
                [_swipeView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
                _swipeView.delegate = self;
                _swipeView.dataSource = self;

            }
            [cell addSubview:_swipeView];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectedPath && indexPath == selectedPath)
    {
        return 100;
    }
    else
    {
        return 50;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedPath = indexPath;
    if(_swipeView)
    {
        [_swipeView removeFromSuperview];
    }
    [self.tableView reloadData];
}

-(void)dealloc
{
    if(_swipeView)
    {
        _swipeView.delegate = nil;
        _swipeView.dataSource = nil;
    }
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 5;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        CGFloat height = 40;
        [view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        //if(index % 2 == 0)
        //[view setBackgroundColor:[UIColor redColor]];
        CFAvatarView *avator = [[CFAvatarView alloc] initWithFrame:CGRectMake(5.0, (_swipeView.frame.size.height - height) / 2, height, height)];
        UIColor *bg = [UIColor whiteColor];
        [avator setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xiaowu"] badgeImage:[UIImage imageNamed:@"accept"]];
        [avator setBorderColor:bg];
        [avator setBorderWidth:2.0];
        [view addSubview:avator];
    }
    
    return view;
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
