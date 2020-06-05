//
//  ZYBaseViewController.h
//  GChat
//
//  Created by zhangmeng on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  该类的作用是提供项目中ViewController的基类，在该基类中实现的功能有：
//  1、导航栏导航按钮和右侧按钮的创建以及点击事件
//  2、自定义导航条的背景色和标题
//  3、ViewController的背景色
//  4、键盘的弹起和回收监听事件

#import <UIKit/UIKit.h>

#define MoreNavLeftTag  10000
#define MoreNavRightTag 20000

NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseViewController : UIViewController <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

#pragma mark - 基类属性
//自定义弹窗的高度
@property (assign, nonatomic) CGFloat presentHeight;
//导航栏下方提示框
@property (strong, nonatomic) UIView *NavHintView;
//导航左按钮图片名
@property (strong, nonatomic) NSString *NavLeftImage;
//导航右按钮图片名
@property (strong, nonatomic) NSString *NavRightImage;
//导航左侧多按钮图片
@property (strong, nonatomic) NSArray *NavLeftImageArray;
//导航右侧多按钮图片
@property (strong, nonatomic) NSArray *NavRightImageArray;
//导航标题
@property (strong, nonatomic) NSString *titleStr;
//导航titleView的图片
@property (strong, nonatomic) NSString *titleImage;
//导航title颜色
@property (strong, nonatomic) UIColor *titleColor;
//导航栏颜色
@property (strong, nonatomic) UIColor *NavBgColor;
//导航下面线的颜色
@property (strong, nonatomic) UIColor *NavShadowColor;
//是否开启侧滑返回功能（默认为YES）
@property (assign, nonatomic) BOOL isSlidingReturn;
//左侧导航条按钮
@property (strong, nonatomic) UIBarButtonItem *leftItem;
//右侧导航条按钮
@property (strong, nonatomic) UIBarButtonItem *rightItem;

#pragma mark - 键盘回调事件
/// 键盘将要弹起的回调方法
/// @param notif 键盘弹起的通知
- (void)keyboardWillShow:(NSNotification *)notif;

/// 键盘将要隐藏的回调方法
/// @param notif 键盘隐藏的通知
- (void)keyboardWillHide:(NSNotification *)notif;

/// 键盘的frame发生改变的回调方法
/// @param notif 键盘frame改变的通知
- (void)keyboardWillChangeFrame:(NSNotification *)notif;

#pragma mark - 基类方法
/// 设置导航条Title颜色和字体
/// @param titleColor 颜色
/// @param font 字体
- (void)setTitleColor:(UIColor *)titleColor font:(UIFont *)font;

/// 导航左侧按钮点击方法
/// @param sender 响应的按钮
- (void)tapNavLeftBtn:(UIButton *)sender;

/// 导航右侧按钮点击方法
/// @param sender 响应的按钮
- (void)tapNavRightBtn:(UIButton *)sender;

/// 导航多个左侧按钮点击方法（tag值越小，越靠前, tag值从10000开始）
/// @param sender 响应的按钮
- (void)tapMoreNavLeftBtn:(UIButton *)sender;

/// 导航多个右侧按钮点击方法(tag值越小，越靠前, tag值从20000开始)
/// @param sender  响应的按钮
- (void)tapMoreNavRightBtn:(UIButton *)sender;

/// 重载视图
- (void)reloadView;

/// 加载弹窗视图
/// @param bottomVC 要弹出视图viewController
/// @param completion 视图弹出后的回调
//- (void)presentBottom:(ZYBaseViewController *)bottomVC completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
