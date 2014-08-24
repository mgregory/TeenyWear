//
//  DrawingView.m
//  TeenyWear
//
//  Created by Martin Gregory on 8/23/14.
//  Copyright (c) 2014 Martin Gregory. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView()
@property (nonatomic, assign) CGFloat xOffset;
@property (nonatomic, strong) NSMutableArray* timers;
@end


@implementation DrawingView

static const CGFloat yAxis = 100;


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}





- (NSUInteger)randomNumberFrom:(NSUInteger)low to:(NSUInteger)high
{
    NSUInteger range = high - low + 1;
    NSUInteger num = arc4random_uniform((uint32_t)range);
    
    num += low-1;
    return num;
}

- (UIColor*)colorForCircleWithTemperature:(CGFloat)temp activityLevel:(CGFloat)activityLevel lightLevel:(CGFloat)lightLevel
{
    UIColor* color;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha = 0.9 * lightLevel;
    
    if (temp <=16) {
        red = 0;
        green = 0;
        blue = 1.0;
        
    } else if (temp <=17) {
        red = 55.0/255.0;
        green = 0.0/255.0;
        blue = 255.0/255.0;
        
    } else if (temp <=18) {
        red = 124.0/255.0;
        green = 0.0/255.0;
        blue = 255.0/255.0;
        
    } else if (temp <=19) {
        red = 185.0/255.0;
        green = 0.0/255.0;
        blue = 255.0/255.0;
        
    } else if (temp <=20) {
        red = 248.0/255.0;
        green = 0;
        blue = 248.0/255.0;
        
    } else if (temp <=21) {
        red = 255.0/255.0;
        green = 0;
        blue = 142.0/255.0;
        
    } else if (temp <=22) {
        red = 252.0/255.0;
        green = 0;
        blue = 160.0/255.0;
        
    } else if (temp <=23) {
        red = 248.0/255.0;
        green = 0;
        blue = 80.0/255.0;
        
    } else if (temp >23) {
        red = 255.0/255.0;
        green = 128.0/255.0;
        blue = 0;
    }
    

    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}


- (CGRect)frameForCircleWithTemperature:(CGFloat)temp activityLevel:(CGFloat)activityLevel lightLevel:(CGFloat)lightLevel index:(NSInteger)index
{
    CGFloat y = yAxis + 95-[self randomNumberFrom:0 to:120];
    CGRect frame;
    frame = CGRectMake(index * 12, y, activityLevel * 100, activityLevel*100);
     return frame;
}

- (void)addCircleWithFrame:(CGRect)frame color:(UIColor*)color
{
    
    CGFloat startOffsetX = ((CGFloat)[self randomNumberFrom:10 to:150]) - 65.0;
    CGFloat startOffsetY = ((CGFloat)[self randomNumberFrom:10 to:150]) - 65.0;
    
    CGRect startFrame = CGRectOffset(frame, startOffsetX, startOffsetY);
    
    UIImage* image = [self image:[UIImage imageNamed:@"CircleGray"] withColor:color];
    UIImageView* newView = [[UIImageView alloc] initWithImage:image];
    newView.frame = startFrame;
    
    //    [UIView animateWithDuration:5.0 delay:1.0 options:UIViewAnimationOptionAutoreverse animations:^{
    //        newView.frame = frame;
    //
    //    } completion:^(BOOL finished) {
    //        ;
    //    }];
    [UIView animateWithDuration:6.0 animations:^{
        newView.frame = frame;
    } completion:^(BOOL finished) {
        ;
    }];
    
    //    newView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    newView.layer.borderWidth = 2.0;
    [self addSubview:newView];
    
}


- (void)addTemporaryCircleWithFrame:(CGRect)frame color:(UIColor*)color
{
    
    
    CGRect startFrame = CGRectOffset(frame, 600, 220);
    
    UIImage* image = [self image:[UIImage imageNamed:@"CircleGray"] withColor:color];
    UIImageView* newView = [[UIImageView alloc] initWithImage:image];
    newView.frame = startFrame;
    
    [UIView animateWithDuration:9.0 delay:0.5 options:UIViewAnimationOptionAutoreverse animations:^{
        newView.frame = frame;

    } completion:^(BOOL finished) {
        [newView removeFromSuperview];
    }];
    
    //    newView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    newView.layer.borderWidth = 2.0;
    [self addSubview:newView];
    
}






- (UIColor*)colorForStarWithActivity:(CGFloat)activity
{
    UIColor* color;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha = 1.0;
//    NSLog(@"activity:%0.2f", activity);
    
    if (activity <=.1) {
        red = 0;
        green = 1.0;
        blue = 140.0/255.0;
        
    } else if (activity <=.2) {
        red = 0.0/255.0;
        green = 255.0/255.0;
        blue = 75.0/255.0;
        
    } else if (activity <=.3) {
        red = 0.0/255.0;
        green = 255.0/255.0;
        blue = 50.0/255.0;
        
    } else if (activity <=.4) {
        red = 0.0/255.0;
        green = 255.0/255.0;
        blue = 25.0/255.0;
        
    } else if (activity <=.5) {
        red = 170.0/255.0;
        green = 255.0/255.0;
        blue = 0.0/255.0;
        
    } else if (activity <=.6) {
        red = 130.0/255.0;
        green = 255.0/255.0;
        blue = 0.0/255.0;
        
    } else if (activity <=.7) {
        red =   70.0   /255.0;
        green = 255.0   /255.0;
        blue =  0.0   /255.0;
        
    } else if (activity <=.8) {
        red =   0.0     /255.0;
        green = 255.0   /255.0;
        blue =  45.0    /255.0;
        
    } else if (activity >.8) {
        red =   128.0/255.0;
        green = 255.0/255.0;
        blue =  128.0/255.0;
        
    }
    
    
    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

- (CGRect)frameForStarWithActivity:(CGFloat)activityLevel atIndex:(NSInteger)index
{
    CGRect frame;
    CGFloat y = yAxis + 50 - activityLevel * 30;
    frame = CGRectMake(index * 12, y, 20.0, 20.0);
   return frame;
}


- (void)addStarWithFrame:(CGRect)frame color:(UIColor*)color
{
    
    UIImage* image = [self image:[UIImage imageNamed:@"Star"] withColor:color];
    UIImageView* newView = [[UIImageView alloc] initWithImage:image];
    newView.frame = frame;
    //newView.alpha = 0.8;
    
    //    newView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    newView.layer.borderWidth = 2.0;
    [self addSubview:newView];
    
}

- (void)addTemporaryStarWithFrame:(CGRect)frame color:(UIColor*)color acceleration:(CGFloat)accel
{
    
    CGFloat startOffsetX = ((CGFloat)[self randomNumberFrom:100 to:300]);
    CGFloat startOffsetY = ((CGFloat)[self randomNumberFrom:10 to:110]) - 50.0;
    
    CGRect startFrame = CGRectOffset(frame, startOffsetX, startOffsetY);

    UIImage* image = [self image:[UIImage imageNamed:@"Star"] withColor:color];
    UIImageView* newView = [[UIImageView alloc] initWithImage:image];
    newView.frame = startFrame;
    //newView.alpha = 0.8;
    
    //    newView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    newView.layer.borderWidth = 2.0;
    
    
    [UIView animateWithDuration:5.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:2.5*accel options:UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         newView.frame = frame;

                     } completion:^(BOOL finished) {
                     }];

//    [UIView animateWithDuration:5.0 animations:^{
//        newView.frame = frame;
//    } completion:^(BOOL finished) {
//        ;
//    }];

    
    
    
    
    
    
    
    [self addSubview:newView];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(starTimerDone:) userInfo:newView repeats:NO];
    
}

- (void)starTimerDone:(NSTimer*)timer
{
    UIView* info = timer.userInfo;
    [UIView animateWithDuration:1.0 animations:^{
        info.alpha = 0.0;
    } completion:^(BOOL finished) {
        [info removeFromSuperview];
    }];
}


//- (void)addCircle
//{
//    
//    CGFloat red = 1.0;
//    CGFloat green = 0.0;
//    CGFloat blue = 0.0;
//    CGFloat alpha = 1.0;
//    UIColor* color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//    CGRect rect = CGRectMake(50, 10, 20, 20);
//    UIImage* image = [self image:[UIImage imageNamed:@"CircleGray"] withColor:color];
//    UIImageView* newView = [[UIImageView alloc] initWithImage:image];
//    newView.frame = rect;
//    [self addSubview:newView];
//    
//    CGFloat endRed = 1.0;
//    CGFloat endGreen = 1.0;
//    CGFloat endBlue = 0.0;
//    CGFloat endAlpha = 1.0;
//    UIColor* endColor = [UIColor colorWithRed:endRed green:endGreen blue:endBlue alpha:endAlpha];
//    CGRect endRect = CGRectMake(400, 600, 200, 200);
//    UIImage* endImage = [self image:[UIImage imageNamed:@"CircleGray"] withColor:endColor];
//    
//    [UIView animateWithDuration:5.0 delay:1.0 options:UIViewAnimationOptionAutoreverse animations:^{
//        newView.image = endImage;
//        newView.frame = endRect;
//
//    } completion:^(BOOL finished) {
//        ;
//    }];
//
//}
//
//- (void)drawRect:(CGRect)rect {
//    UIImage* image = [UIImage imageNamed:@"CircleGray"];
////    UIColor* color = [UIColor colorWithRed:1.0 green:0.1 blue:0.1 alpha:0.4];
//    UIColor* color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
//    UIColor* color2 = [UIColor colorWithRed:0.2 green:1.0 blue:0.1 alpha:0.5];
//    
//    
//    UIImage* coloredImage = [self image:image withColor:color];
//    [coloredImage drawAtPoint:CGPointMake(10,10) blendMode:kCGBlendModeNormal alpha:0.5];
//    coloredImage = [self image:image withColor:color2];
//    [coloredImage drawAtPoint:CGPointMake(100, 200) blendMode:kCGBlendModeNormal alpha:0.5];
//}



- (UIImage*)image:(UIImage*)image withColor:(UIColor*)color
{
    // load the image
    //NSString *name = @"badge.png";
    //UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(image.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImage;
}
@end
