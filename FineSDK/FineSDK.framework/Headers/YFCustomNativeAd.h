//
//  YFCustomNativeAd.h
//  FineSDK
//
//  Created by leonard.li on 2017/11/16.
//  Copyright © 2017年 yifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YFCustomNativeAdDelegate;

@interface YFCustomNativeAd : NSObject

- (instancetype)initWithAttribute:(id)data withParams:(NSDictionary *)params;

/**
 * 广告标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 广告按钮文本
 */
@property (nonatomic, copy) NSString *callToAction;

/**
 * 广告描述
 */
@property (nonatomic, copy) NSString *body;

/**
 * 图标地址
 */
@property (nonatomic, copy) NSURL *iconURL;

/**
 * 大图地址
 */
@property (nonatomic, copy) NSURL *imageURL;

/**
 * adChoice标记链接，针对facebook
 */
@property (nonatomic, copy) NSURL *adChoicesLinkURL;

/**
 *加载广告的回调
 */
@property (nonatomic, weak, nullable) id<YFCustomNativeAdDelegate> delegate;

/**
 注册整个view里面的组件都是可以点击跳转广告的,注意,该api会移除view的tap手势识别
 
 @param view 广告视图
 @param viewController 不能为空,用来给SDK present viewcontroller
 */
- (void)registerViewForInteraction:(nonnull UIView *)view
                withViewController:(nonnull UIViewController *)viewController;

/**
 *释放点击跳转广告的视图
 */
- (void)unRegisterView;

- (void)loadIconAsyncWithBlock:(nullable void (^)(UIImage * __nullable image))block;
- (void)loadImageAsyncWithBlock:(nullable void (^)(UIImage * __nullable image))block;

@end

@protocol YFCustomNativeAdDelegate <NSObject>

@optional

- (void)adClick;

@end


