//
//  YFNativeAdData.h
//  FineSDK
//
//  Created by leonard.li on 2017/9/20.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface YFNativeAdData : NSObject 

- (instancetype)initWithAttribute:(id)data;

@property (copy, nonatomic) NSString *appId;
@property (copy, nonatomic) NSString *appName;
@property (copy, nonatomic) NSString *appTitle;
@property (copy, nonatomic) NSString *appSDesc;
@property (copy, nonatomic) NSString *appLDesc;
@property (copy, nonatomic) NSString *appIcon;
@property (copy, nonatomic) NSString *appImg;
@property (copy, nonatomic) NSString *adType;

-(void)loadIconAsyncWithBlock:(nullable void (^)(UIImage * __nullable image))block;
-(void)loadImageAsyncWithBlock:(nullable void (^)(UIImage * __nullable image))block;
-(void)launchToClickTarget;

@end
