//
//  ZYKeyboardTool.m
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYKeyboardTool.h"
#import <UIKit/UIKit.h>
#import "ZYUIDefine.h"
#import "UIView+Addition.h"

@interface ZYKeyboardTool()<UITextViewDelegate> {
    //键盘动画持续时间
    double animationDuration;
    //键盘高度
    CGFloat _keyboardHeight;
}

@end

@implementation ZYKeyboardTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addKeyboardObserver];
    }
    return self;
}


/// 设置TextView的值
/// @param textView 输入框对象
- (void)setTextView:(ZYValidateTextView *)textView {
    _textView = textView;
    _textView.delegate = self;
}


/// 设置占位符
/// @param placeholder 占位符
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textView.placeholder = _placeholder;
}


/// 设置父视图
/// @param superView 父视图
- (void)setSuperView:(UIView *)superView {
    _superView = superView;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSuperView:)];
    _superView.userInteractionEnabled = YES;
    [_superView addGestureRecognizer:tapGesture];
}

//进入激活状态
- (void)becomeFirstResponder {
    [_textView becomeFirstResponder];
}


/// 点击父视图事件
/// @param gesture 点击手势
- (void)tapSuperView:(UITapGestureRecognizer *)gesture {
    [_textView resignFirstResponder];
}

/// 添加键盘监听
- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


/// 移除观察监听者
- (void)removeObserver {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - Keyboard 相关事件

/// 键盘即将弹出通知事件
/// @param note 键盘弹出通知
- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    _keyboardHeight = keyboardSize.height;
    CGRect frame = _toolBarView.frame;
    frame.origin.y = KSCREEN_HEIGHT - _keyboardHeight -_toolBarView.height;
    [UIView animateWithDuration:animationDuration animations:^{
        self->_toolBarView.frame  = frame;
    }];
}


/// 键盘即将消失通知事件
/// @param note 键盘消失通知
- (void)keyboardWillHide:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = _toolBarView.frame;
    if (self.isHiddenToolBar) {
        frame.origin.y = KSCREEN_HEIGHT;
    } else {
        frame.origin.y = KSCREEN_HEIGHT - _toolBarView.height;
    }
    [UIView animateWithDuration:animationDuration animations:^{
        self->_toolBarView.frame  = frame;
    }];
}

#pragma mark - textViewDelegate

// 键盘发送按钮点击事件
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if (self.returnBlcok) {
            self.returnBlcok(textView.text);
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return [_textView validateTextViewStrInRange:range replacementText:text];
}

//textView 值发生变化
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _textView.placeholder = @"";
    } else {
        _textView.placeholder = _placeholder ? _placeholder : @"";
    }
}

@end
