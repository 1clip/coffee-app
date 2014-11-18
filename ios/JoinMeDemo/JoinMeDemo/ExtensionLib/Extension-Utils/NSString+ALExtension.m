//
//  NSString+Category.m
//  Pandora
//
//  Created by Albert Lee on 12/25/13.
//  Copyright (c) 2013 Albert Lee. All rights reserved.
//

#import "NSString+ALExtension.h"


@implementation NSString (ALExtension)
+ (NSString*)currentTimeString{
    return nil;
}

- (NSString *)trimWhitespace
{
  NSMutableString *str = [self mutableCopy];
  CFStringTrimWhitespace((CFMutableStringRef)str);
  return str;
}
#pragma mark String MD5 Encoding & Decoding
+ (NSString *)stringByMD5Encoding:(NSString*)inputString{
    return nil;
}
#pragma mark URL String Encoding & Decoding
+ (NSString *)stringByDecodingURLFormat:(NSString*)inputString
{
  CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                        (__bridge CFStringRef)inputString,
                                                                                        CFSTR(""),
                                                                                        kCFStringEncodingUTF8);
  if (decodedCFString == nil) {
    return inputString;
  }
  // We need to replace "+" with " " because the CF method above doesn't do it
  NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
  return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}
+ (NSString*)stringByEncodingURLFormat:(NSString*)inputString
{
  if ([inputString length]==0) {
    return @"";
  }
  NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                           (CFStringRef)inputString,
                                                                                           NULL,
                                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                           kCFStringEncodingUTF8));
  return result;
}

- (NSNumber *)numberValue{
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  return [f numberFromString:self];
}

- (NSData *)UTF8Data
{
  return [self dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark Cache Path Direction
+ (NSString *)pathByCacheDirection:(NSString*)customCacheDirectionName{
  NSArray *cacheDirectoryArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *pathString = [cacheDirectoryArray objectAtIndex:0];
  NSString *customCacheDirection = [pathString stringByAppendingPathComponent:customCacheDirectionName];
  if (![[NSFileManager defaultManager] fileExistsAtPath:customCacheDirection])
  {
    [[NSFileManager defaultManager] createDirectoryAtPath:customCacheDirection
                              withIntermediateDirectories:NO
                                               attributes:nil
                                                    error:nil];
  }
  
  return customCacheDirection;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
  __block BOOL returnValue = NO;
  [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
   ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
     
     const unichar hs = [substring characterAtIndex:0];
     // surrogate pair
     if (0xd800 <= hs && hs <= 0xdbff) {
       if (substring.length > 1) {
         const unichar ls = [substring characterAtIndex:1];
         const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
         if (0x1d000 <= uc && uc <= 0x1f77f) {
           returnValue = YES;
         }
       }
     } else if (substring.length > 1) {
       const unichar ls = [substring characterAtIndex:1];
       if (ls == 0x20e3) {
         returnValue = YES;
       }
       
     } else {
       // non surrogate
       if (0x2100 <= hs && hs <= 0x27ff) {
         returnValue = YES;
       } else if (0x2B05 <= hs && hs <= 0x2b07) {
         returnValue = YES;
       } else if (0x2934 <= hs && hs <= 0x2935) {
         returnValue = YES;
       } else if (0x3297 <= hs && hs <= 0x3299) {
         returnValue = YES;
       } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
         returnValue = YES;
       }
     }
   }];
  
  return returnValue;
}

+ (NSString *)timeCountStringByTime:(NSTimeInterval)time{
  int h = time/3600;
  int m = (time-h*3600)/60;
  int s = time-h*3600-m*60;
  
  NSString *hStr = h<10?[NSString stringWithFormat:@"0%d",h]:[NSString stringWithFormat:@"%d",h];
  NSString *mStr = m<10?[NSString stringWithFormat:@"0%d",m]:[NSString stringWithFormat:@"%d",m];
  NSString *sStr = s<10?[NSString stringWithFormat:@"0%d",s]:[NSString stringWithFormat:@"%d",s];
  
  NSString *callingTime = @"";
  if (h>0) {
    callingTime = [NSString stringWithFormat:@"%@:%@:%@",hStr,mStr,sStr];
  }
  else{
    callingTime = [NSString stringWithFormat:@"%@:%@",mStr,sStr];
  }
  return callingTime;
}

#pragma mark Traditional Chinese Character
- (BOOL)containsTraditionalChinese{
//  for (NSInteger i=0;i<[self length];i++) {
//
//  }
  
  return NO;
}


#pragma mark Base64 Related

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    return nil;
}

- (NSString *)base64EncodedString
{
    return nil;
}

- (NSString *)base64DecodedString
{
  return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
    return nil;
}

@end
