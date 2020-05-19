//
//  ServiceSheet.h
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/27/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ServiceSheet : UIViewController

{
    NSMutableData *receipt;
    NSArray *receiptData;
    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    NSDate *lastClick;
    BOOL mouseSwiped;
}
@property (strong, nonatomic) NSString *branchCode;
@property (nonatomic, strong) NSString *tNumber;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;
@property (strong, nonatomic) IBOutlet UIImageView *backImage;
@property (strong, nonatomic) IBOutlet UIImageView *drawImage;
- (IBAction)reset:(id)sender;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *border;
@property (strong, nonatomic) IBOutlet UILabel *bcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ucLabel;
@property (strong, nonatomic) IBOutlet UILabel *ecLabel;
@property (strong, nonatomic) IBOutlet UILabel *nLabel;
@property (strong, nonatomic) IBOutlet UILabel *dLabel;
@property (strong, nonatomic) IBOutlet UILabel *snLabel;
@property (strong, nonatomic) IBOutlet UILabel *nricLabel;
@property (strong, nonatomic) IBOutlet UILabel *mLabel;
@property (strong, nonatomic) IBOutlet UILabel *aLabel;
@property (strong, nonatomic) IBOutlet UILabel *qLabel;
@property (strong, nonatomic) IBOutlet UILabel *pLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *icLabel;
@property (strong, nonatomic) IBOutlet UILabel *tpLabel;
@property (strong, nonatomic) IBOutlet UILabel *pbLabel;
@property (strong, nonatomic) IBOutlet UILabel *ttLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbLabel;
@property (strong, nonatomic) IBOutlet UITextView *remarksText;
@property (strong, nonatomic) IBOutlet UILabel *empCode;

- (IBAction)dismiss:(id)sender;

@end
