//
//  search.m
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/28/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import "search.h"
#import "ServiceSheet.h"

@interface search ()

@end

@implementation search

@synthesize transactionNumber, searchButton, searchView, logo, branchCode, logoutBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // move frame when keyboard is shown
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    newFrame =  self.searchView.frame;
   
    
    //design

    logoutBtn.layer.cornerRadius = 10.0;
    logoutBtn.layer.borderWidth = 1.0;
    logoutBtn.layer.borderColor = [UIColor grayColor].CGColor;
    searchButton.layer.cornerRadius = 10.0;
    searchButton.layer.borderWidth = 1.0;
    searchButton.layer.borderColor = [UIColor grayColor].CGColor;
    searchView.layer.cornerRadius = 10.0;
    searchView.layer.borderWidth = 1.0;
    searchView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:logo.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.logo.bounds;
    maskLayer.path = maskPath.CGPath;
    logo.layer.mask = maskLayer;
   	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearText{
    transactionNumber.text = nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self keyboardDidHide];
}
-(void)keyboardDidShow{
    [self.searchView setFrame:CGRectMake(searchView.frame.origin.x, searchView.frame.origin.y-150, searchView.frame.size.width, searchView.frame.size.height)];
}
-(void)keyboardDidHide{
    [self.searchView setFrame:newFrame];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"billNumber"])
        
    {
        NSString* upperNumber = [transactionNumber.text uppercaseString];
        [[segue destinationViewController] setTNumber:upperNumber];
        [[segue destinationViewController] setBranchCode:branchCode];
    }
    [self clearText];
}


- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end