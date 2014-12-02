//
//  HangoutLocationViewController.h
//  coffee
//
//  Created by achiel on 14/12/2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>
@interface HangoutLocationViewController : UIViewController

@property(nonatomic, strong) IBOutlet GMSMapView *mapView;
@property(nonatomic, strong) IBOutlet UISearchBar *searchBar;


@end
