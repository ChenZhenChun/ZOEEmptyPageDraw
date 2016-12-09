//
//  ZOEEmptyPageDraw.m
//  FamilyDoctor
//
//  Created by aiyoyou on 2016/10/31.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "ZOEEmptyPageDraw.h"

@interface ZOEEmptyPageDraw ()
{
    CGFloat     _bgMessageOffset;
}
@property (nonatomic,strong) UIImageView     *imageView;
@property (nonatomic,strong) UIButton        *messageBtn;
@property (nonatomic,copy)   void(^MyBlock)(UIButton *messageBtn);
@property (nonatomic,copy)   void(^MyClickBlock)(UIButton *messageBtn);

@end

@implementation ZOEEmptyPageDraw

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.backgroundColor = [UIColor clearColor];
        [_messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _messageBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _messageBtn.adjustsImageWhenHighlighted = NO;
        [_messageBtn addTarget:self action:@selector(clickMessageBtn:) forControlEvents:UIControlEventTouchUpInside];
        _messageBtn.frame = CGRectMake(0,
                                       CGRectGetMaxY(_imageView.frame),
                                       [UIScreen mainScreen].bounds.size.width,
                                       50);
    }
    return _messageBtn;
}

- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message {
    if (!view)return;
    //设置图片
    if (![ZOEEmptyPageDraw isBlankString:imageName]) {
        [view addSubview:self.imageView];
        UIImage *image = [UIImage imageNamed:imageName];
        _imageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-image.size.width)/2.0,
                                      100+_bgMessageOffset,
                                      image.size.width,
                                      image.size.height);
        self.imageView.image = image;
    }
    //设置文本
    if (![ZOEEmptyPageDraw isBlankString:message]) {
        [view addSubview:self.messageBtn];
        [self.messageBtn setTitle:message forState:UIControlStateNormal];
        if (_MyBlock) {
            _MyBlock(_messageBtn);
        }
        if (![ZOEEmptyPageDraw isBlankString:imageName])return;
        CGRect messageBtnFrame = self.messageBtn.frame;
        messageBtnFrame.origin.y += _bgMessageOffset;
        self.messageBtn.frame = messageBtnFrame;
    }
}

- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message offsetY:(CGFloat)offsetY {
    _bgMessageOffset = offsetY;
    [self showWithView:view imageName:imageName message:message];
}

- (void)showWithView:(UIView *)view
           imageName:(NSString *)imageName
             message:(NSString *)message
             offsetY:(CGFloat)offsetY
  responseMessageBtn:(void (^)(UIButton *))messageBtnBlock
     clickMessageBtn:(void (^)(UIButton *))clickMessageBtnBlock {
    
    _bgMessageOffset = offsetY;
    _MyBlock = messageBtnBlock;
    _MyClickBlock = clickMessageBtnBlock;
    [self showWithView:view imageName:imageName message:message];
}

- (void)removeBGMessage {
    if (_messageBtn) {
        [_messageBtn removeFromSuperview];
        _messageBtn = nil;
    }
    if (_imageView) {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
    _bgMessageOffset = 0;
}

- (void)clickMessageBtn:(UIButton *)send {
    if (_MyClickBlock) {
        _MyClickBlock(send);
    }
}

#pragma mark - 判断是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
