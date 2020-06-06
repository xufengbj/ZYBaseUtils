//
//  ZYLogTool.m
//  GChat
//
//  Created by 许锋 on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYLogTool.h"

BOOL isPrintData = YES;

@implementation ZYLogTool

+ (void)initialize
{
    if (self == [ZYLogTool class]) {
        #ifdef DEBUG
        isPrintData = YES;
        #else
        isPrintData = NO;
        #endif
    }
}

/**
 禁止打印log
 */
+ (void)forbidPrintLog {
    isPrintData = NO;
}

/**
 允许打印log
 */
+ (void)allowPrintLog {
    isPrintData = YES;
}

/**
  打印字符串类型
  @param str 字符串
 */
+ (void)printStr:(NSString *)str {
    if (!isPrintData) {
        return;
    }
    NSLog(@"%@",str);
}

/**
  打印基本数据类型
  @param value 基本数据
  format 打印格式
 */
+ (void)printInteger:(NSInteger)value {
    if (!isPrintData) {
        return;
    }
    NSLog(@"%ld",value);
}

+ (void)printInt:(int)value {
    if (!isPrintData) {
        return;
    }
    NSLog(@"%d",value);
}

+ (void)printFloat:(float)value {
    if (!isPrintData) {
        return;
    }
    NSLog(@"%f",value);
}

+ (void)printDouble:(double)value {
    if (!isPrintData) {
        return;
    }
    NSLog(@"%f",value);
}

+ (void)printFloat:(float)value format:(NSString *)format {
    if (!isPrintData) {
        return;
    }
    NSLog(format,value);
}

+ (void)printDouble:(double)value format:(NSString *)format {
    if (!isPrintData) {
        return;
    }
    NSLog(format,value);
}
/**
  打印数组数据
  @param array 数组
 */
+ (void)printArray:(NSArray *)array {
    if (!isPrintData) {
        return;
    }
    NSLog(@"Array:\n%@",array);
}

/**
  打印字典
  @param dictionary 字典
 */
+ (void)printDictionary:(NSDictionary *)dictionary {
    if (!isPrintData) {
        return;
    }
    NSLog(@"Dict:\n%@",dictionary);
}

/**
 打印对象名称
 @param obj 对象
*/
+ (void)printObjcName:(id)obj {
    if (!isPrintData) {
        return;
    }
    NSObject *printObj = (NSObject *)obj;
    NSLog(@"%@",printObj.class ? printObj.class : @"");    
}

@end
