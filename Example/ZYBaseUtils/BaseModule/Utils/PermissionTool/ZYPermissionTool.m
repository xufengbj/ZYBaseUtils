//
//  ZYPermissionTool.m
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYPermissionTool.h"
@import UIKit;
@import Photos;
@import AssetsLibrary;
@import CoreTelephony;
@import AVFoundation;
@import AddressBook;
@import Contacts;
@import EventKit;
@import CoreLocation;
@import MediaPlayer;
@import Speech;//Xcode 8.0 or later
@import Intents;
@import CoreBluetooth;
@import Accounts;
@import UserNotifications;

static NSString *const ZYPushNotificationAuthorizationKey = @"ZYPushNotificationAuthorizationKey";
static NSString *const ZYRequestNotificationsKey = @"ZY_requestedNotifications";

@interface ZYPermissionTool ()<CLLocationManagerDelegate>

@property (nonatomic, copy) ZYGeneralAuthorizationCompletion mapAlwaysAuthorizedHandler;
@property (nonatomic, copy) ZYGeneralAuthorizationCompletion mapAlwaysUnAuthorizedHandler;
@property (nonatomic, copy) ZYGeneralAuthorizationCompletion mapWhenInUseAuthorizedHandler;
@property (nonatomic, copy) ZYGeneralAuthorizationCompletion mapWhenInUseUnAuthorizedHandler;

//地理位置管理对象
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ACAccountStore *accounStore;
@property (nonatomic, assign) BOOL isRequestMapAlways;

@end

@implementation ZYPermissionTool

+ (ZYPermissionTool *)defaultManager {
    static ZYPermissionTool *authorizationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authorizationManager = [[ZYPermissionTool alloc] init];
    });
    return authorizationManager;
}

- (instancetype)init{
    if (self = [super init]) {
        _isRequestMapAlways = NO;
    }
    return self;
}

- (ACAccountStore *)accounStore{
    if (!_accounStore) {
        _accounStore = [[ACAccountStore alloc] init];
    }
    return _accounStore;
}

/**
 请求权限统一入口

 @param authorizationType 权限类型
 @param authorizedHandler 授权后的回调
 @param unAuthorizedHandler 未授权的回调
 */
- (void)ZY_requestAuthorizationWithAuthorizationType:(ZYAuthorizationType)authorizationType
                                   authorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                 unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler {
    switch (authorizationType) {
        case ZYAuthorizationTypePhotoLibrary:
            [self p_requestPhotoLibraryAccessWithAuthorizedHandler:authorizedHandler
                                               unAuthorizedHandler:unAuthorizedHandler];
            break;
            
        case ZYAuthorizationTypeCellularNetWork:
            [self p_requestNetworkAccessWithAuthorizedHandler:authorizedHandler
                                          unAuthorizedHandler:unAuthorizedHandler];
            break;
        
        case ZYAuthorizationTypeCamera:
            [self p_requestCameraAccessWithAuthorizedHandler:authorizedHandler
                                         unAuthorizedHandler:unAuthorizedHandler];
            break;
            
        case ZYAuthorizationTypeMicrophone:
            [self p_requestAudioAccessWithAuthorizedHandler:authorizedHandler
                                        unAuthorizedHandler:unAuthorizedHandler];
            break;
        case ZYAuthorizationTypeAddressBook:
            [self p_requestAddressBookAccessWithAuthorizedHandler:authorizedHandler
                                        unAuthorizedHandler:unAuthorizedHandler];
            break;


        case ZYAuthorizationTypeNotification:
            [self p_requestNotificationAccessWithAuthorizedHandler:authorizedHandler
                                               unAuthorizedHandler:unAuthorizedHandler];
            break;
        case ZYAuthorizationTypeMapAlways:
            [self p_requestMapAlwaysAccessWithAuthorizedHandler:authorizedHandler
                                            unAuthorizedHandler:unAuthorizedHandler];
            break;
        case ZYAuthorizationTypeMapWhenInUse:
            [self p_requestMapWhenInUseAccessWithAuthorizedHandler:authorizedHandler
                                               unAuthorizedHandler:unAuthorizedHandler];
            break;

        case ZYAuthorizationTypeSpeechRecognizer:
            [self p_requestSpeechRecognizerAccessWithAuthorizedHandler:authorizedHandler
                                                   unAuthorizedHandler:unAuthorizedHandler];
            break;

            
        default:
            NSAssert(!1, @"该方法暂不提供");
            break;
    }
}

#pragma mark - Photo Library


/// 相册访问权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestPhotoLibraryAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                     unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler {
    if (@available(iOS 8.0, *)) {
        //used `PHPhotoLibrary`
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        authorizedHandler ? authorizedHandler(): nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        unAuthorizedHandler ? unAuthorizedHandler(): nil;
                    });
                }
            }];
        } else if (authStatus == PHAuthorizationStatusAuthorized) {
            authorizedHandler ? authorizedHandler(): nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler(): nil;
        }
    } else {
        //used `AssetsLibrary`
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusAuthorized) {
            authorizedHandler ? authorizedHandler() : nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler() : nil;
        }
#pragma clang diagnostic pop
    }
}

#pragma mark - Network

/// 网络访问权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestNetworkAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler {
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        CTCellularDataRestrictedState authState = cellularData.restrictedState;
        if (authState == kCTCellularDataRestrictedStateUnknown) {
            cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
                if (state == kCTCellularDataNotRestricted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        authorizedHandler ? authorizedHandler() : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        unAuthorizedHandler ? unAuthorizedHandler() : nil;
                    });
                }
            };
        } else if (authState == kCTCellularDataNotRestricted) {
            authorizedHandler ? authorizedHandler() : nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler() : nil;
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - AvcaptureMedia

/// 相机访问权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestCameraAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                               unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    authorizedHandler ? authorizedHandler() : nil;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    unAuthorizedHandler ? unAuthorizedHandler() : nil;
                });
            }
        }];
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        authorizedHandler ? authorizedHandler() : nil;
    } else {
        unAuthorizedHandler ? unAuthorizedHandler() : nil;
    }
}


/// 麦克风访问权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestAudioAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                              unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    authorizedHandler ? authorizedHandler() : nil;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    unAuthorizedHandler ? unAuthorizedHandler() : nil;
                });
            }
        }];
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        authorizedHandler ? authorizedHandler() : nil;
    } else {
        unAuthorizedHandler ? unAuthorizedHandler() : nil;
    }
}

#pragma mark - AddressBook


/// 通讯录访问权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestAddressBookAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                    unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        authorizedHandler ? authorizedHandler() : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        unAuthorizedHandler ? unAuthorizedHandler() : nil;
                    });
                }
            }];
        } else if (authStatus == CNAuthorizationStatusAuthorized){
            authorizedHandler ? authorizedHandler() : nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler() : nil;
        }
    } else {
        //iOS9.0 eariler

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        if (authStatus == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRef addressBook = ABAddressBookCreate();
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        authorizedHandler ? authorizedHandler() : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        unAuthorizedHandler ? unAuthorizedHandler() : nil;
                    });
                }
            });
            
            if (addressBook) {
                CFRelease(addressBook);
            }
           
        } else if (authStatus == kABAuthorizationStatusAuthorized){
            authorizedHandler ? authorizedHandler() : nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler() : nil;
        }
#pragma clang diagnostic pop
        
    }
}


#pragma mark - Notifacations

/// 推送通知权限
/// @param completion 权限获取状态
- (void)p_authorizedStatusForPushNotificationsWithCompletion:(void (^)(ZYAuthorizationStatus status))completion {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            ZYAuthorizationStatus status = ZYAuthorizationStatusNotDetermined;
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusNotDetermined:
                    status = ZYAuthorizationStatusNotDetermined;
                    break;
                    
                case UNAuthorizationStatusDenied:
                    status = ZYAuthorizationStatusUnAuthorized;
                    break;
                    
                case UNAuthorizationStatusAuthorized:
                case UNAuthorizationStatusProvisional:
                    status = ZYAuthorizationStatusAuthorized;
                    break;
                    
                default:
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(status);
                }
            });
            
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(ZYAuthorizationStatusNotDetermined);
            }
        });
    }
}


/// 获取已授权的通工作状态
- (ZYAuthorizationStatus)p_authorizedStatusForPushNotifications {
    BOOL isAuthorized = [[NSUserDefaults standardUserDefaults] boolForKey:ZYPushNotificationAuthorizationKey];
    if (!isAuthorized) {
        return ZYAuthorizationStatusUnAuthorized;
    }
    
    if (@available(ios 8.0, *)) {
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            return ZYAuthorizationStatusAuthorized;
        } else {
            return ZYAuthorizationStatusUnAuthorized;
        }
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone) {
#pragma clang diagnostic pop
            
            return ZYAuthorizationStatusUnAuthorized;
        } else {
            return ZYAuthorizationStatusAuthorized;
        }
    }
}


/// 通知/Notification权限
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestNotificationAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                     unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (authorizedHandler) {
                        authorizedHandler();
                    }
                } else {
                    if (unAuthorizedHandler) {
                        unAuthorizedHandler();
                    }
                }
            });
        }];
    } else if (@available(iOS 8.0, *)) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType type = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
#pragma clang diagnostic pop
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
}

#pragma mark - Map

/// 一直请求定位权限访问
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestMapAlwaysAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                  unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    if (![CLLocationManager locationServicesEnabled]) {
        NSAssert([CLLocationManager locationServicesEnabled], @"Location service enabled failed");
        return;
    }
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        self.mapAlwaysAuthorizedHandler = authorizedHandler;
        self.mapAlwaysUnAuthorizedHandler = unAuthorizedHandler;
        [self.locationManager requestAlwaysAuthorization];
        self.isRequestMapAlways = YES;
        
    } else if (authStatus == kCLAuthorizationStatusAuthorizedAlways){
        authorizedHandler ? authorizedHandler() : nil;
    } else {
        unAuthorizedHandler ? unAuthorizedHandler() : nil;
    }
}

/// 使用时请求定位权限/访问
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestMapWhenInUseAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                     unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    if (![CLLocationManager locationServicesEnabled]) {
        NSAssert([CLLocationManager locationServicesEnabled], @"Location service enabled failed");
        return;
    }
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        
        self.mapWhenInUseAuthorizedHandler = authorizedHandler;
        self.mapAlwaysUnAuthorizedHandler = unAuthorizedHandler;
        [self.locationManager requestWhenInUseAuthorization];
        self.isRequestMapAlways = NO;
        
    } else if (authStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
        authorizedHandler ? authorizedHandler() : nil;
    } else {
        unAuthorizedHandler ? unAuthorizedHandler() : nil;
    }
}


#pragma mark - SpeechRecognizer

/// 语音识别权限访问
/// @param authorizedHandler 经授权的的handler
/// @param unAuthorizedHandler 未经授权的的handler
- (void)p_requestSpeechRecognizerAccessWithAuthorizedHandler:(ZYGeneralAuthorizationCompletion)authorizedHandler
                                         unAuthorizedHandler:(ZYGeneralAuthorizationCompletion)unAuthorizedHandler{
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus authStatus = [SFSpeechRecognizer authorizationStatus];
        if (authStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        authorizedHandler ? authorizedHandler() : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        unAuthorizedHandler ? unAuthorizedHandler() : nil;
                    });
                }
            }];
        } else if (authStatus == SFSpeechRecognizerAuthorizationStatusAuthorized){
            authorizedHandler ? authorizedHandler() : nil;
        } else {
            unAuthorizedHandler ? unAuthorizedHandler() : nil;
        }
    } else {
        // Fallback on earlier versions
    }
}


#pragma mark - CLLocationManagerDelegate

/// 位置回调代理方法
/// @param manager 位置管理器
/// @param status 返回位置状态
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.mapAlwaysAuthorizedHandler ? self.mapAlwaysAuthorizedHandler() : nil;
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        self.mapWhenInUseAuthorizedHandler ? self.mapWhenInUseAuthorizedHandler() : nil;
    } else {
        if (self.isRequestMapAlways) {
            self.mapAlwaysUnAuthorizedHandler ? self.mapAlwaysUnAuthorizedHandler() : nil;
        } else {
             self.mapWhenInUseUnAuthorizedHandler ? self.mapWhenInUseUnAuthorizedHandler() : nil;
        }
    }
}

@end
