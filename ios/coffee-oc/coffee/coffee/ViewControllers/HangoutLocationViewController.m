//
//  HangoutLocationViewController.m
//  coffee
//
//  Created by achiel on 14/12/2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutLocationViewController.h"

@interface HangoutLocationViewController ()

@end


@implementation HangoutLocationViewController

@synthesize searchBar;
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.camera = camera;
    mapView.myLocationEnabled = YES;
    //self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
    // Do any additional setup after loading the view.
    
    [searchBar setText:@"hello"];
    [searchBar setTintColor:[UIColor redColor]];
    [searchBar setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0  blue:242.0/255.0  alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
