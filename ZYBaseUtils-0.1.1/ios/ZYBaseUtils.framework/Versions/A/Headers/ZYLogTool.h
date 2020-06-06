//
//  ZYLogTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：自定义log用于打印各种数据类型，打印类名，控制是否打印开关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYLogTool : NSObject

/**
 禁止打印log
 */
+ (void)forbidPrintLog;

/**
 允许打印log
 */
+ (void)allowPrintLog;

/**
  打印字符串类型
  @param str 字符串
 */
+ (void)printStr:(NSString *)str;

/**
  打印基本数据类型
  @param value 基本数据
  format 打印格式
 */
+ (void)printInteger:(NSInteger)value;
+ (void)printInt:(int)value;
+ (void)printFloat:(float)value ;
+ (void)printDouble:(double)value;
+ (void)printFloat:(float)value format:(NSString *)format;
+ (void)printDouble:(double)value format:(NSString *)format;

/**
  打印数组数据
  @param array 数组
 */
+ (void)printArray:(NSArray *)array;

/**
  打印字典
  @param dictionary 字典
 */
+ (void)printDictionary:(NSDictionary *)dictionary;


/**
 打印对象名称
 @param obj 对象
*/
+ (void)printObjcName:(id)obj;

@end

NS_ASSUME_NONNULL_END
