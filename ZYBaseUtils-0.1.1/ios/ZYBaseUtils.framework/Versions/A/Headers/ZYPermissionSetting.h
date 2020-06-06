//
//  ZYPermissionSetting.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYPermissionSetting : NSObject

#pragma mark- 指导用户给应用隐私设置

/**
 show App privacy settings
 */
+ (void)displayAppPrivacySettings;


/**
 show dialog to guide user to show App privacy setting
 
 @param title title
 @param message privacy message
 @param cancel cancel button text
 @param setting setting button text,if user tap this button ,will show App privacy setting
 */
+ (void)showAlertToDislayPrivacySettingWithTitle:(NSString*)title
                                             msg:(NSString*)message
                                          cancel:(NSString*)cancel
                                         setting:(NSString*)setting;


/**
 show dialog to guide user to show App privacy setting
 
 @param title title
 @param message privacy message
 @param cancel cancel button text
 @param setting setting button text,if user tap this button ,will show App privacy setting
 @param completion user has been choosed
 */
+ (void)showAlertToDislayPrivacySettingWithTitle:(NSString*)title
                                             msg:(NSString*)message
                                          cancel:(NSString*)cancel
                                         setting:(NSString*)setting
                                      completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
