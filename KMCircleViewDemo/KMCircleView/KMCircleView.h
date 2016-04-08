//
//  KMCircleView.h
//  first
//
//  Created by jiangkelan on 2/1/16.
//  Copyright © 2016 KleinMioke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define KM_Degrees_to_radians(x) (x) / 180.0 * M_PI

@class KMCircleView;

@protocol KMCircleViewAnimationDelegate <NSObject>

- (void)strokeStopWithFinished:(BOOL)finished;
- (void)strokeBackStopWithFinished:(BOOL)finished;

@end


@interface KMCircleView : UIView

@property (nonatomic, assign) CGFloat innerCircleRadius;
@property (nonatomic, assign) CGFloat outerCircleRadius;

@property (nonatomic, strong) UIColor *color;
/**
 *  Defualt is NO. If YES, the opacity of stroke is 0 and the path will act as a mask
 */
@property (nonatomic, assign) BOOL isGradient;
/**
 *  Customize the gradient layer when the `isGradient` property set to YES. There will be a default layer when you won't set it.
 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/**
 *  Default is NO, If YES, the path will be mask of this view.
 */
@property (nonatomic, assign) BOOL isMask;
/**
 *  Default is 1
 */
@property (nonatomic, assign) CGFloat percentage;
/**
 *  Default is 0
 */
@property (nonatomic, assign) CGFloat startAngle;

// or
@property (nonatomic, assign) CGFloat endAngle;


// ---------- Animation properties: -----------
/**
 *  Whether should stroke with animate, default is YES
 */
@property (nonatomic, assign) BOOL animated;
/**
 *  Default is kCAMediaTimingFunctionEaseInEaseOut
 */
@property (nonatomic, strong) NSString *mediaTimeFunction;
/**
 *  Default is 1 sec
 */
@property (nonatomic, assign) CGFloat duration;
/**
 *  Default is 0
 */
@property (nonatomic, assign) CGFloat fromValue;
/**
 *  Default is 1
 */
@property (nonatomic, assign) CGFloat toValue;
/**
 *  Default is YES
 */
@property (nonatomic, assign) BOOL removeOnCompletion;
/**
 *  Animations' callback
 */
@property (nonatomic, weak) id <KMCircleViewAnimationDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)stroke;
- (void)strokeBack;
- (void)stop;

- (void)cleanSublayers;


- (void)setPercent:(CGFloat)percent duration:(CGFloat)duration;

@end
