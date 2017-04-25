//
//  ViewController.m
//  QCSlider
//
//  Created by 009 on 2017/4/24.
//
//

#import "ViewController.h"
#import "QCSlider.h"
#import "UIImage+Tint.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    QCSlider *qcSlider = [[QCSlider alloc] initWithFrame:CGRectMake(40, 100, 300, 30)];
    [qcSlider addTarget:self action:@selector(qcSlide:) forControlEvents:UIControlEventValueChanged];
    
    qcSlider.trackHeight = 8;
    qcSlider.thumbHeight = 18;
    qcSlider.thumbWidth = 18;
    
    qcSlider.trackCornerRadius = 4;
    qcSlider.thumbCornerRadius = 9;
    
    qcSlider.showThumbShadow = YES;
    
    qcSlider.minimumValue = 0;
    qcSlider.maximumValue = 255;
    qcSlider.value = 255;
    
    [self.view addSubview:qcSlider];
    
    
    QCSlider *rulerSlider = [[QCSlider alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 64)];
    rulerSlider.rulerImage = [UIImage imageNamed:@"ruler"];
    rulerSlider.maximumValue = 30;
    rulerSlider.trackHeight = 48;
    rulerSlider.thumbWidth = 10;
    rulerSlider.thumbCornerRadius = 5;
    rulerSlider.thumbTintColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    rulerSlider.thumbImage = [UIImage imageNamed:@"指针"];
    
    [rulerSlider addTarget:self action:@selector(qcSlide:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:rulerSlider];
    
    
}

- (void)qcSlide:(QCSlider *)slide {
    NSLog(@"%f", slide.value);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
