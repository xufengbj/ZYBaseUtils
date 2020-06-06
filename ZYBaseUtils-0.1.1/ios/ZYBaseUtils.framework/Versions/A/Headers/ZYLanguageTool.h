//
//  ZYLanguageTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：设置多语言
//  1：设置不同的语言,语言包括 简体中文 繁体中文 en de es ja ko ru
//  2：获取不同语言下对应的文本

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYLanguageTool : NSObject


/**
 设置系统语言
 @param language 语言环境 包括 简体中文 繁体中文 en de es ja ko ru
 */
+ (void)setLanguage:(NSString *)language;


/**
 获取多语言下的文本
 @param key 文本key
*/
+ (NSString *)getValueFor:(NSString *)key;

/**
 获取当前语言
 */
+ (NSString *)getSetLanguage;


/**
 获取手机当前设置语言
*/
+ (NSString *)getPhoneLanguage;

/**
 获取app名称
 */
+ (NSString *)getAppName;

@end

NS_ASSUME_NONNULL_END
