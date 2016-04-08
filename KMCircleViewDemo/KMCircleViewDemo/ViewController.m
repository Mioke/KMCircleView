//
//  ViewController.m
//  KMCircleViewDemo
//
//  Created by Klein Mioke on 4/8/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

#import "ViewController.h"
#import "KMCircleView.h"

@interface ViewController () <KMCircleViewAnimationDelegate>
@property (nonatomic, strong) KMCircleView *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.circle = [[KMCircleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    self.circle.innerCircleRadius = 40;
    self.circle.outerCircleRadius = 50;
    
    self.circle.center = self.view.center;
    
    // fill color
    self.circle.color = [UIColor darkGrayColor];
    // set fill with gradient, default is NO.
    self.circle.isGradient = NO;
    // or customize your own gradient layer use:
    // self.circle.gradientLayer = [CAGradientLayer layer];
    
    // from which angle
    self.circle.startAngle = KM_Degrees_to_radians(-180);
    // drawing percentage, 0.5 means half circle
    self.circle.percentage = 1;
    
    // --- Animation's intialization: ---
    // when call [circle stroke], whether should stroke with an animation. Default is YES
    self.circle.animated = YES;
    // CAMediaTimingFunction name
    self.circle.mediaTimeFunction = kCAMediaTimingFunctionEaseInEaseOut;
    // duration of animations
    self.circle.duration = 0.5f;
    // CABaseAnimation's from-value
    self.circle.fromValue = 0.f;
    // animation's to-value
    self.circle.toValue = 1.f;
    // when call [circle stroke] or [circle strokeBackwards], should the circle recover to origin status.
    self.circle.removeOnCompletion = NO;
    // animation's callback
    self.circle.delegate = self;
    
    [self.view addSubview:self.circle];

}

- (IBAction)stroke:(id)sender {
    [self.circle stroke];
}
- (IBAction)isGrandientSwitch:(id)sender {
    
    UISwitch *swi = sender;
    self.circle.isGradient = swi.isOn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setPercent:(id)sender {
    
    UISlider *slider = sender;
    [self.circle setPercent:slider.value * 100 duration:0];
}

- (IBAction)setFromeValue:(id)sender {
    
    UISlider *slider = sender;
    self.circle.fromValue = slider.value;
}

- (IBAction)setToValue:(id)sender {
    UISlider *slider = sender;
    self.circle.toValue = [slider value];
}


- (void)strokeStopWithFinished:(BOOL)finished {
    
}

- (void)strokeBackStopWithFinished:(BOOL)finished {
    
}

@end
