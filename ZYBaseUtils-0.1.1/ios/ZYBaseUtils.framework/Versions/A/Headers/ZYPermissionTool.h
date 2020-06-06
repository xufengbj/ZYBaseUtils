//
//  ZYPermissionTool.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPremissionConstant.h"
#import "ZYPermissionSetting.h"

typedef void (^ZYGeneralAuthorizationCompletion) (void);

NS_ASSUME_NONNULL_BEGIN

@interface ZYPermissionTool : NSObject

+ (ZYPermissionTool *)defaultManager;

/**
 请求权限统一入口

 @param authorizationType 权限类型
 @param authorizedHandler 授权后的回调
 @param unAuthorizedHandler 未授权的回调
 */
- (void)ZY_requestAuthorizationWithAuthorizationType:(ZYAuthorizationType)authorizationType
                                   authorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                 unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler;

@end

NS_ASSUME_NONNULL_END
