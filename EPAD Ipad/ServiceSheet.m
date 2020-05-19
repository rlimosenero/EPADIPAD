//
//  ServiceSheet.m
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/27/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import "ServiceSheet.h"

@interface ServiceSheet ()

@end

@implementation ServiceSheet
@synthesize drawImage,border,backImage,buttons,bcLabel,ucLabel,ecLabel,nLabel,dLabel,snLabel,nricLabel,mLabel,aLabel,qLabel,pLabel,descLabel,icLabel,tpLabel,pbLabel,ttLabel,cbLabel,tNumber, remarksText,branchCode, empCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //parsing data
    //connection handler
   NSString* urlString = [NSString stringWithFormat:@"http://nimble-qa.beau-tec.com:9090/display.transactionsheet.asp?branch=%@&transnumber=%@",branchCode,tNumber];
    NSLog(@"%@",urlString);
 //   NSString* urlString = [NSString stringWithFormat:@"http://localhost/ladyfinger-ios/jsonsamp.txt"];
    NSURL *dataUrl = [NSURL URLWithString:urlString];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:dataUrl];
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
  
    
    [self.backImage addSubview:drawImage];

    //horizontal Lines
    
    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(20, 288, 984, 2)];
    firstLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstLine];
    
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(20, 313, 984, 2)];
    secondLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:secondLine];
    
    UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(20, 455, 984, 2)];
    thirdLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:thirdLine];
    
    UIView *lastLine = [[UIView alloc] initWithFrame:CGRectMake(668, 725, 336, 1)];
    lastLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lastLine];
    
    
}


 // continue connection handler
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receipt =[[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data
{
    [receipt appendData:Data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    receiptData = [NSJSONSerialization JSONObjectWithData:receipt options:kNilOptions error:nil];
    //data parse
    NSString *ServiceNo = [[receiptData objectAtIndex:0]objectForKey:@"ServiceNo"];
    NSString *BranchCode = [[receiptData objectAtIndex:0]objectForKey:@"BranchCode"];
 //   NSString *Usertype = [[receiptData objectAtIndex:0]objectForKey:@"Usertype"];
    NSString *CustFName = [[receiptData objectAtIndex:0]objectForKey:@"CustFName"];
    NSString *CBranchCode = [[receiptData objectAtIndex:0]objectForKey:@"CBranchCode"];
 //   NSString *TxtCustType = [[receiptData objectAtIndex:0]objectForKey:@"TxtCustType"];
    NSString *EmpCode = [[receiptData objectAtIndex:0]objectForKey:@"EmpCode"];
    NSString *AppDate = [[receiptData objectAtIndex:0]objectForKey:@"AppDate"];
//    NSString *PackageId = [[receiptData objectAtIndex:0]objectForKey:@"PackageId"];
    NSString *spcode = [[receiptData objectAtIndex:0]objectForKey:@"spcode"];
    NSString *PackageName = [[receiptData objectAtIndex:0]objectForKey:@"PackageName"];
//    NSString *PackageCode = [[receiptData objectAtIndex:0]objectForKey:@"PackageCode"];
 //   NSString *ItemName = [[receiptData objectAtIndex:0]objectForKey:@"ItemName"];
//    NSString *ItemType = [[receiptData objectAtIndex:0]objectForKey:@"ItemType"];
    NSString *ItemQty = [[receiptData objectAtIndex:0]objectForKey:@"ItemQty"];
    NSString *ItemPrice = [[receiptData objectAtIndex:0]objectForKey:@"ItemPrice"];
 //   NSString *ItemAutono = [[receiptData objectAtIndex:0]objectForKey:@"ItemAutono"];
 //   NSString *ItemCurSession = [[receiptData objectAtIndex:0]objectForKey:@"ItemCurSession"];
    
    
    NSString *emp = [NSString stringWithFormat:@"Emp Code: %@",EmpCode];
    empCode.text = emp;
 
    snLabel.text = ServiceNo;
    bcLabel.text = BranchCode;
    ecLabel.text = EmpCode;
    dLabel.text = AppDate;
    nLabel.text = CustFName;
    ucLabel.text = CBranchCode;
    icLabel.text =  spcode;
    descLabel.text = PackageName;
    qLabel.text = ItemQty;
    pLabel.text = ItemPrice;
    
    //  mLabel.text = txtCustNumber;
    //   remarksText.text = cRemarks;

    //error handler
    if (snLabel.text == nil) {
        [self notFound];
    }
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"there is no connection to the server" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
    
	location = [touch locationInView:self.backImage];
	lastClick = [NSDate date];
	
    lastPoint = [touch locationInView:self.backImage];
    
	[super touchesBegan: touches withEvent: event];
	
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
	currentPoint = [touch locationInView:self.backImage];
	
    UIGraphicsBeginImageContext(self.backImage.frame.size);
    [drawImage.image drawInRect:CGRectMake(0, 0, self.backImage.frame.size.width, self.backImage.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
    [drawImage setFrame:CGRectMake(0, 0, self.backImage.frame.size.width, self.backImage.frame.size.height)];
    
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
    
	[self.backImage addSubview:drawImage];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reset:(id)sender {
    drawImage.image = nil;
    
}

- (IBAction)save:(id)sender {
    
    border.hidden = YES;
    for (UIButton *btn in buttons) {
        btn.hidden = !btn.hidden;
    }
    UIImage *viewImage = drawImage.image;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[viewImage CGImage] orientation:(ALAssetOrientation)[viewImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        
        [self uploadSignature];
        
        //      [self saveAsImage];
        
        // print function
        
        //query again if blob = !nil exec delete image [self deleteImage];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"The Image Was Saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; [alert show];}];
    
    
}
/*
 -(void) saveAsImage{
 
 UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
 [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
 
 UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
 
 ALAssetsLibrary *library2 = [[ALAssetsLibrary alloc] init];
 
 [library2 writeImageToSavedPhotosAlbum:[img CGImage] orientation:(ALAssetOrientation)[img imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
 
 if (!error) {
 UIGraphicsEndImageContext();
 }
 
 }];
 
 }
 */
-(void)deleteImage {
    
    
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            if(asset.isEditable) {
                [asset setImageData:nil metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
                    NSLog(@"Asset url %@ should be deleted. (Error %@)", assetURL, error);
                }];
            }
        }];
    } failureBlock:^(NSError *error) {
        
    }];
    
    
}

-(void)uploadSignature {
    
    NSData *imageData = UIImageJPEGRepresentation(drawImage.image, 90);
    NSString *urlString = @"http://localhost/beautec/upload.php";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
    
}

- (IBAction)dismiss:(id)sender {
    [self back];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) notFound{
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Record Found" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
        [self back];
    }
}

@end
