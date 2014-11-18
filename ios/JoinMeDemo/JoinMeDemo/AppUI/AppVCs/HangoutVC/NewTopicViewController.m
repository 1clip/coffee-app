//
//  NewTopicViewController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "NewTopicViewController.h"
#import "UITableGridViewCell.h"
#import "UIImageButton.h"

@interface NewTopicViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UITextField *searchBar;
@property(nonatomic,assign)int mScreenW;
@property(nonatomic,assign)int mScreenH;
@end

@implementation NewTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"New Activity";
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize mSize = [[UIScreen mainScreen] bounds].size;
    self.mScreenW = mSize.width;
    self.mScreenH = mSize.height;
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake(10, 80, 40, 40);
    [self.searchButton setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:188.0/255.0 blue:164.0/255.0 alpha:1.0]];
    [self.searchButton setImage:[UIImage imageNamed:@"icon_my_setup_search"] forState:UIControlStateNormal];
    [self.view addSubview:self.searchButton];
    
    self.searchBar = [[UITextField alloc] initWithFrame:CGRectMake(self.searchButton.frame.origin.x+40, self.searchButton.frame.origin.y, self.view.frame.size.width-58, 40)];
    [self.view addSubview:self.searchBar];
    [self.searchBar setBackgroundColor:[UIColor lightGrayColor]];
    [self.searchBar setText:@"  Input the name activity"];
    [self.searchBar becomeFirstResponder];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, self.mScreenW, self.mScreenH-150) style:UITableViewStylePlain];
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
        int count = 3;
        if (indexPath.row == 2) {
            count = 1;
        }
        for (int i=0; i<count; i++) {
            int width = (self.mScreenW-30)/3;
            UIImageButton *view = [[UIImageButton alloc] initWithFrame:CGRectMake(0, 0, width, width)];
            view.row = (int)(indexPath.row*3+i);
            [view addTarget:self action:@selector(imageItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [view setTag:view.row];
            view.center = CGPointMake((1 + i) * 8 + (self.mScreenW-30)/3 *( 0.5 + i) , 5+(self.mScreenH-260)/3 * 0.5);
            [view setButtonImage:(int)view.row];
            [cell addSubview:view];
            
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.mScreenH-280)/3;
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
        
    }else {
        
    }
}

@end
