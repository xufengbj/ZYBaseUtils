//
//  ZYPremissionConstant.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#ifndef ZYPremissionConstant_h
#define ZYPremissionConstant_h

typedef NS_ENUM(NSInteger, ZYAuthorizationType) {
    //相册/PhotoLibrary
    ZYAuthorizationTypePhotoLibrary = 0,
    //网络/Cellular Network
    ZYAuthorizationTypeCellularNetWork,
    //相机/Camera
    ZYAuthorizationTypeCamera,
    //麦克风/Microphone
    ZYAuthorizationTypeMicrophone,
    //通讯录/AddressBook
    ZYAuthorizationTypeAddressBook,
    //通知/Notification
    ZYAuthorizationTypeNotification,
    //一直请求定位权限/AlwaysAuthorization
    ZYAuthorizationTypeMapAlways,
    //使用时请求定位权限/WhenInUseAuthorization
    ZYAuthorizationTypeMapWhenInUse,
    //语音识别/SpeechRecognizer
    ZYAuthorizationTypeSpeechRecognizer,
};

/**
 AuthorizedStatus
 */
typedef NS_ENUM(NSInteger, ZYAuthorizationStatus) {
    ZYAuthorizationStatusNotDetermined = 0,
    ZYAuthorizationStatusAuthorized,
    ZYAuthorizationStatusUnAuthorized,
    ZYAuthorizationStatusDisabled,
};

#pragma mark - Constant Key

/**
 Motion
 */
static NSString *const ZYAuthorizationRequestedMotionKey               = @"ZY_requestedMotion";

/**
 Notifications
 */
static NSString *const ZYAuthorizationRequestedNotificationsKey        = @"ZY_requestedNotifications";


/**
 Map
 */
static NSString *const ZYAuthorizationRequestedInUseToAlwaysUpgradeKey = @"ZY_requestedInUseToAlwaysUpgrade";

#pragma mark - App InfoPlist Key

static NSString *const ZYAuthorizationInfoPlistKeyCamera               = @"NSCameraUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyMicrophone           = @"NSMicrophoneUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyPhotoLibrary         = @"NSPhotoLibraryUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyContact              = @"NSContactsUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyCalendar             = @"NSCalendarsUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyReminder             = @"NSRemindersUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyLocationWhenInUse    = @"NSLocationWhenInUseUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyLocationAlways       = @"NSLocationAlwaysUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyAppleMusic           = @"NSAppleMusicUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeySpeechRecognizer     = @"NSSpeechRecognitionUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyMotion               = @"NSMotionUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyHealthUpdate         = @"NSHealthUpdateUsageDescription";
static NSString *const ZYAuthorizationInfoPlistKeyHealthShare          = @"NSHealthShareUsageDescription";

#endif /* ZYPremissionConstant_h */
