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
    CGFloat     _originY;
}
@property (nonatomic,strong) UIImageView     *imageView;
@property (nonatomic,strong) UIButton        *messageBtn;
@property (nonatomic,copy)   void(^MyBlock)(UIButton *messageBtn);
@property (nonatomic,copy)   void(^MyClickBlock)(UIButton *messageBtn);
@property (nonatomic,assign) CGFloat         scale;//屏幕比例

@end

@implementation ZOEEmptyPageDraw

- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message offsetY:(CGFloat)offsetY {
    _bgMessageOffset = offsetY;
    _originY = 0;
    [self showWithView:view imageName:imageName message:message];
}

- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message originY:(CGFloat)originY {
    _originY = originY;
    _bgMessageOffset = 0;
    [self showWithView:view imageName:imageName message:message];
}

- (void)showWithView:(UIView *)view
           imageName:(NSString *)imageName
             message:(NSString *)message
             offsetY:(CGFloat)offsetY
  responseMessageBtn:(void (^)(UIButton *))messageBtnBlock
     clickMessageBtn:(void (^)(UIButton *))clickMessageBtnBlock {
    _bgMessageOffset = offsetY;
    _originY = 0;
    _MyBlock = messageBtnBlock;
    _MyClickBlock = clickMessageBtnBlock;
    [self showWithView:view imageName:imageName message:message];
}

- (void)showWithView:(UIView *)view
           imageName:(NSString *)imageName
             message:(NSString *)message
             originY:(CGFloat)originY
  responseMessageBtn:(void (^)(UIButton *))messageBtnBlock
     clickMessageBtn:(void (^)(UIButton *))clickMessageBtnBlock {
    _originY = originY;
    _bgMessageOffset = 0;
    _MyBlock = messageBtnBlock;
    _MyClickBlock = clickMessageBtnBlock;
    [self showWithView:view imageName:imageName message:message];
}

- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message {
    if (!view)return;
    //设置图片
    if (![ZOEEmptyPageDraw isBlankString:imageName]) {
        [view addSubview:self.imageView];
        UIImage *image = [UIImage imageNamed:imageName];
        self.imageView.image = image;
    }
    //设置文本
    if (![ZOEEmptyPageDraw isBlankString:message]) {
        [view addSubview:self.messageBtn];
        [self.messageBtn setTitle:message forState:UIControlStateNormal];
    }
    [self configFrame:view];
}

- (void)configFrame:(UIView *)view {
    _imageView.frame = CGRectMake((view.frame.size.width-_imageView.image.size.width*_scale)/2.0,
                                  _originY?_originY:(100*_scale+_bgMessageOffset+_originY),
                                  _imageView.image.size.width*_scale,
                                  _imageView.image.size.height*_scale);
    
    CGRect messageBtnFrame = CGRectMake(0,
                                        CGRectGetMaxY(_imageView.frame),
                                        [UIScreen mainScreen].bounds.size.width,
                                        50*_scale);
    messageBtnFrame.origin.y = messageBtnFrame.origin.y?messageBtnFrame.origin.y:(_originY+_bgMessageOffset);
    _messageBtn.frame = messageBtnFrame;
    if (_MyBlock) {
        _MyBlock(_messageBtn);
    }
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
    _originY = 0;
}

- (void)clickMessageBtn:(UIButton *)send {
    if (_MyClickBlock) {
        _MyClickBlock(send);
    }
}


#pragma mark - properties

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
        _messageBtn.titleLabel.font = [UIFont systemFontOfSize:17*_scale];
        _messageBtn.adjustsImageWhenHighlighted = NO;
        [_messageBtn addTarget:self action:@selector(clickMessageBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self scale];
    }
    return self;
}

- (CGFloat)scale {
    if (_scale == 0) {
        _scale = ([UIScreen mainScreen].bounds.size.height>480?[UIScreen mainScreen].bounds.size.height/667.0:0.851574);
    }
    return _scale;
}

@end
