//
//  Login.h
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/28/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "search.h"

@interface Login : UIViewController
{
    CGRect origFrame;
    NSArray *credentials;
    NSMutableData *branchData;
    NSArray *branch;
    NSArray *branchCode;
    NSArray *branchName;
}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIPickerView *branchPicker;
@property (strong, nonatomic) IBOutlet UIView *viewPicker;
@property (strong, nonatomic) NSString *bCode;

- (IBAction)userPass:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@end
