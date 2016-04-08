//
//  KMCircleView.m
//  first
//
//  Created by jiangkelan on 2/1/16.
//  Copyright © 2016 KleinMioke. All rights reserved.
//

#import "KMCircleView.h"

@interface KMCircleView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CABasicAnimation *strokeToEnd;
@property (nonatomic, strong) CABasicAnimation *strokeBackwards;

@property (nonatomic, assign) NSInteger animationNum;

@end

@implementation KMCircleView


- (instancetype)initWithFrame:(CGRect)frame {
    
    CGRect realFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width);
    
    if (self = [super initWithFrame:realFrame]) {
        
        self.outerCircleRadius = frame.size.width / 2;
        
        // by default
        self.mediaTimeFunction = kCAMediaTimingFunctionEaseInEaseOut;
        self.innerCircleRadius = 0;
        self.startAngle = 0;
        self.percentage = 1;
        self.animated = YES;
        self.duration = 1;
        self.toValue = 1;
        self.removeOnCompletion = YES;
        
        self.color = [UIColor lightGrayColor];
        
        //        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)stroke {
    
    [self.circleLayer removeFromSuperlayer];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:self.innerCircleRadius + (self.outerCircleRadius - self.innerCircleRadius) / 2
                                                    startAngle:self.startAngle
                                                      endAngle:self.startAngle + 2 * M_PI * self.percentage
                                                     clockwise:YES];
    
    self.circleLayer.path = path.CGPath;
    
    [self.layer addSublayer:self.circleLayer];
    
    if (self.isGradient) {
        
        if (!self.gradientLayer) {
            
            self.gradientLayer = [CAGradientLayer layer];
            self.gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
            self.gradientLayer.frame = self.bounds;
            self.gradientLayer.colors = @[(id)[self.color colorWithAlphaComponent:0.0].CGColor,
                                          (id)[self.color colorWithAlphaComponent:0.1].CGColor,
                                          (id)[self.color colorWithAlphaComponent:0.3].CGColor,
                                          (id)self.color.CGColor];
            self.gradientLayer.locations = @[@0, @(0.3), @(0.5), @1];
            
            self.gradientLayer.startPoint = CGPointMake(0, 0);
            self.gradientLayer.endPoint = CGPointMake(1, 1);
        }
        
        [self.layer addSublayer:self.gradientLayer];
        
        self.layer.mask = self.circleLayer;
        
    } else if (self.isMask) {
        self.layer.mask = self.circleLayer;
    }
    
    if (self.animated) {
        
        self.strokeToEnd.duration  = self.duration;
        self.strokeToEnd.fromValue = @(self.fromValue);
        self.strokeToEnd.toValue   = @(self.toValue);
        
        self.animationNum = 1;
        [self.circleLayer addAnimation:self.strokeToEnd forKey:@"circleAnimationToEnd"];
        
    } 
}

- (void)strokeBack {
    
    self.strokeBackwards.duration  = 0.6;
    self.strokeBackwards.fromValue = @(self.toValue);
    self.strokeBackwards.toValue   = @(self.fromValue);
    
    self.animationNum = 2;
    [self.circleLayer addAnimation:self.strokeBackwards forKey:@"circleAnimationBack"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.54 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cleanSublayers];
    });
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.animationNum == 2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(strokeBackStopWithFinished:)]) {
            [self.delegate strokeBackStopWithFinished:flag];
        }
    } else if (self.animationNum == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(strokeStopWithFinished:)]) {
            [self.delegate strokeStopWithFinished:flag];
        }
    }
    self.animationNum = 0;
}

- (void)stop {
    [self.circleLayer removeAllAnimations];
}


- (void)cleanSublayers {
    [self.layer.sublayers enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
}

- (void)setPercent:(CGFloat)percent duration:(CGFloat)duration {
    
    if (duration == 0) {
        self.circleLayer.strokeEnd = percent / 100.f;
        return;
    }
    
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:self.mediaTimeFunction]];
    self.circleLayer.strokeEnd = percent / 100.f;
    
    [CATransaction commit];
}

#pragma mark - Setters & Getters

- (CAShapeLayer *)circleLayer {
    
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.strokeColor = self.color.CGColor;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.lineWidth = self.outerCircleRadius - self.innerCircleRadius;
    }
    return _circleLayer;
}

- (CABasicAnimation *)strokeToEnd {
    
    if (!_strokeToEnd) {
        _strokeToEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeToEnd.delegate = self;
        _strokeToEnd.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimeFunction];
        
        if (!self.removeOnCompletion) {
            _strokeToEnd.removedOnCompletion = NO;
            _strokeToEnd.fillMode = kCAFillModeBoth;
        }
    }
    return _strokeToEnd;
}

- (CABasicAnimation *)strokeBackwards {
    
    if (!_strokeBackwards) {
        _strokeBackwards = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeBackwards.delegate = self;
        _strokeBackwards.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimeFunction];
        
        if (!self.removeOnCompletion) {
            _strokeBackwards.removedOnCompletion = NO;
            _strokeBackwards.fillMode = kCAFillModeBoth;
        }
    }
    return _strokeBackwards;
}

- (void)setRemoveOnCompletion:(BOOL)removeOnCompletion {
    _removeOnCompletion = removeOnCompletion;
    
    _strokeToEnd ? _strokeToEnd.removedOnCompletion = removeOnCompletion : 0;
    _strokeBackwards ? _strokeBackwards.removedOnCompletion = removeOnCompletion : 0;
}

@end
