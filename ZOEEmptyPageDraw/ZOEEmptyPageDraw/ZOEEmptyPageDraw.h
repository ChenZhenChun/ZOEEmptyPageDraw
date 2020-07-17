//
//  EmptyPageDraw.h
//  FamilyDoctor
//
//  Created by aiyoyou on 2016/10/31.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZOEEmptyPageDraw : NSObject

/**
 空白页提示（支持图文、纯文本、纯图片）
 
 @param view      需要add到的父容器View
 @param imageName 图片名字
 @param message   文字名字
 */
- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message;

/**
 空白页提示（支持图文、纯文本、纯图片）
 
 @param view      需要add到的父容器View
 @param imageName 图片名字
 @param message   文字名字
 @param offsetY   Y轴偏移量
 */
- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message offsetY:(CGFloat)offsetY;


/**
 空白页提示（支持图文、纯文本、纯图片）
 
 @param view 需要add到的父容器View
 @param imageName 图片名字
 @param message 文字名字
 @param originY 原始Y值（如果存在图片则是图片y值，如果只有文本则为文本y值）
 */
- (void)showWithView:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message originY:(CGFloat)originY;

/**
 空白页提示（支持图文、纯文本、纯图片）
 
 @param view      需要add到的父容器View
 @param imageName 图片名字
 @param message   文字名字
 @param offsetY   Y轴偏移量
 @param messageBtnBlock 文字按钮实例对象回调（提供修改按钮颜色、状态等）
 @param clickMessageBtnBlock 文字点击回调函数
 */
- (void)showWithView:(UIView *)view
           imageName:(NSString *)imageName
             message:(NSString *)message
             offsetY:(CGFloat)offsetY
  responseMessageBtn:(void(^)(UIButton *messageBtn)) messageBtnBlock
     clickMessageBtn:(void(^)(UIButton *messageBtn))clickMessageBtnBlock;


/**
 空白页提示（支持图文、纯文本、纯图片）
 
 @param view      需要add到的父容器View
 @param imageName 图片名字
 @param message   文字名字
 @param originY   原始Y值（如果存在图片则是图片y值，如果只有文本则为文本y值）
 @param messageBtnBlock 文字按钮实例对象回调（提供修改按钮颜色、状态等）
 @param clickMessageBtnBlock 文字点击回调函数
 */
- (void)showWithView:(UIView *)view
           imageName:(NSString *)imageName
             message:(NSString *)message
             originY:(CGFloat)originY
  responseMessageBtn:(void (^)(UIButton *))messageBtnBlock
     clickMessageBtn:(void (^)(UIButton *))clickMessageBtnBlock;

/// 重置image
/// @param image image description
- (void)resetImage:(UIImage *)image;

/**
 移除空白页提示
 */
- (void)removeBGMessage;

@end
