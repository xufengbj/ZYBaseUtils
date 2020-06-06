//
//  ZYDeviceTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYDeviceTool : NSObject

/*
 获取应用版本号
 */
+ (NSString *)getAppVersion;

/*
 获取设备系统版本
*/
+ (NSString *)getDeviceVersion;

/*
 获取设备类型 (iPad iPhone 两种)
 */
+ (NSString *)getDeviceModel;

/**
 获取设备电池电量
 */
+ (float)getDeviceBatteryLevel;

/**
 获取设备名称
 */
+ (NSString *)getDeviceName;


/**
 获取UUID
 */
+ (NSString *)getDeviceUUID;

/**
获取总存储大小 单位G
*/
+ (double)getDeviceTotalSizeG;

/**
获取可用存储大小 单位G
*/
+ (double)getDeviceFreeSizeG;


/**
获取可用存储大小 单位M
*/
+ (double)getDeviceFreeSizeM;

/**
获取当前语言
*/
+ (NSString *)getCurrentLanguage;

/**
 获取设备宽度
 */
+ (CGFloat)getDeviceScreenWidth;

/**
获取设备高度
*/
+ (CGFloat)getDeviceScreenHeight;


@end

NS_ASSUME_NONNULL_END
