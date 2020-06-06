//
//  ZYUIDefine.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要定义一些项目中常用的宏定义
//  1: SCREEN 屏幕尺寸大小 导航栏,状态栏,Tabbar等高度
//  2: APP 是否是ipad iphone iphoneX设备，主窗口，发送通知等
//  3: 判断系统版本
//  4: 加载图片,XIB资源,声明属性
//  5: GCD,判断字符串，字典，数组，对象是否为空

#ifndef ZYUIDefine_h
#define ZYUIDefine_h

#pragma mark =================== SCREEN ====================

//屏幕宽度
#define KSCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define KSCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
//屏幕尺寸
#define KSCREEN_BOUNDS               [UIScreen mainScreen].bounds
//屏幕最大长度
#define KScreenMaxLength             (MAX(KSCREEN_WIDTH, KSCREEN_HEIGHT))
//屏幕最小长度
#define KScreenMinLength             (MIN(KSCREEN_WIDTH, KSCREEN_HEIGHT))
//电池状态栏高度
#define KStatusBarHeight             [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define KNavBarHeight                (44)
//导航栏和电池状态栏高度
#define KNavBarAndStatusBarHeight    (KStatusBarHeight + KNavBarHeight)
//TabBar高度
#define KTabBarHeight                (CGFloat)(KIsIphoneX?(49.0 + 34.0):(49.0))
//底部安全区域远离高度
#define KBottomSafeHeight            (CGFloat)(KIsIphoneX?(34.0):(0))

//以宽375进行适配
#define KScale_W_375(w)              ((KSCREEN_WIDTH)/375.0) * (w)
//以高667进行适配
#define KScale_H_667(h)              (KSCREEN_HEIGHT/667.0) * (h)


#pragma mark =================== APP ====================

//是否是ipad 设备
#define KIsIpad      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//是否是手机设备
#define KIsIphone    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//是否是iPhoneX系列手机设备
#define KIsIphoneX   KSCREEN_WIDTH >=375.0f && KSCREEN_HEIGHT >=812.0f && KIsIphone
//主窗口
#define KEYWINDOW    [UIApplication sharedApplication].keyWindow
//发送通知
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter]postNotificationName:name object:obj userInfo:info]


//__weak __strong 修饰符
//弱引用对象
#define KWeakSelf               __weak typeof(self) weakSelf = self;
//强引用对象
#define KStrongSelf             __strong typeof(self) type = self


#pragma mark =================== 判断系统版本 ====================

//是否是ios3系统
#define IOS13 [[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0 ? YES : NO
//是否是ios11系统
#define IOS11 [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO
//是否是ios10系统
#define IOS10 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? YES : NO
//是否是ios9系统
#define IOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO


#pragma mark =================== Resource ====================

#define KImage(imageName)        [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define KLoadNib(nibName)        [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]]

#pragma mark =================== 属性 ====================

//声明属性定义
#define KPropertyString(name)                  @property(nonatomic, copy) NSString *name
#define KPropertyStrong(type,name)             @property(nonatomic, strong) type *name
#define KPropertyAssign(type,name)             @property(nonatomic, assign) type name
#define KPropertyNSArray(name)                 @property(nonatomic, copy) NSArray *name
#define KPropertyNSMutableArray(name)          @property(nonatomic, strong) NSMutableArray *name
#define KPropertyNSDictionary(name)            @property(nonatomic, copy) NSDictionary *name
#define KPropertyNSMutableDictionary(name)     @property(nonatomic, copy) NSMutableDictionary *name

#pragma mark =================== GCD ====================
//默认block
//是否是主线程
#define KIsMainThread (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) ? YES : NO
//GCD - 在Main线程上运行
#define KMainThread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define KGlobalThread(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);
//GCD - 一次性执行
#define KDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

#pragma mark =================== 控制判断 ====================

//字符串是否为空
#define KISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define KISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define KISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define KISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//判断对象是否为空,为空则返回默认值
#define KGetNullDefaultObj(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value

#endif /* ZYUIDefine_h */
