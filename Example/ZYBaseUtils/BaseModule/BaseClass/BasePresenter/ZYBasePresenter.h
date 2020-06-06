//
//  ZYBasePresenter.h
//  GChat
//
//  Created by zhangmeng on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  该类的作用是提供MVP中P层的基类，Presenter作为model和View的中间人，从model层获取数据之后传给view，使得view和model之间没有耦合，MVP中的V可以ViewController、View等控件
//  这里ZYObjectType使用泛型的概念
//  基类Presenter主要是提供绑定view和解绑view的功能

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYBasePresenter <ZYObjectType> : NSObject

@property (nonatomic, weak) ZYObjectType viewObject;

/**
 初始化函数
 
 @param viewObj 要绑定的视图
 */
- (instancetype)initWithView:(ZYObjectType)viewObj;

/**
 * 绑定视图
 * @param viewObj 要绑定的视图
 */
- (void)attachView:(ZYObjectType)viewObj;

/**
 解绑视图
 */
- (void)detachView;

@end

NS_ASSUME_NONNULL_END
