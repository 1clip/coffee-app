//
//  ActivityDetailViewController.m
//  JoinMeDemo
//
//  Created by lixin on 14/11/15.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "UITableGridViewCell.h"
#import "ActivityReplyView.h"



@interface ActivityDetailViewController ()
@property(nonatomic,strong)UIView *ActivityDetailView;
@property(nonatomic,strong)UIView *ActivityActionView;
@property(nonatomic,strong)UIView *ActivityMemberView;
@property(nonatomic,strong)UIView *ActivityBottomView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray* memberListData;
@property(nonatomic,assign)int mScreenW;
@property(nonatomic,assign)int mScreenH;
@property(nonatomic,assign)int mMemberIndex;
@property(nonatomic,strong)NSString* mTitle;
@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.mTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize mSize = [[UIScreen mainScreen] bounds].size;
    self.mScreenW = mSize.width;
    self.mScreenH = mSize.height;
    self.mMemberIndex = 0;
    self.memberListData = [[NSMutableArray alloc] init];
    [self.memberListData addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dinner-22"]]];
    [self.memberListData addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KTV-22"]]];
    [self.memberListData addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shower-22"]]];
    [self.memberListData addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopping-22"]]];
    
    [self initActivityDetailView];
    [self initActivityActionView];
    [self initActivityMemberView];
    [self initTableView];
    [self initActivityBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDetailTitle:(NSString*)title{
    self.mTitle = [NSString stringWithString:title];
}

- (void) initActivityDetailView{
    self.ActivityDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 150)];
    [self.ActivityDetailView setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:206.0/255.0 blue:180.0/255.0 alpha:1.0]];
    UIImage* img = [UIImage imageNamed:@"dinner-22"];
    
    
    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
    int x1 = self.mScreenW / 2 - 35;
    
    imgView.frame = CGRectMake(x1, 10, 70, 70);
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 35;
    [imgView setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:185.0/255.0 blue:162.0/255.0 alpha:1.0]];
    [self.ActivityDetailView addSubview:imgView];
    
    UIImageView *detailView = [[UIImageView alloc] initWithFrame:CGRectMake(75, imgView.frame.origin.y
                                                                           + imgView.frame.size.height + 10,
                                                                           self.mScreenW - 150,
                                                                            50)];
    detailView.layer.masksToBounds = YES;
    detailView.layer.cornerRadius = 25;
    [detailView setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:185.0/255.0 blue:162.0/255.0 alpha:1.0]];
    
    
    UIImage* photo = [UIImage imageNamed:@"xiaowu.sample"];
    UIImageView* imgPhotoView = [[UIImageView alloc] initWithImage:photo];
    imgPhotoView.frame = CGRectMake(0, 0, 50, 50);
    imgPhotoView.layer.masksToBounds = YES;
    imgPhotoView.layer.cornerRadius = 25;
    [detailView addSubview:imgPhotoView];
    
    
    [self.ActivityDetailView addSubview:detailView];
    
    
    UILabel* TimeStr = [[UILabel alloc] initWithFrame:CGRectMake(imgPhotoView.frame.size.width+10, imgPhotoView.frame.origin.y - 10, detailView.frame.size.width - imgPhotoView.frame.size.width * 2, detailView.frame.size.height + 10)];
    TimeStr.text = @"Time: 7:00pm Today \n Restaurant: Yun Tun";
    TimeStr.textColor = [UIColor whiteColor];
    TimeStr.backgroundColor = [UIColor clearColor];
    TimeStr.font = [UIFont systemFontOfSize:12];
    TimeStr.textAlignment = NSTextAlignmentCenter;
    TimeStr.numberOfLines = 0;
    [detailView addSubview:TimeStr];
    
    UIImage* lbs = [UIImage imageNamed:@"icon_lbs_28_n"];
    UIImageView* imgLBSView = [[UIImageView alloc] initWithImage:lbs];
    imgLBSView.frame = CGRectMake(TimeStr.frame.size.width + TimeStr.frame.origin.x, TimeStr.frame.origin.y+20, lbs.size.width + 8, lbs.size.height + 10);
    [detailView addSubview:imgLBSView];
    
    [self.ActivityDetailView addSubview:detailView];
    
    [self.view addSubview:self.ActivityDetailView];
}

- (void) initActivityActionView{
    self.ActivityActionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.ActivityDetailView.frame.origin.y+self.ActivityDetailView.frame.size.height, self.view.frame.size.width, 80)];
    [self.ActivityActionView setBackgroundColor:[UIColor whiteColor]];
    
    UIButton* okButt = [UIButton buttonWithType:UIButtonTypeCustom];
    okButt.frame = CGRectMake(90, 20, 70, 50);
    [okButt setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:188.0/255.0 blue:164.0/255.0 alpha:1.0]];
    [okButt setTitle:@"OK" forState:UIControlStateNormal];
    [okButt setTintColor:[UIColor whiteColor]];
    [okButt addTarget:self action:@selector(OKItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityActionView addSubview:okButt];
    
    UIButton* cancelButt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButt.frame = CGRectMake(180, 20, 70, 50);
    [cancelButt setBackgroundColor:[UIColor redColor]];
    [cancelButt setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButt setTintColor:[UIColor whiteColor]];
    [cancelButt addTarget:self action:@selector(CancelItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityActionView addSubview:cancelButt];

    [self.view addSubview:self.ActivityActionView];
}

-(void)OKItemClick:(UIButton *)button{
    
}

-(void)CancelItemClick:(UIButton *)button{
    
}

- (void) initActivityMemberView{
    self.ActivityMemberView = [[UIView alloc] initWithFrame:CGRectMake(0, self.ActivityActionView.frame.origin.y+self.ActivityActionView.frame.size.height, self.view.frame.size.width, 100)];
    [self.ActivityMemberView setBackgroundColor:[UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1]];
    
    // 创建了一个HorizontalScroller类的实例，设置它的背景色，委托，增加它到主视图，然后加载所有子视图去显示专辑数据。
    HorizontalScroller* scroller = [[HorizontalScroller alloc] initWithFrame:self.ActivityMemberView.frame];
    
    scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    scroller.delegate = self;
    [self.ActivityMemberView addSubview:scroller];
    [self.view addSubview:scroller];
    [scroller reload];
}

- (void) initActivityBottomView{
    self.ActivityBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    [self.ActivityBottomView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton* leftButt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButt.frame = CGRectMake(10, 10, 20, 20);
    [leftButt setBackgroundColor:[UIColor brownColor]];
    [leftButt setTitle:@"" forState:UIControlStateNormal];
    [leftButt setTintColor:[UIColor whiteColor]];
    [leftButt addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityBottomView addSubview:leftButt];
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(35, 10, self.view.frame.size.width-70, 22)];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [self.ActivityBottomView addSubview:textField];
    
    UIButton* rightButt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButt.frame = CGRectMake(self.view.frame.size.width - 28, 10, 20, 20);
    [rightButt setBackgroundColor:[UIColor brownColor]];
    [rightButt setTitle:@"" forState:UIControlStateNormal];
    [rightButt setTintColor:[UIColor whiteColor]];
    [rightButt addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ActivityBottomView addSubview:rightButt];
    
    
    [self.view addSubview:self.ActivityBottomView];
}

-(void)leftItemClick:(UIButton *)button{
    
}

-(void)rightItemClick:(UIButton *)button{
    
}

- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.ActivityMemberView.frame.origin.y+self.ActivityMemberView.frame.size.height, self.mScreenW, 200) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];

}

#pragma mark UITable datasource and delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ActivityReplyView *view = [[ActivityReplyView alloc] initWithFrame:CGRectMake(0, 0, self.mScreenW, 40)];
        [cell addSubview:view];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    NSLog(@"selectd row =%ld",indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HorizontalScroller Delegate
// 返回滚动视图所有子视图数量的协议方法
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller*)scroller
{
    return [self.memberListData count];
}

// 指定索引位置的视图

- (UIView *)horizontalScroller:(HorizontalScroller*)scroller viewAtIndex:(int)index
{
    UIImageView *img = [self.memberListData objectAtIndex:index];
    img.frame = CGRectMake(0, 0, 100, 100);
    return img;
}


- (void)horizontalScroller:(HorizontalScroller*)scroller clickedViewAtIndex:(int)index
{
    self.mMemberIndex = index;
}

// HorizontalScroller的第一个视图设置为了currentAlbumIndex指定的视图。这使得app在下次使用的时候还保留了上次使用的状态。
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller
{
    return self.mMemberIndex;
}


@end
