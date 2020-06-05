//
//  ZYPathTool.m
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYPathTool.h"

@implementation ZYPathTool

/**
 获取主目录路径
 */
+ (NSString *)getHomeDirectory {
    return  NSHomeDirectory();
}

/**
 获取Documents路径
 */
+ (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count > 0) {
        return [paths objectAtIndex:0];;
    } else {
        return @"";
    }
}

/**
 获取Caches路径
 */
+ (NSString *)getCachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (paths.count > 0) {
        return [paths objectAtIndex:0];;
    } else {
        return @"";
    }
}


/**
 获取tmp路径
 */
+ (NSString *)getTmpDirectory {
    return NSTemporaryDirectory();
}

/**
 获取完整的文件路径
 @param fileName 文件名称 path文件路径
 */
+ (NSString *)getFilePath:(NSString *)fileName path:(NSString *)path {
    return [path stringByAppendingPathComponent:fileName];
}


@end
