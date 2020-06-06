//
//  ZYFileTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要是对文件的一些操作方法：是否存在，创建文件，删除文件，保存文件，获取某个路径下的文件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYFileTool : NSObject

/**
 判断某个路径是否存在
 @param path 文件路径
 */
+ (BOOL)isExistFileWithPath:(NSString *)path;

/**
 创建文件
 @param fileName 文件名称 path文件路径
 */
+ (BOOL)createFile:(NSString *)fileName path:(NSString *)path;

/**
 删除文件
 @param fileName 文件名称 path文件路径
 */
+ (BOOL)deleteFile:(NSString *)fileName path:(NSString *)path;

/**
 保存文件到某个路径
 @param file 文件 path文件路径 fileName文件名称
 */
+ (void)saveFile:(id)file path:(NSString *)path fileName:(NSString *)fileName;

/**
 获取文件到某个路径
 @param path 文件路径 fileName 文件名称
 */
+ (id)getFileWith:(NSString *)path fileName:(NSString *)fileName;


@end

NS_ASSUME_NONNULL_END
