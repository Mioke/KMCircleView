//
//  ViewController.m
//  KMCircleViewDemo
//
//  Created by Klein Mioke on 4/8/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

#import "ViewController.h"
#import "KMCircleView.h"

@interface ViewController ()
@property (nonatomic, strong) KMCircleView *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.circle = [[KMCircleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.circle.startAngle = KM_Degrees_to_radians(90);
    self.circle.percentage = 0.5;
    
    self.circle.removeOnCompletion = NO;
    
    [self.view addSubview:self.circle];

    [self.circle stroke];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
