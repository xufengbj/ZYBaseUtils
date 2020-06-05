//
//  ZYBaseViewController.m
//  GChat
//
//  Created by zhangmeng on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYBaseViewController.h"

@interface ZYBaseViewController ()

@end

@implementation ZYBaseViewController

#pragma mark - 默认旋转方向

/// 是否支持旋转屏幕
- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - 默认屏幕支持的方向

/// 屏幕默认支持的方向，UIInterfaceOrientationMaskPortrait：竖直方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 默认状态栏

/// 默认状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/// 不隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

/// 状态栏的隐藏样式，默认无
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

#pragma mark - ViewController生命周期回调方法

/// 视图将要出现的回调方法
/// @param animated 视图出现时是否有动画效果
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 去掉返回按钮显示的文字
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        // 支持右滑返回上一级的代理
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavShadowColor:[UIColor clearColor]];
    // 监听键盘的弹出和退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/// 视图将要消失的回调方法
/// @param animated 视图消失时是否有动画效果
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setNavBgColor:[UIColor whiteColor]];
    [self setNavShadowColor:[UIColor clearColor]];
    // 移除监听键盘的弹出和退出
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.view endEditing:YES];  // 取消键盘编辑状态
}

/// 系统视图加载完成回调
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 手势开始识别

/// 开始手势识别的回调，
/// @param gestureRecognize 要识别的手势，返回YES表示继续进行手势追踪，返回NO表示手势识别结束，并切换到识别失败状态
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognize {
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    else {
        return YES;
    }
}


#pragma mark - 键盘回调事件

/// 键盘将要弹起的回调方法
/// @param notif 键盘弹起的通知
- (void)keyboardWillShow:(NSNotification *)notif{
    
}

/// 键盘将要隐藏的回调方法
/// @param notif 键盘隐藏的通知
- (void)keyboardWillHide:(NSNotification *)notif{
    
}

/// 键盘的frame发生改变的回调方法
/// @param notif 键盘frame改变的通知
- (void)keyboardWillChangeFrame:(NSNotification *)notif{
    
}

/// 重载视图
- (void)reloadView{
    
}

#pragma mark - 设置导航条Title Label

/// 设置标题的内容、字体和颜色
/// @param titleStr 标题内容
/// @param font 标题字体
/// @param color 标题颜色
- (void)setTitleStr:(NSString *)titleStr font:(UIFont *)font color:(UIColor *)color {
    _titleStr = titleStr;
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 30);
    titleLab.text = titleStr;
    titleLab.font = font;
    titleLab.textColor = color;
    titleLab.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.titleView = titleLab;
}

#pragma mark - 设置导航条Title Button

/// 设置标题的背景图片
/// @param titleImage 背景图片路径
- (void)setTitleImage:(NSString *)titleImage {
    _titleImage = titleImage;
    UIButton *titleBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 41.0f, 21.0f)];
    // 高亮的时候不要自动调整图标
    titleBut.adjustsImageWhenHighlighted = NO;
    titleBut.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleBut.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleBut.imageView.contentMode = UIViewContentModeCenter;
    [titleBut setImage:[UIImage imageNamed:titleImage] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleBut;
}
#pragma mark - 设置导航条Title颜色

/// 设置导航条Title颜色和字体
/// @param titleColor 颜色
/// @param font 字体
- (void)setTitleColor:(UIColor *)titleColor font:(UIFont *)font {
    if (!titleColor) {
        return;
    }
    _titleColor = titleColor;
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = titleColor;
    textAttrs[NSFontAttributeName] = font;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
}

#pragma mark - 设置导航条背景颜色

/// 设置导航条的背景颜色
/// @param NavBgColor 导航条背景色
- (void)setNavBgColor:(UIColor *)NavBgColor {
    _NavBgColor = NavBgColor;
    // 设置导航栏背景
    UIImage *navImage = [self imageFromColor:NavBgColor rectSize:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ? 44.0f : 64.0f)];
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - 设置导航条Shadow颜色

/// 设置导航条的阴影颜色
/// @param NavShadowColor 导航条阴影颜色
- (void)setNavShadowColor:(UIColor *)NavShadowColor {
    _NavShadowColor = NavShadowColor;
    // 设置导航条Shadow颜色
    UIImage *navImage = [self imageFromColor:[UIColor clearColor] rectSize:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 0.5)];
    self.navigationController.navigationBar.shadowImage = navImage;
}

#pragma mark - 设置导航按钮

/// 设置左边导航按钮的背景图片
/// @param NavLeftImage 左边导航按钮图片
- (void)setNavLeftImage:(NSString *)NavLeftImage {
    _NavLeftImage = NavLeftImage;
    _leftItem = [self itemWithIcon:NavLeftImage highIcon:nil target:self action:@selector(tapNavLeftBtn:)];
    self.navigationItem.leftBarButtonItem = _leftItem;
}

/// 设置右边导航按钮的背景图片
/// @param NavRightImage 右边导航按钮图片
- (void)setNavRightImage:(NSString *)NavRightImage {
    _NavRightImage = NavRightImage;
    _rightItem = [self itemWithIcon:NavRightImage highIcon:nil target:self action:@selector(tapNavRightBtn:)];
    self.navigationItem.rightBarButtonItem = _rightItem;
}

#pragma mark - 设置多个导航按钮

/// 设置多个左侧按钮
/// @param NavLeftImageArray 左侧按钮数组
- (void)setNavLeftImageArray:(NSArray *)NavLeftImageArray {
    _NavLeftImageArray = NavLeftImageArray;
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:1];
    
    for (int i = 0; i < NavLeftImageArray.count; i++) {
        NSString *imageName = NavLeftImageArray[i];
        NSInteger itemTag = MoreNavLeftTag + i;
        UIBarButtonItem *item = [self moreItemWithIcon:imageName highIcon:nil target:self action:@selector(tapMoreNavLeftBtn:) tag:itemTag];
        item.tag = itemTag;
        [itemArray addObject:item];
    }
    self.navigationItem.leftBarButtonItems = itemArray;
}

/// 设置多个右侧按钮
/// @param NavRightImageArray 右侧按钮数组
- (void)setNavRightImageArray:(NSArray *)NavRightImageArray {
    _NavRightImageArray = NavRightImageArray;
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:1];
    
    //NSEnumerationReverse 倒序遍历
    [NavRightImageArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imageName = NavRightImageArray[idx];
        NSInteger itemTag = MoreNavRightTag + NavRightImageArray.count - (NavRightImageArray.count - idx);
        UIBarButtonItem *item = [self moreItemWithIcon:imageName highIcon:nil target:self action:@selector(tapMoreNavRightBtn:) tag:itemTag];
        item.tag = itemTag;
        [itemArray addObject:item];
    }];
    self.navigationItem.rightBarButtonItems = itemArray;
}

#pragma mark - 设置导航按钮点击事件

/// 点击左侧导航按钮响应事件
/// @param sender 响应的按钮
- (void)tapNavLeftBtn:(UIButton *)sender {
    if ((self.NavLeftImage && self.NavLeftImage.length > 0) ||
        (self.NavLeftImageArray && self.NavLeftImageArray.count > 0))
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/// 点击右侧导航按钮响应事件
/// @param sender 响应的按钮
- (void)tapNavRightBtn:(UIButton *)sender {
}

/// 点击左侧其他按钮
/// @param sender 响应的按钮
- (void)tapMoreNavLeftBtn:(UIButton *)sender {
}

/// 点击右侧其他按钮
/// @param sender 响应的按钮
- (void)tapMoreNavRightBtn:(UIButton *)sender {
}

#pragma mark 是否支持右滑返回上一级

/// 设置是否支持右滑返回上一级
/// @param isSlidingReturn YES：支持  NO：不支持
- (void)setIsSlidingReturn:(BOOL)isSlidingReturn {
    _isSlidingReturn = isSlidingReturn;
    //是否支持右滑返回上一级
    self.navigationController.interactivePopGestureRecognizer.enabled = isSlidingReturn;
}

#pragma mark 触摸事件

/// 开始触摸回调事件
/// @param touches 当前Touch对象
/// @param event 当前Touch对应的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - [ 公共的一些方法 ]
#pragma mark 通过颜色来生成一个纯色图片
- (UIImage *)imageFromColor:(UIColor *)color rectSize:(CGRect)Rect {
    UIGraphicsBeginImageContext(Rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, Rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 创建自定义UIBarButtonItem

/// 自定义单个导航条按钮
/// @param icon 按钮的图标
/// @param highIcon 按钮高亮图标
/// @param target 监听按钮响应的对象
/// @param action 按钮响应的方法
- (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    if (highIcon && highIcon.length > 0) {
        [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
    button.frame = CGRectMake(0, 0, 30, 40);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    UIView *view = [[UIView alloc] init];
    view.frame = button.bounds;
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

#pragma mark 创建更多自定义UIBarButtonItem

/// 自定义更多导航条按钮
/// @param icon 更多按钮的图标
/// @param highIcon 更多按钮高亮图标
/// @param target 监听按钮响应的对象
/// @param action 更多按钮响应的方法
/// @param tag 更多按钮tag
- (UIBarButtonItem *)moreItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    if (highIcon && highIcon.length > 0) {
        [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
    button.tag = tag;
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] init];
    view.frame = button.bounds;
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

//- (void)presentBottom:(BaseViewController *)bottomVC completion:(void (^)(void))completion {
//    self.presentHeight = bottomVC.presentHeight;
//    bottomVC.modalPresentationStyle = UIModalPresentationCustom;
//    bottomVC.transitioningDelegate = self;
//    [self presentViewController:bottomVC animated:YES completion:^{
//        if (completion) {
//            completion();
//        }
//    }];
//}
//
//
//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    self.presentCtrl = [[BottomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    self.presentCtrl.presentHeight = self.presentHeight;
//    return self.presentCtrl;
//}
//

@end
