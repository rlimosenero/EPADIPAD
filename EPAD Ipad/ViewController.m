//
//  ViewController.m
//  EPAD Ipad
//
//  Created by Wilfred Villanueva on 3/24/14.
//  Copyright (c) 2014 RLIM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize backImage, drawImage, buttons, border;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   // image
    [self.backImage addSubview:drawImage];
  
    
 //horizontal Lines
    
    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(20, 195, 984, 2)];
    firstLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstLine];
    
    
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(20, 225, 984, 2)];
    secondLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:secondLine];
    
    UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(132, 327, 550, 2)];
    thirdLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:thirdLine];
    
    UIView *fourthLine = [[UIView alloc] initWithFrame:CGRectMake(132, 345, 550, 2)];
    fourthLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:fourthLine];
    
    UIView *fifthLine = [[UIView alloc] initWithFrame:CGRectMake(20, 380, 984, 1)];
    fifthLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:fifthLine];
    
    UIView *sixthLine = [[UIView alloc] initWithFrame:CGRectMake(135, 387, 530, 1.5)];
    sixthLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sixthLine];
    
    UIView *seventhLine = [[UIView alloc] initWithFrame:CGRectMake(135, 408, 530, 1.5)];
    seventhLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seventhLine];
    
    UIView *eightLine = [[UIView alloc] initWithFrame:CGRectMake(905, 515, 100, 1)];
    eightLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:eightLine];
    
    UIView *ninthLine = [[UIView alloc] initWithFrame:CGRectMake(905, 555, 100, 1)];
    ninthLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ninthLine];
    
    UIView *tenthLine = [[UIView alloc] initWithFrame:CGRectMake(905, 580, 100, 1)];
    tenthLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tenthLine];
    
    UIView *eleventhLine = [[UIView alloc] initWithFrame:CGRectMake(905, 582, 100, 1)];
    eleventhLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:eleventhLine];
    
    UIView *lastLine = [[UIView alloc] initWithFrame:CGRectMake(668, 704, 336, 1)];
    lastLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lastLine];

    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"The Image Was Saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; [alert show];}];
   
    
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

@end
