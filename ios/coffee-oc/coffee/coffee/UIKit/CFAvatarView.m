//
//  CFAvatarView.m
//  coffee
//
//  Created by achiel on 14/11/26.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "CFAvatarView.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#pragma mark - Caching
@interface CFImageCache : NSCache <AFImageCache>
@end

#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation CFImageCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
    return [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
    }
}

@end


#pragma mark - Avatar View

@interface CFAvatarView ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImage *badgeImage;

@property (nonatomic, strong, readonly) CALayer *contentLayer;
@property (nonatomic, strong, readonly) CALayer *badgeLayer;

- (UIImage *)generateTextImage:(NSString *)text
                   withBgColor:(UIColor *)color;

#pragma mark - Networking
@property (nonatomic, strong) AFHTTPRequestOperation *af_imageRequestOperation;

- (void)cancelImageRequestOperation;

+ (id <AFImageCache>)sharedImageCache;

@end

@implementation CFAvatarView

@synthesize
contentLayer = _contentLayer,
badgeLayer = _badgeLayer;

#pragma mark - Image from Network

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url
         placeholderImage:self.placeholderImage];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    [self setImageWithURL:url
         placeholderImage:placeholderImage
               badgeImage:self.badgeImage];
}

- (void)setImageWithURL:(NSURL *)url
        placeholderText:(NSString *)placeholderText
     placeholderBgColor:(UIColor *)placeholderBgColor
{
    UIImage *placeholderImage = [self generateTextImage:placeholderText withBgColor:placeholderBgColor];
    [self setImageWithURL:url
         placeholderImage:placeholderImage];
    
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
             badgeImage:(UIImage *)badgeImage
{
    self.badgeImage = badgeImage;
    
    NSMutableURLRequest *urlRequest = nil;
    if (url) {
        urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    }
    
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage =
    url == nil
    ? placeholderImage
    : [[[self class] sharedImageCache] cachedImageForRequest:urlRequest];
    
    if (cachedImage) {
        self.image = cachedImage;
        self.af_imageRequestOperation = nil;
        
    } else if (urlRequest) {
        if (placeholderImage) {
            self.image = placeholderImage;
        }
        
        __weak __typeof(self)weakSelf = self;
        self.af_imageRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        self.af_imageRequestOperation.responseSerializer = self.imageResponseSerializer;
        [self.af_imageRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[strongSelf.af_imageRequestOperation.request URL]]) {
                if (responseObject) {
                    strongSelf.image = responseObject;
                }
                
                if (operation == strongSelf.af_imageRequestOperation){
                    strongSelf.af_imageRequestOperation = nil;
                }
            }
            
            [[[strongSelf class] sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[strongSelf.af_imageRequestOperation.request URL]]) {
                if (operation == strongSelf.af_imageRequestOperation){
                    strongSelf.af_imageRequestOperation = nil;
                }
            }
        }];
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

- (void)setImageWithURL:(NSURL *)url
        placeholderText:(NSString *)placeholderText
     placeholderBgColor:(UIColor *)placeholderBgColor
             badgeImage:(UIImage *)badgeImage
{
    UIImage *placeholderImage = [self generateTextImage:placeholderText withBgColor:placeholderBgColor];
    [self setImageWithURL:url
         placeholderImage:placeholderImage
               badgeImage:badgeImage];
}

#pragma mark - Properties
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.contentLayer.borderColor = _borderColor.CGColor;
    
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.contentLayer.borderWidth = _borderWidth;
    
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (_image) {
        self.contentLayer.hidden = NO;
        self.contentLayer.contents = (id)_image.CGImage;
    } else {
        self.contentLayer.hidden = YES;
    }
    
    [self setNeedsDisplay];
}

- (void)setBadgeImage:(UIImage *)badgeImage {
    if (_badgeImage != badgeImage) {
        _badgeImage = badgeImage;
        if (_badgeImage) {
            self.badgeLayer.hidden = NO;
            self.badgeLayer.contents = (id)_badgeImage.CGImage;
        } else {
            self.badgeLayer.hidden = YES;
        }
        
        [self setNeedsDisplay];
    }
}

#pragma mark - Private Member Getters

- (CALayer*)contentLayer {
    if (!_contentLayer) {
        // borrow content layer initialization for root layer
        //self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        
        _contentLayer = [CALayer layer];
        CGFloat visibleWidth = MIN(self.frame.size.width, self.frame.size.height);
        _contentLayer.frame = CGRectMake(0, 0, visibleWidth, visibleWidth);
        _contentLayer.cornerRadius = visibleWidth * 0.5;
        _contentLayer.borderColor = self.borderColor.CGColor;
        _contentLayer.borderWidth = self.borderWidth;
        _contentLayer.masksToBounds = YES;
        [self.layer addSublayer:_contentLayer];
    }
    return _contentLayer;
}

- (CALayer*)badgeLayer {
    if (!_badgeLayer) {
        // force to create content layer first;
        [self contentLayer];
        
        CGFloat visibleWidth = MIN(self.frame.size.width, self.frame.size.height);
        CGFloat badgeWidth = visibleWidth / 4;
        
        _badgeLayer = [CALayer layer];
        _badgeLayer.frame = CGRectMake(visibleWidth - badgeWidth
                                       , visibleWidth - badgeWidth
                                       , badgeWidth
                                       , badgeWidth);
        _badgeLayer.cornerRadius = badgeWidth * 0.5;
        _badgeLayer.masksToBounds = YES;
        
        [self.layer addSublayer:_badgeLayer];
    }
    return _badgeLayer;
}

#pragma mark - Helpers

- (UIImage *)generateTextImage:(NSString *)text
                   withBgColor:(UIColor *)color
{
    // TODO: draw image with text and bg color
    return nil;
}

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

- (id <AFURLResponseSerialization>)imageResponseSerializer {
    static id <AFURLResponseSerialization> _af_defaultImageResponseSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_defaultImageResponseSerializer = [AFImageResponseSerializer serializer];
    });
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return _af_defaultImageResponseSerializer;
#pragma clang diagnostic pop
}

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _af_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });
    
    return _af_sharedImageRequestOperationQueue;
}

+ (id <AFImageCache>)sharedImageCache {
    static CFImageCache *_af_defaultImageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_defaultImageCache = [[CFImageCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [_af_defaultImageCache removeAllObjects];
        }];
    });
    
    return _af_defaultImageCache;
}

@end
