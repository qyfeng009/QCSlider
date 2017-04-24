//
//  QCSlider.h
//  TemplateProject
//
//  Created by 009 on 2017/4/21.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QCSlider : UIControl


/**
 最小滑道值
 */
@property(nonatomic) float minimumValue;
/**
 最大滑道值
 */
@property(nonatomic) float maximumValue;
/**
 当前滑块所在的值
 */
@property(nonatomic) float value;
/**
 左滑道的img
 */
@property(nullable, nonatomic,strong) UIImage *minimumValueImage;
/**
 右滑道的img
 */
@property(nullable, nonatomic,strong) UIImage *maximumValueImage;
/**
 滑块的img
 */
@property(nullable, nonatomic,strong) UIImage *thumbImage;
/**
 左滑道的颜色
 */
@property(nullable, nonatomic,strong) UIColor *minimumTrackTintColor;
/**
 右滑道的颜色
 */
@property(nullable, nonatomic,strong) UIColor *maximumTrackTintColor;
/**
 滑块的颜色
 */
@property(nullable, nonatomic,strong) UIColor *thumbTintColor;
/**
 标尺滑道的img(标尺滑道不区分左右滑道，若设置此属性，不要在设置左右滑道的属性)
 */
@property(nullable, nonatomic,strong) UIImage *rulerImage;
/**
 标尺滑道的颜色(标尺滑道不区分左右滑道，若设置此属性，不要在设置左右滑道的属性)
 */
@property(nullable, nonatomic,strong) UIColor *rulerColor;
/**
 滑道的高度
 */
@property(nonatomic) float trackHeight;
/**
 滑块的高度
 */
@property(nonatomic) float thumbHeight;
/**
 滑块的宽度
 */
@property(nonatomic) float thumbWidth;
/**
 滑道两端圆角，默认0
 */
@property(nonatomic) float trackCornerRadius;
/**
 滑块圆角，默认0
 */
@property(nonatomic) float thumbCornerRadius;
/**
 滑块阴影，默认NO
 */
@property(nonatomic,assign) BOOL showThumbShadow;


@end
