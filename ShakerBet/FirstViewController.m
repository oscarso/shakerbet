//
//  FirstViewController.m
//  ShakerBet
//
//  Created by Oscar So on 7/12/14.
//  Copyright (c) 2014 OscarSoft.co. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *imgLabel;
@end

@implementation FirstViewController

@synthesize playerShake;
@synthesize playerPhoto;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lastIndex = -1;
    count = 0;
    [self clearHashIndex];
	
    // setup AVAudioPlayer
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"ShakingSound" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    
    // initialize the audio player.
    NSError *error;
    self.playerShake = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    
    if (self.playerShake) {
        // Pre-load sound
        [self.playerShake prepareToPlay];
    }
    [self.playerShake setDelegate:self];
    
    // setup CMMotionManager
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                    }];
    
    // load Shake_Phone.jpg    
    viewX = self.img.frame.origin.x;
    viewY = self.img.frame.origin.y;
    viewW = self.img.frame.size.width;
    viewH = self.img.frame.size.height;

    self.img = [[UIImageView alloc]
                initWithFrame:CGRectMake(
                                         viewX, viewY,
                                         viewW, viewH)];
    //set new image
    [self.img setImage:[UIImage imageNamed:@"Shake_Phone.jpg"]];
    [self.img setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.img];
    playATone = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(void)outputRotationData:(CMRotationRate)rotation
{
    CGFloat     max = MAX(fabs(rotation.z), MAX(fabs(rotation.x),fabs(rotation.y)));
    NSUInteger  x = (NSUInteger)fabs(rotation.x);
    NSUInteger  y = (NSUInteger)fabs(rotation.y);
    NSUInteger  z = (NSUInteger)fabs(rotation.z);
    NSUInteger  index;
    
    if ((x > PLAY_SOUND) ||
        (y > PLAY_SOUND) ||
        (z > PLAY_SOUND)) {
        [self.playerShake setVolume:max];
        [self.playerShake play];
    } else {
        [self.playerShake stop];
    }
    
    if (x > MAX_ROT || y > MAX_ROT) {
        if (self.playerPhoto) {
            [self.playerPhoto stop];
        }
        
        index = [self getIndex];
        lastIndex = index;
        
        // imgButton
        self.img = [[UIImageView alloc]
                    initWithFrame:CGRectMake(
                                             viewX, viewY,
                                             viewW, viewH)];
        // clear previous image
        [self.img setImage:[UIImage imageNamed:@"blank.jpg"]];
        [self.img setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:self.img];
        
        self.img = [[UIImageView alloc]
                    initWithFrame:CGRectMake(
                                             viewX, viewY,
                                             viewW, viewH)];
        // set new image
        NSMutableString *mImgName = [NSMutableString stringWithString:arr[index]];
        [mImgName appendString:@".jpg"];
        [self.img setImage:[UIImage imageNamed:mImgName]];
        [self.img setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:self.img];
        playATone = NO;
        
        // imgLabel
        NSString *label = arr[index];
        self.imgLabel.adjustsFontSizeToFitWidth = YES;
        self.imgLabel.text = label;
        self.imgLabel.textColor = [UIColor blackColor];
        self.imgLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)clearHashIndex
{
    NSUInteger i;
    for (i=0; i < sizeof(indexHash); i++) {
        indexHash[i] = 0;
    }
    count = 0;
}

- (NSUInteger)getIndex
{
    NSUInteger nextIndex;
    
    if (count == SZ_MAX_ARRAY) {
        [self clearHashIndex];
    }
    
    nextIndex = arc4random() % SZ_MAX_ARRAY;
    while (indexHash[nextIndex] > 0 && count <= SZ_MAX_ARRAY) {
        nextIndex = arc4random() % SZ_MAX_ARRAY;
    }
    indexHash[nextIndex]++;
    count++;
    
    return (nextIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableString *mSoundName;
    
    if (self.playerPhoto) {
        [self.playerPhoto stop];
    }
    
    // setup AVAudioPlayer
    if (playATone == YES) {
        mSoundName = [NSMutableString stringWithString:@"A_Tone"];
    } else {
        mSoundName = [NSMutableString stringWithString:arr[lastIndex]];
    }
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:mSoundName ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    
    // initialize the audio player.
    NSError *error;
    self.playerPhoto = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    if (self.playerPhoto) {
        [self.playerPhoto setDelegate:self];
        [self.playerPhoto setVolume:1.0];
        [self.playerPhoto play];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.playerPhoto) {
        [self.playerPhoto stop];
    }
    
}
@end
