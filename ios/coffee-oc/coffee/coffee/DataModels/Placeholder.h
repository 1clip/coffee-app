//
//  Location.h
//  coffee
//
//  Created by wang xuan on 14-12-3.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"
#import "BMKPoiSearchType.h"

@protocol Location;
@interface Location:NSObject

@property (strong, nonatomic) NSString<Optional>* title;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (retain, nonatomic) NSString* address;

@property (strong, nonatomic) NSString<Optional>* imageName;

@end

@interface SearchLocation : IdObject

@property (strong, nonatomic) NSMutableArray<Location, Optional>* locations;

@end

@protocol PlaceholderUser;
@interface PlaceholderUser:NSObject

@property (retain, nonatomic) NSString* userName;

@property (retain, nonatomic) NSString* avatorImage;

@end
