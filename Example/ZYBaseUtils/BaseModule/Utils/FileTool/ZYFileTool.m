//
//  ZYFileTool.m
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYFileTool.h"

@implementation ZYFileTool

/**
 判断某个路径是否存在
 @param path 文件路径
*/
+ (BOOL)isExistFileWithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    return false;
}

/**
 创建文件
 @param fileName 文件名称 path文件路径
 */
+ (BOOL)createFile:(NSString *)fileName path:(NSString *)path {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager createFileAtPath:filePath contents:nil attributes:nil]) {
        return YES;
    }
    return false;
}

/**
 删除文件
 @param fileName 文件名称 path文件路径
 */
+ (BOOL)deleteFile:(NSString *)fileName path:(NSString *)path {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    if ([self isExistFileWithPath:filePath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        if ([fileManager removeItemAtPath:filePath error:&error]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

/**
 保存文件到某个路径
 @param file 文件 path文件路径 fileName文件名称
 */
+ (void)saveFile:(id)file path:(NSString *)path fileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    if (file) {
        if (![self isExistFileWithPath:filePath]) {
            [self createFile:path path:fileName];
        }
       [file writeToFile:filePath atomically:YES];
    }
}

/**
 获取文件到某个路径
 @param path 文件路径 fileName 文件名称
 */
+ (id)getFileWith:(NSString *)path fileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    return nil;
}


@end
