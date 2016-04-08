# KMCircleView
A kit for drawing circle with animation.

## Usage

### Inialization

The relation among circle's frame, innerCircleRadius and outerCircleRadius:
![Screenshot](https://github.com/Mioke/KMCircleView/blob/master/KMCircleViewDemo/Resources/demo1.png)

Properties:
```objc
    self.circle = [[KMCircleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    self.circle.innerCircleRadius = 50 / 2.f;
    self.circle.outerCircleRadius = 90 / 2.f;
    
    // fill color
    self.circle.color = [UIColor darkGrayColor];
    // set fill with gradient
    self.circle.isGradient = YES;
    // or customize your own gradient layer use:
    // self.circle.gradientLayer = [CAGradientLayer layer];
    
    // from which angle
    self.circle.startAngle = KM_Degrees_to_radians(90);
    // drawing percentage, 0.5 means half circle
    self.circle.percentage = 0.5;
    
    // --- Animation's intialization: ---
    // when call [circle stroke], whether should stroke with an animation. Default is YES
    self.circle.animated = YES;
    // CAMediaTimingFunction name
    self.circle.mediaTimeFunction = kCAMediaTimingFunctionEaseIn;
    // duration of animations
    self.circle.duration = 2.f;
    // CABaseAnimation's from-value
    self.circle.fromValue = 0.f;
    // animation's to-value
    self.circle.toValue = 1.f;
    // when call [circle stroke] or [circle strokeBackwards], should the circle recover to origin status.
    self.circle.removeOnCompletion = NO;
    // animation's callback
    self.circle.delegate = self;
```
