//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "TLHMViewController.h"

#import <MyoKit/MyoKit.h>

@interface MainScene ()

@property (strong, nonatomic) TLMPose *currentPose;

@end

@implementation MainScene {
    CCLabelTTF *_scoreLabel;
    CCSprite *_gesture;
    int _score;
}

- (void) connect {
    // Note that when the settings view controller is presented to the user, it must be in a UINavigationController.
    TLHMViewController* thalmicController =    [[TLHMViewController alloc] initWithNibName:@"TLHMViewController" bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:thalmicController];

    // Present the settings view controller modally.
    [[CCDirector sharedDirector] presentViewController:controller animated:YES completion:nil];
}

- (void) didLoadFromCCB {
    
    // Data notifications are received through NSNotificationCenter.
    // Posted whenever a TLMMyo connects
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didConnectDevice:)
//                                                 name:TLMHubDidConnectDeviceNotification
//                                               object:nil];
//    // Posted whenever a TLMMyo disconnects
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didDisconnectDevice:)
//                                                 name:TLMHubDidDisconnectDeviceNotification
//                                               object:nil];
//    // Posted when a new orientation event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didReceiveOrientationEvent:)
//                                                 name:TLMMyoDidReceiveOrientationEventNotification
//                                               object:nil];
//    // Posted when a new accelerometer event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didReceiveAccelerometerEvent:)
//                                                 name:TLMMyoDidReceiveAccelerometerEventNotification
//                                               object:nil];
    // Posted when a new pose is available from a TLMMyo
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];
    
}

- (void) onEnter {
    [super onEnter];
    _score = 0;
    //_message = [[CCLabelTTF alloc]init];
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    self.currentPose = pose;
    
    // Handle the cases of the TLMPoseType enumeration, and change the color of helloLabel based on the pose we receive.
    switch (pose.type) {
        case TLMPoseTypeNone:
            NSLog(@"you suck");
            break;
        case TLMPoseTypeFist:
            NSLog(@"you win");
            _score++;
            _scoreLabel.string = [NSString stringWithFormat:@"%i",_score];
            break;
        case TLMPoseTypeWaveIn:
            NSLog(@"you suck");
            break;
        case TLMPoseTypeWaveOut:
            NSLog(@"you suck");
            break;
        case TLMPoseTypeFingersSpread:
            NSLog(@"you suck");
            break;
        case TLMPoseTypeTwistIn:
            NSLog(@"you suck");
            break;
    }
}

@end
