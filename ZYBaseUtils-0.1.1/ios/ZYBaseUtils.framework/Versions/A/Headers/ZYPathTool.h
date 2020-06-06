//
//  ZYPathTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要获取项目中主要路径包括：HomeDirectory,Documents,Caches,tmp

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYPathTool : NSObject

/**
 获取主目录路径
 */
+ (NSString *)getHomeDirectory;

/**
 获取Documents路径
 */
+ (NSString *)getDocumentsDirectory;

/**
 获取Caches路径
 */
+ (NSString *)getCachesDirectory;


/**
 获取tmp路径
 */
+ (NSString *)getTmpDirectory;

/**
 获取完整的文件路径
 @param fileName 文件名称 path文件路径
 */
+ (NSString *)getFilePath:(NSString *)fileName path:(NSString *)path;


@end

NS_ASSUME_NONNULL_END
