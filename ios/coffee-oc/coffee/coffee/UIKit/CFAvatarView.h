//
//  CFAvatarView.h
//  coffee
//
//  Created by achiel on 14/11/26.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFAvatarView : UIView

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

- (void)refreshSize;


- (void)setImageWithURL:(NSURL *)url;

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage;

- (void)setImageWithURL:(NSURL *)url
        placeholderText:(NSString *)placeholderText
     placeholderBgColor:(UIColor *)placeholderBgColor;

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
             badgeImage:(UIImage *)badgeImage;

- (void)setImageWithURL:(NSURL *)url
        placeholderText:(NSString *)placeholderText
     placeholderBgColor:(UIColor *)placeholderBgColor
             badgeImage:(UIImage *)badgeImage;




@end
