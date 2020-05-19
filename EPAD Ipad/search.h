//
//  search.h
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/28/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface search : UIViewController
{
    CGRect newFrame;
}
@property (strong, nonatomic) IBOutlet UITextField *transactionNumber;

@property (strong, nonatomic) NSString *branchCode;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

- (IBAction)logOut:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *logoutBtn;

@end
