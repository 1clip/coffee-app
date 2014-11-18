//
//  Header.h
//  JoinMeDemo
//
//  Created by lixin on 14/11/14.
//  Copyright (c) 2014年 lixin. All rights reserved.
//

#ifndef JoinMeDemo_Header_h
#define JoinMeDemo_Header_h

#import "UIDevice-Hardware.h"
#import "UIColor+ALExtension.h"

#define UIScreenWidth  [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIScreenScale  (NSInteger)[UIScreen mainScreen].scale

#define iOS7NavHeight (isRunningOnIOS7?64:0)

#define isRunningOnIOS7           [[UIDevice currentDevice] isIOS7]
#define isRunningOnIOS8           [[UIDevice currentDevice] isIOS8]


#define UIColorFromRGBC(rgbValue)   [UIColor colorWithRed:(float)rgbValue/255 green:(float)rgbValue/255 blue:(float)rgbValue/255 alpha:1]
#define PDColorBarTitleColorDefault [UIColor colorWithRGBHex:0x262626]
#define PDColorBarBgColorDefault    [UIColor colorWithRGBHex:0xffffff]
#define PDColorMale                 [UIColor colorWithRGBHex:0x47a2ed]
#define PDColorFemale               [UIColor colorWithRGBHex:0xff8ca1]
#define PDColorStudent              [UIColor colorWithRGBHex:0x61c200]
#define PDColorViewDefaultBGColor   [UIColor colorWithRGBHex:0xf0f1f2]
#define PDColorDefaultPurple        [UIColor colorWithRGBHex:0x62388c] //[UIColor colorWithRGBHex:0x885ba6]
#define PDColorSeparator            [UIColor colorWithRGBHex:0xd9d9d9]

#endif
