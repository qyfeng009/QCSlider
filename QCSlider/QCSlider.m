//
//  QCSlider.m
//  TemplateProject
//
//  Created by 009 on 2017/4/21.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "QCSlider.h"
#import "UIView+Extension.h"

@interface QCSlider () {
    float _thumbViewCenterX;
    float _defaultValue;
    float _defaultMinimumValue;
    float _defaultMaximumValue;
}
@property (nonatomic, strong) UIImageView *ruleTrackView;
@property (nonatomic, strong) UIImageView *minimumTrackView;
@property (nonatomic, strong) UIImageView *maximumTrackView;
@property (nonatomic, strong) UIImageView *thumbView;
@property (nonatomic, strong) UIImageView *thumb;


@end

@implementation QCSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds  =YES;
        
        _defaultMinimumValue = 0.0;
        _defaultMaximumValue = 1.0;
        _defaultValue = 0.0;
        
        self.ruleTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.ruleTrackView.userInteractionEnabled = NO;
        
        self.minimumTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.height/2, self.height)];
        self.minimumTrackView.backgroundColor = [UIColor colorWithRed:65/255.0f green:105/255.0f blue:255/255.0f alpha:1];
        self.minimumTrackView.userInteractionEnabled = NO;
        
        self.thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.height, self.height)];
        self.thumbView.backgroundColor = [UIColor clearColor];
        self.thumbView.userInteractionEnabled = NO;
        self.thumb = [[UIImageView alloc] initWithFrame:_thumbView.bounds];
        self.thumb.backgroundColor = [UIColor whiteColor];
        self.thumb.userInteractionEnabled = NO;
        [self.thumbView addSubview:_thumb];
        
        
        self.maximumTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(_thumbView.width/2, 0, self.width-_thumbView.width/2, self.height)];
        self.maximumTrackView.backgroundColor = [UIColor lightGrayColor];
        self.maximumTrackView.userInteractionEnabled = NO;
        
        [self setTrackCenterY];
        
        [self addSubview:_ruleTrackView];
        [self addSubview:_minimumTrackView];
        [self addSubview:_maximumTrackView];
        [self addSubview:_thumbView];
    }
    return self;
}

- (void)setTrackCenterY {
    self.ruleTrackView.centerY = self.height/2;
    self.minimumTrackView.centerY = self.height/2;
    self.maximumTrackView.centerY = self.height/2;
    self.thumbView.centerY = self.height/2;
}

#pragma mark: UIControl Touch
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    [self refreshSlider];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
     [self changePointX:touch];
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
     [self changePointX:touch];
    [self refreshSlider];
}

#pragma mark: PointChange
-(void)changePointX:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    if (point.x >= 0 && point.x <= self.width) {
        _thumbViewCenterX = point.x;
    }
}
- (void)refreshSlider {
    if (_thumbViewCenterX-_thumbView.width/2 <= 0) {
        self.thumbView.x = 0;
        _defaultValue = _defaultMinimumValue;
    } else if (_thumbViewCenterX+_thumbView.width/2 >= self.width) {
        self.thumbView.x = self.width - _thumbView.width;
        _defaultValue = _defaultMaximumValue;
    } else {
        self.thumbView.x = _thumbViewCenterX-_thumbView.width/2;
        _defaultValue = ((_thumbViewCenterX-_thumbView.width/2)/(self.width - _thumbView.width))*(_defaultMaximumValue-_defaultMinimumValue) + _defaultMinimumValue;
    }
    
    self.minimumTrackView.width = _thumbViewCenterX;
    self.maximumTrackView.x = _thumbView.x+_thumbView.width/2;
    self.maximumTrackView.width = self.width - _thumbView.x-_thumbView.width/2;

    self.value = _defaultValue;
    [self serTrackRounds:_trackCornerRadius desView:_minimumTrackView];
    [self serTrackRounds:_trackCornerRadius desView:_maximumTrackView];
}

#pragma mark: Set
- (void)setMinimumValue:(float)minimumValue {
    if (_minimumValue != minimumValue) {
        _minimumValue = minimumValue;
    }
    _defaultMinimumValue = minimumValue;
}
- (void)setMaximumValue:(float)maximumValue {
    if (_maximumValue != maximumValue) {
        _maximumValue = maximumValue;
    }
    _defaultMaximumValue = maximumValue;
}
- (void)setValue:(float)value {
    if (_value != value) {
        _value  =value;
    }
    
    if (value <= _defaultMinimumValue) {
        self.thumbView.x = 0;
        _thumbViewCenterX = _minimumTrackView.width/2;
    } else if (value >= _defaultMaximumValue) {
        self.thumbView.x = self.width - _thumbView.width;
        _thumbViewCenterX = self.width - _thumbView.width/2;
    } else {
        _thumbViewCenterX = (value - _defaultMinimumValue)/(_defaultMaximumValue-_defaultMinimumValue)*(self.width - _thumbView.width)+_thumbView.width/2;

        self.thumbView.x = _thumbViewCenterX-_thumbView.width/2;
    }
    
    self.minimumTrackView.width = _thumbViewCenterX;
    self.maximumTrackView.x = _thumbView.x+_thumbView.width/2;
    self.maximumTrackView.width = self.width - _thumbView.x-_thumbView.width/2;
}


- (void)setMinimumValueImage:(UIImage *)minimumValueImage {
    if (_minimumValueImage != minimumValueImage) {
        _minimumValueImage = minimumValueImage;
    }
    self.minimumTrackView.image = minimumValueImage;
}
- (void)setMaximumValueImage:(UIImage *)maximumValueImage {
    if (_maximumValueImage != maximumValueImage) {
        _maximumValueImage = maximumValueImage;
    }
    self.maximumTrackView.image = maximumValueImage;
}

- (void)setThumbImage:(UIImage *)thumbImage  {
    if (_thumbImage != thumbImage) {
        _thumbImage = thumbImage;
    }
    self.thumb.image = thumbImage;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    if (_minimumTrackTintColor != minimumTrackTintColor) {
        _minimumTrackTintColor = minimumTrackTintColor;
    }
    self.minimumTrackView.backgroundColor = minimumTrackTintColor;
}
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    if (_maximumTrackTintColor != maximumTrackTintColor) {
        _maximumTrackTintColor = maximumTrackTintColor;
    }
    self.maximumTrackView.backgroundColor = maximumTrackTintColor;
}
- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (_thumbTintColor != thumbTintColor) {
        _thumbTintColor = thumbTintColor;
    }
    self.thumb.backgroundColor = thumbTintColor;
}

-(void)setRulerImage:(UIImage *)rulerImage {
    if (_rulerImage != rulerImage) {
        _rulerImage = rulerImage;
    }
    self.minimumTrackView.image = nil;
    self.maximumTrackView.image = nil;
    self.minimumTrackTintColor = [UIColor clearColor];
    self.maximumTrackTintColor = [UIColor clearColor];
    self.ruleTrackView.image = rulerImage;
}
- (void)setRulerColor:(UIColor *)rulerColor {
    if (_rulerColor != rulerColor) {
        _rulerColor = rulerColor;
    }
    self.minimumTrackView.image = nil;
    self.maximumTrackView.image = nil;
    self.minimumTrackTintColor = [UIColor clearColor];
    self.maximumTrackTintColor = [UIColor clearColor];
    self.ruleTrackView.backgroundColor = rulerColor;
}

- (void)setTrackHeight:(float)trackHeight {
    if (_trackHeight != trackHeight) {
        _trackHeight = trackHeight;
    }
    if (trackHeight >= self.height) {
        trackHeight = self.height;
    }
    self.ruleTrackView.height = trackHeight;
    self.minimumTrackView.height = trackHeight;
    self.maximumTrackView.height = trackHeight;
    [self setTrackCenterY];
}
- (void)setThumbHeight:(float)thumbHeight {
    if (_thumbHeight != thumbHeight) {
        _thumbHeight = thumbHeight;
    }
    if (thumbHeight >= self.height) {
        thumbHeight = self.height;
    }
    self.thumbView.height = thumbHeight;
    self.thumb.height = thumbHeight;
    [self setTrackCenterY];
}
- (void)setThumbWidth:(float)thumbWidth {
    if (_thumbWidth != thumbWidth) {
        _thumbWidth = thumbWidth;
    }
    if (thumbWidth >= self.width) {
        thumbWidth = self.width;
    }
    self.thumbView.width = thumbWidth;
    self.thumb.width = thumbWidth;
}
- (void)setTrackCornerRadius:(float)trackCornerRadius {
    if (_trackCornerRadius != trackCornerRadius) {
        _trackCornerRadius = trackCornerRadius;
    }
    self.ruleTrackView.clipsToBounds = YES;
    self.minimumTrackView.clipsToBounds = YES;
    self.maximumTrackView.clipsToBounds = YES;
    self.ruleTrackView.layer.cornerRadius = trackCornerRadius;
    [self serTrackRounds:trackCornerRadius desView:_minimumTrackView];
    [self serTrackRounds:trackCornerRadius desView:_maximumTrackView];
}
- (void)serTrackRounds:(float)radius desView:(UIView *)view {
    UIBezierPath *maskPath;
    if (view == _minimumTrackView) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)];
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
- (void)setThumbCornerRadius:(float)thumbCornerRadius {
    if (_thumbCornerRadius != thumbCornerRadius) {
        _thumbCornerRadius = thumbCornerRadius;
    }
    self.thumb.clipsToBounds = YES;
    self.thumb.layer.cornerRadius = thumbCornerRadius;
}
- (void)setShowThumbShadow:(BOOL)showThumbShadow {
    if (_showThumbShadow != showThumbShadow) {
        _showThumbShadow = showThumbShadow;
    }
    self.thumbView.layer.shadowRadius  = 1.0;
    self.thumbView.layer.shadowOpacity = 0.3;
    self.thumbView.layer.shadowOffset  = CGSizeMake(0, 1.3);
    self.thumbView.clipsToBounds = NO;
}

@end
