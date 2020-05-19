//
//  ViewController.h
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/24/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController

{
    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    NSDate *lastClick;
    BOOL mouseSwiped;
}

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;
@property (strong, nonatomic) IBOutlet UIImageView *backImage;
@property (strong, nonatomic) IBOutlet UIImageView *drawImage;
- (IBAction)reset:(id)sender;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *border;


@end
