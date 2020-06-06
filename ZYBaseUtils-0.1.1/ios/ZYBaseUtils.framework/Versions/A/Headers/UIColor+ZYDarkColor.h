//
//  UIColor+ZYDarkColor.h
//  GaGaHi
//
//  Created by MacBook on 2020/3/5.
//  Copyright © 2020 Zonyet. All rights reserved.
//
//  描述：适配暗黑模式   lightColor：白天模式颜色  darkColor：暗黑模式颜色


#import <UIKit/UIKit.h>

///适配暗黑模式   lightColor：白天模式颜色  darkColor：暗黑模式颜色
#define KDarkModelColor(lightColor, darkColor) [UIColor colorWithLightColorStr:lightColor DarkColor:darkColor]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZYDarkColor)

/// 十六进制字符串获取颜色
/// @param color 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;

/// 十六进制字符串获取颜色
/// @param color 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/// 适配暗黑模式颜色   传入的UIColor对象
/// @param lightColor 普通模式颜色
/// @param darkColor 暗黑模式颜色
+ (UIColor *)colorWithLightColor:(UIColor *)lightColor DarkColor:(UIColor *)darkColor;

/// 适配暗黑模式颜色   颜色传入的是16进制字符串
/// @param lightColor 普通模式颜色
/// @param darkColor 暗黑模式颜色
+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor DarkColor:(NSString *)darkColor;

/// 适配暗黑模式颜色   颜色传入的是16进制字符串 还有颜色的透明度
/// @param lightColor 普通模式颜色
/// @param lightAlpha 普通模式颜色透明度
/// @param darkColor 暗黑模式颜色透明度
/// @param darkAlpha 暗黑模式颜色
+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor WithLightColorAlpha:(CGFloat)lightAlpha DarkColor:(NSString *)darkColor WithDarkColorAlpha:(CGFloat)darkAlpha;

//卡片颜色
+ (UIColor *)dmWhiteColor;
+ (UIColor *)dmBlackColor;
+ (UIColor *)dmRedColor;
+ (UIColor *)dmLightGrayColor;

// 当前模式
+ (BOOL)isDarkModel;

@end

NS_ASSUME_NONNULL_END
