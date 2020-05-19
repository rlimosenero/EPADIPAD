//
//  Login.m
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/28/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login
@synthesize loginButton, userName, password, loginView, logo, branchPicker, viewPicker, bCode, btn;

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
    origFrame =  self.loginView.frame;

    btn.layer.cornerRadius = 10.0;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    loginButton.hidden = YES;
    loginView.layer.cornerRadius = 10.0;
    loginView.layer.borderWidth = 1.0;
    loginView.layer.borderColor = [UIColor grayColor].CGColor;
    
    viewPicker.layer.borderWidth = 1.0;
    viewPicker.layer.borderColor = [UIColor blackColor].CGColor;
   
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:logo.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.logo.bounds;
    maskLayer.path = maskPath.CGPath;
    logo.layer.mask = maskLayer;
   	// Do any additional setup after loading the view.
    
    //connection
    NSURL *dataUrl = [NSURL URLWithString:@"http://nimble-qa.beau-tec.com:9090/list.branchmenu.asp"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:dataUrl];
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    branchData =[[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data
{
    [branchData appendData:Data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    branch = [NSJSONSerialization JSONObjectWithData:branchData options:kNilOptions error:nil];
   
    branchName = [[branch objectAtIndex:0]objectForKey:@"branches"];
    branchCode = [[branch objectAtIndex:0]objectForKey:@"branchcode"];
    
    [branchPicker reloadAllComponents];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Branch Selection cannot be displayed" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//branch picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [branchName count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [branchName objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    bCode = [branchCode objectAtIndex:row];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Login"])
        
    {
        [[segue destinationViewController] setBranchCode:bCode];
    }
    userName.text = nil;
    password.text = nil;
}

- (IBAction)userPass:(id)sender {
    
    NSString *userUpper = [userName.text uppercaseString];
    NSString *passUpper = [password.text uppercaseString];
    
    NSString *url = [NSString stringWithFormat:@"http://nimble-qa.beau-tec.com:9090/log.validate.asp?uname=%@&pword=%@&bcode=%@",userUpper,passUpper,bCode];
    NSString *newString = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *json = [[NSURL alloc] initWithString:newString];
    NSData *data = [NSData dataWithContentsOfURL:json];
    credentials = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSString *success = [[credentials objectAtIndex:0]objectForKey:@"LogStat"];
    if ([success  isEqual: @"TB"]) {
        [loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else{
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect username or password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [errorView show];
    }
  }

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
        userName.text = nil;
        password.text = nil;
    }
}

//keyboard control

-(void)keyboardDidShow{
    [self.loginView setFrame:CGRectMake(loginView.frame.origin.x, loginView.frame.origin.y-150, loginView.frame.size.width, loginView.frame.size.height)];
}
-(void)keyboardDidHide{
    [self.loginView setFrame:origFrame];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self keyboardDidHide];
}
@end
