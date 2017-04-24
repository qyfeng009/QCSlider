//
//  UIImage+Tint.h
//  TemplateProject
//
//  Created by 009 on 2017/2/20.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

-(UIImage*)tintedImageWithColor:(UIColor*)color;
-(UIImage*)tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)lightenWithLevel:(CGFloat)level;
-(UIImage*)lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)darkenWithLevel:(CGFloat)level;
-(UIImage*)darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)darkenRect:(CGRect)rect withLevel:(CGFloat)level;

@end
