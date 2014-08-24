//
//  DrawingViewController.m
//  TeenyWear
//
//  Created by Martin Gregory on 8/23/14.
//  Copyright (c) 2014 Martin Gregory. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingView.h"
#import "TheDevice.h"
#import <MetaWear/MetaWear.h>

@interface DrawingViewController ()
@property (weak, nonatomic) IBOutlet DrawingView *drawingView;
@property (nonatomic, strong) NSArray* lightLevels;
@property (nonatomic, strong) NSArray* temperatures;
@property (nonatomic, strong) NSArray* activity;

@property (strong, nonatomic) NSString *accDataString;
@property (strong, nonatomic) NSMutableArray *accDataArray;
@property (strong, nonatomic) NSMutableArray *tempDataArray;
@property (nonatomic, strong) MBLMetaWear* device;

@property (nonatomic, assign) BOOL switchState;
@property (nonatomic, assign) BOOL accelState;
@property (nonatomic, assign) NSInteger accelIndex;

@property (nonatomic, strong) NSTimer* starTimer;

@end

@implementation DrawingViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.drawingView addCircle];
//    // Do any additional setup after loading the view.
//}

//- (void)viewDidLoad
//{
//    self.lightLevels =
//    @[@0.1, @0.1, @0.2, @0.2, @0.3, @0.3, @0.3, @0.3, @0.4, @0.4, @0.5, @0.6, @0.6, @0.7, @0.8, @0.8, @0.9, @0.9, @1.0, @1.0];
//    
//    self.temperatures =
//    @[@16, @16, @16, @17, @17, @17, @18, @18, @18, @18, @19, @20, @20, @20, @21, @22, @22, @23, @23, @24];
//    
//    self.activity =
//    @[@0.1, @0.1, @0.3, @0.2, @0.5, @0.8, @0.75, @0.4, @0.2, @0.1, @0.4, @0.6, @.3, @.2, @.9, @.22, @.52, @.3, @.2, @.24];
//}

- (void)viewDidLoad
{
    self.lightLevels =
  @[@0.1, @0.1, @0.2, @0.2, @0.3, @0.3, @0.3, @0.3, @0.4, @0.4, @0.5, @0.6, @0.6, @0.7, @0.8, @0.8, @0.9, @0.9, @1.0, @1.0, @1.0, @1.0, @0.9, @0.9, @0.8, @0.8, @0.7, @0.6, @0.6, @0.5, @0.4, @0.4, @0.3, @0.3, @0.3, @0.3, @0.2, @0.2, @0.1, @0.1];
    
    self.temperatures =
  @[@16, @16, @16, @17, @17, @17, @18, @18, @18, @18, @19, @20, @20, @20, @21, @22, @22, @23, @23, @24, @24, @23, @23, @22, @22, @21, @20, @20, @20, @19, @18, @18, @18, @18, @17, @17, @17, @16, @16, @16];
    
    self.activity =
  @[@0.1, @0.1, @0.3, @0.2, @0.5, @0.8, @0.75, @0.4, @0.2, @0.1, @0.4, @0.6, @.3, @.2, @.9, @.22, @.52, @.3, @.2, @.3, @0.1, @0.1, @0.3, @0.2, @0.5, @0.8, @0.9, @0.8, @0.7, @0.6, @0.4, @0.6, @.3, @.2, @.9, @.2, @.52, @.3, @.2, @.1];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.device = [TheDevice sharedInstance].device;
    for (UIView* view in self.drawingView.subviews) {
        [view removeFromSuperview];
    }
    _switchState = NO;
    _accelState = NO;
    [self stopAcceleration];
    [self startSwitchNotify];
    _tempDataArray = [NSMutableArray array];
}


- (void)viewDidAppear:(BOOL)animated
{
    for (int i=0; i<self.temperatures.count; i++) {
        CGFloat temp = [_temperatures[i] floatValue];
        CGFloat lightLevel = [_lightLevels[i] floatValue];
        CGFloat activityLevel = [_activity[i] floatValue];
        CGRect r = [_drawingView frameForCircleWithTemperature:temp activityLevel:activityLevel lightLevel:lightLevel index:i];
        UIColor* color = [_drawingView colorForCircleWithTemperature:temp activityLevel:1.0 lightLevel:lightLevel];
        [_drawingView addCircleWithFrame:r color:color];
    }
    for (int i=0; i<self.activity.count; i++) {
        CGFloat activityLevel = [_activity[i] floatValue];
        CGRect r = [_drawingView frameForStarWithActivity:activityLevel atIndex:i];
        UIColor* color = [_drawingView colorForStarWithActivity:activityLevel];
        [_drawingView addStarWithFrame:r color:color];
//        NSLog(@"index:%d", i);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readTemperature
{
[self.device.temperature readTemperatureWithHandler:^(NSDecimalNumber *temp, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tempDataArray addObject:temp];
        CGFloat degrees = [temp floatValue];
        UIColor* color = [_drawingView colorForCircleWithTemperature:degrees activityLevel:0.5 lightLevel:0.8];
        [_drawingView addTemporaryCircleWithFrame:CGRectMake(100, 150, 100, 100) color:color];
    });
}];
}





- (void)startAcceleration
{
    self.device.accelerometer.fullScaleRange = 2.0;
    self.device.accelerometer.sampleFrequency = 5; // 12.5Hz
    self.device.accelerometer.highPassFilter = YES;
    self.device.accelerometer.lowNoise = YES;
    self.device.accelerometer.activePowerScheme = 0;
    self.device.accelerometer.autoSleep = YES;
    self.device.accelerometer.sleepSampleFrequency = 2; // 6.25Hz
    
    // These variables are used for data recording
    self.accDataArray = [[NSMutableArray alloc] initWithCapacity:1000];
    _accelIndex = 0;
    
    [self.device.accelerometer startAccelerometerUpdatesWithHandler:^(MBLAccelerometerData *acceleration, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.accDataArray addObject:acceleration];
            
            _starTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(starTimerFired:) userInfo:nil repeats:YES];
        });
        // Add data to data array for saving
    }];
}

- (void)stopAcceleration
{
    [self.device.accelerometer stopAccelerometerUpdates];
    self.accDataString = [self processAccData];
    [_starTimer invalidate];
    _starTimer = nil;
}

- (NSString *)processAccData
{
    NSMutableString *AccelerometerString = [[NSMutableString alloc] init];
    for (MBLAccelerometerData *dataElement in self.accDataArray)
    {
        @autoreleasepool {
            [AccelerometerString appendFormat:@"%f,%f,%f,%f\n", dataElement.intervalSinceCaptureBegan,
             dataElement.x,
             dataElement.y,
             dataElement.z];
        }
    }
    return AccelerometerString;
}



- (void)startSwitchNotify
{
    [self.device.mechanicalSwitch startSwitchUpdatesWithHandler:^(BOOL isPressed, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isPressed != _switchState) {
                if (isPressed) {
                    [self startAcceleration];
                    _switchState = YES;
                    [self.device.led setLEDColor:[UIColor purpleColor] withIntensity:0.125];
                    [self readTemperature];
                    //NSNumber* num = [_tempDataArray lastObject];

                } else {
                    [self stopAcceleration];
                    _switchState = NO;
                    [self.device.led setLEDOn:NO withOptions:1];
                }
            }
        });
    }];
}


- (void)starTimerFired:(id)data
{
    if (_accelIndex < _accDataArray.count) {
        MBLAccelerometerData *dataElement = _accDataArray[_accelIndex];
      
        CGFloat activityLevel = dataElement.z * 8.0;
        CGRect r = [_drawingView frameForStarWithActivity:activityLevel atIndex:_accelIndex];
        UIColor* color = [_drawingView colorForStarWithActivity:activityLevel];
        [_drawingView addTemporaryStarWithFrame:r color:color acceleration:activityLevel];
        _accelIndex++;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
