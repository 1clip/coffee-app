//
//  HangoutViewController.m
//  JoinMeDemo
//
//  Created by wang xuan. on 14/11/14.
//  Copyright (c) 2014年 wang xuan.. All rights reserved.
//

#import "HangoutViewController.h"
#import "UITableGridViewCell.h"
#import "NewTopicViewController.h"
#import "ActivityDetailViewController.h"

@interface HangoutViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)int mScreenW;
@property(nonatomic,assign)int mScreenH;
@end

@implementation HangoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"JoinMe";
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize mSize = [[UIScreen mainScreen] bounds].size;
    self.mScreenW = mSize.width;
    self.mScreenH = mSize.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.mScreenW, self.mScreenH-44) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITable datasource and delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i=0; i<2; i++) {
            HangoutView *view = [[HangoutView alloc] initWithFrame:CGRectMake(0, 0, self.mScreenW/2, (self.mScreenH-88)/3)];
            view.row = (int)(indexPath.row*2+i);
            [view setData:view.row];
            [view.clickButton addTarget:self action:@selector(imageItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [view.clickButton setTag:view.row];
            view.delegate = self;
            view.center = CGPointMake(self.mScreenW/2 *( 0.5 + i) , (self.mScreenH-88)/3 * 0.5);
            [view setViewColor:(int)(indexPath.row*2+i)];
            [cell addSubview:view];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.mScreenH-88)/3;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    NSLog(@"selectd row =%ld",indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)imageItemClick:(UIButton *)button{
    long tag = button.tag;
    NSLog(@" button tag = %ld", tag);
    if (tag == 0) {
        NewTopicViewController* ntvc = [[NewTopicViewController alloc] init];
        [self.navigationController pushViewController:ntvc animated:YES];
    }else {
        ActivityDetailViewController* advc = [[ActivityDetailViewController alloc] init];
        advc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:advc animated:YES];
    }
}

- (void) HangoutViewTouchHandle:(int)row{
    NSLog(@"row=%d",row);
}
@end
