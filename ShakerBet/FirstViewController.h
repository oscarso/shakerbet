//
//  FirstViewController.h
//  ShakerBet
//
//  Created by Oscar So on 7/12/14.
//  Copyright (c) 2014 OscarSoft.co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

#define CONVERT         10000
#define MAX_ROT         2
#define PLAY_SOUND      MAX_ROT
#define VIEW_X_IPHONE   10
#define VIEW_Y_IPHONE   30
#define VIEW_W_IPHONE   300
#define VIEW_H_IPHONE   300
#define VIEW_X_IPAD     10
#define VIEW_Y_IPAD     30
#define VIEW_W_IPAD     300
#define VIEW_H_IPAD     300


BOOL playATone;
NSInteger lastIndex;
NSUInteger count;
NSUInteger  viewX;
NSUInteger  viewY;
NSUInteger  viewW;
NSUInteger  viewH;

NSString* arr[] = {
    // Animal
    @"Cardinal",
    @"Cat",
    @"Cow",
    @"Dog",
    @"Elephant",
    @"Frog",
    @"Gorilla",
    @"Lion",
    @"Monkey",
    @"Pig",
    @"Red Stag",
    @"Rooster",
    @"Squirrel",
    @"Tiger",
    // Bathroom
    @"Shampoo",
    @"Toilet",
    @"Toothbrush",
    // Food
    @"Apple",
    @"Cake",
    @"Cereal",
    @"Chicken",
    @"Egg",
    @"Lamb",
    @"Potato Chips",
    // House
    @"Door Bell",
    @"Fireplace",
    @"Telephone",
    @"Sewing Machine",
    // Kitchen
    @"Dish Washer",
    @"Fork",
    @"Knife",
    @"Microwave",
    // Nature
    @"Earthquake",
    @"Flower",
    @"River",
    @"Rock",
    @"Tree",
    // Space
    @"Comet",
    @"Rocket",
    // Sport
    @"Golf",
    @"Hike",
    @"Ping Pong",
    // Technology
    @"Robot",
    // Tool
    @"Drill",
    @"Hammer",
    @"Saw",
    // Transport
    @"Boat",
    @"Car",
    @"Helicopter",
    @"Motorcycle",
    @"Aeroplane",
    @"Subway",
    @"Train",
    // Weather
    @"Rain",
    @"Thunder Strike",
    @"Wind"
};
NSUInteger SZ_MAX_ARRAY = sizeof(arr)/sizeof(*arr);
NSInteger indexHash[sizeof(arr)/sizeof(*arr)];


@interface FirstViewController : UIViewController<AVAudioPlayerDelegate>

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic, retain) AVAudioPlayer *playerShake;
@property (nonatomic, retain) AVAudioPlayer *playerPhoto;

- (void)clearHashIndex;
- (NSUInteger)getIndex;

@end