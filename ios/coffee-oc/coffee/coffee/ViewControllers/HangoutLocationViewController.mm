//
//  HangoutLocationViewController.m
//  coffee
//
//  Created by achiel on 14/12/2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutLocationViewController.h"
#import "Placeholder.h"

@interface HangoutLocationViewController ()

@end


@implementation HangoutLocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchLocation = [[SearchLocation alloc] init];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    _poiSearch = [[BMKPoiSearch alloc] init];
    
    _mapView.isSelectedAnnotationViewFront = YES;
    
    [_mapView setZoomLevel:13];
    
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.view layoutIfNeeded];
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint* constraint in self.view.constraints) {
        if (constraint.firstItem == self.mapView && constraint.secondItem == self.view
            && constraint.firstAttribute == NSLayoutAttributeHeight){
            heightConstraint = constraint;
        }
    }
    
    //heightConstraint.constant = self..frame.size.height;
    //[self.view setNeedsLayout];

    
    [_mapView viewWillAppear];
    CLLocationCoordinate2D corrdinate;
    corrdinate.latitude = 31.24;
    corrdinate.longitude = 121.43;
    _mapView.centerCoordinate = corrdinate;
    _mapView.delegate = self;
    _poiSearch.delegate = self;

}

-(void)viewDidAppear:(BOOL)animated
{
    _mapView.delegate = self;
    _poiSearch.delegate = self;

}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _poiSearch.delegate = nil;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Location *item = (Location *)searchLocation.locations[indexPath.row];
    _mapView.centerCoordinate = item.coordinate;
    [_mapView setZoomLevel:15];
}

//Baidu map view

#pragma mark -
#pragma mark implement BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    [searchLocation.locations removeAllObjects];
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            Location *location = [[Location alloc] init];
            location.title = item.title;
            location.coordinate = item.coordinate;
            location.address = poi.address;
            [searchLocation.locations addObject:location];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
                [_mapView setZoomLevel:13];
            }
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

/*搜索按钮*/
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];

}

/*键盘搜索按钮*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self doSearch:self.searchBar];
}

/*搜索*/
- (void)doSearch:(UISearchBar *)searchBar{
    NSString *keyword = self.searchBar.text;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"上海";
    citySearchOption.keyword = keyword;
    BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

- (void)lostFocus: (UITapGestureRecognizer *)sender
{
    [self.searchBar resignFirstResponder];
}

-(void) backButtonClick: (UIButton *) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) okButtonClick: (UIButton *) sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
