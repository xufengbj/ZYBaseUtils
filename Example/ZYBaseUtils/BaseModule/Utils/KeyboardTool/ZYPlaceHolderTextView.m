//
//  ZYPlaceHolderTextView.m
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYPlaceHolderTextView.h"

@interface ZYPlaceHolderTextView ()

//占位符标签
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation ZYPlaceHolderTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (_placeholder && ![_placeholder isEqualToString:@""]) {
        _placeHolderLabel.text = _placeholder;
        _placeHolderLabel.hidden = NO;
    } else {
        _placeHolderLabel.text = @"";
        _placeHolderLabel.hidden = YES;
    }
}

- (id)initWithFrame:(CGRect)frame {
    if( (self = [super initWithFrame:frame]) ) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    return self;
}

/// 文本发送了变化
/// @param notification 通知
- (void)textChanged:(NSNotification *)notification {
    if ( 0 == [[self placeholder] length]) {
        return;
    }
    
    if (0 == [[self text] length]) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
    
    if (self.text.length >= 1000) {
        self.text = [self.text substringToIndex:1000];
    }
}


/// 父类绘制TextView方法
/// @param rect 绘制尺寸
- (void)drawRect:(CGRect)rect {
    if( [[self placeholder] length] > 0 ) {
        if (nil == _placeHolderLabel) {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 8, self.bounds.size.width - 16, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( 0 == [[self text] length] && [[self placeholder] length] > 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    self.selectedRange = NSMakeRange(0, 0);
    [super drawRect:rect];
}

@end
