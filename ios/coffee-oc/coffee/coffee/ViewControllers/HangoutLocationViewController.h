//
//  HangoutLocationViewController.h
//  coffee
//
//  Created by achiel on 14/12/2.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTableCell.h"
#import "BMapKit.h"
#import "BMKPoiSearch.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Location.h"
@interface HangoutLocationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, BMKMapViewDelegate,BMKPoiSearchDelegate, UISearchBarDelegate>
{
    BMKPoiSearch* _poiSearch;
    SearchLocation *searchLocation;
}

@property(nonatomic, strong) IBOutlet BMKMapView *mapView;
@property(nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong) IBOutlet UITableView* tableView;
@end
