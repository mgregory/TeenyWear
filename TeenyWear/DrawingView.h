//
//  DrawingView.h
//  TeenyWear
//
//  Created by Martin Gregory on 8/23/14.
//  Copyright (c) 2014 Martin Gregory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView
- (void)addCircle;


- (UIColor*)colorForCircleWithTemperature:(CGFloat)temp activityLevel:(CGFloat)activityLevel lightLevel:(CGFloat)lightLevel;
- (CGRect)frameForCircleWithTemperature:(CGFloat)temp activityLevel:(CGFloat)activityLevel lightLevel:(CGFloat)lightLevel index:(NSInteger)index;
- (void)addCircleWithFrame:(CGRect)frame color:(UIColor*)color;

- (UIColor*)colorForStarWithActivity:(CGFloat)activity;
- (CGRect)frameForStarWithActivity:(CGFloat)activityLevel atIndex:(NSInteger)index;
- (void)addStarWithFrame:(CGRect)frame color:(UIColor*)color;
- (void)addTemporaryStarWithFrame:(CGRect)frame color:(UIColor*)color acceleration:(CGFloat)accel;
- (void)addTemporaryCircleWithFrame:(CGRect)frame color:(UIColor*)color;

@end
