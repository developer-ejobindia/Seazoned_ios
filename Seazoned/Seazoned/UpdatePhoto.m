//
//  UpdatePhoto.m
//  Seazoned
//
//  Created by Student on 02/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

#import "UpdatePhoto.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "MF_Base64Additions.h"
#import "NSObject+SBJSON.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ImageCropView.h"

@interface UpdatePhoto ()<ImageCropViewControllerDelegate>
@property(strong,nonatomic)UIImage *image ;
@end

@implementation UpdatePhoto

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden: NO];

    [self showAnimate];
    self.view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
    
    pop_view.clipsToBounds=YES;
    cancel_view.clipsToBounds=YES;
    cancel_view.layer.cornerRadius=cancel_view.frame.size.height/2;
    pop_view.layer.cornerRadius=6;
    
    
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = cancel_view.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:245.0/255.0 green:36.0/255.0 blue:65.0/255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:251.0/255.0 green:114.0/255.0 blue:116.0/255.0 alpha:1.0].CGColor];
    
    
    
    
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    
    [cancel_view.layer insertSublayer:gradient atIndex:0];
    
    
    
    
    
    
    
    
    
}




-(void)editdata
{
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    
    //NSString*str_id=[df objectForKey:@"user_id"];
    
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];    //NSString *str_uid=@"4";
    
    
    // AppDelegate *appdel=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    
    //edit_restaurant_image?restaurant_id=1&restaurant_img=menu2.jpg&image_type=thumb
    //103.230.103.142:8080/dev/ondemandcrapp/public/api/
    
  //   NSString *url = [NSString stringWithFormat:@"http://103.230.103.142:8080/dev/seazonedapp/public/api/change-profile-picture?"];
    
    NSString *url = [NSString stringWithFormat:@"http://seazoned.com/api/change-profile-picture?"];

  //  http://seazoned.com/api
  //  NSString *url = [NSString stringWithFormat:@"http://192.168.1.2:8080/dev/seazonedapp/public/api/change-profile-picture?"];
    
    //NSString *url = [NSString stringWithFormat:@"http://103.230.103.142:8080/dev/ondemandcrapp/public/api/change/profile_image?"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    UIImage *img1=imgvw.image;
    
    NSData *imgdata = UIImageJPEGRepresentation(img1, 90);
    
    // NSString* myString;
    //  myString = [[NSString alloc] initWithData:imgdata encoding:NSASCIIStringEncoding];
    NSString *encodedStr = [MF_Base64Codec base64StringFromData:imgdata];
    
    NSLog(@"encoded str=%@",encodedStr);
    
    
    
    //  parameter id
    
    
    NSString*user_id=[df objectForKey:@"id"];
    
    NSLog(@"gggbg----%@",user_id);
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[user_id dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"source\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"iphone" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile_picture\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[encodedStr dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"------------------------------------------------------------------------");
    
    
    
    
    
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)body.length];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"dict %@",dic1);
    // [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *succ=[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"success"]];
    //  NSString *msg=[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"message"]];
    if ([succ isEqualToString:@"1"]) {
        
        //[self load_Profile];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[dic1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[dic1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
        
    }
    
    //[SVProgressHUD dismiss];
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}






- (IBAction)camera:(id)sender {
    //-------For Camera--------
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _camerapicker = [[UIImagePickerController alloc] init] ;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            _popoverGlobal = [[UIPopoverController alloc] initWithContentViewController:_camerapicker];
            _popoverGlobal.delegate = self;
            
        }
        _camerapicker.delegate = self;
        _camerapicker.allowsEditing = NO;
        _camerapicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _camerapicker.showsCameraControls = YES;
        //[camerapicker parentViewController];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            // [_popoverGlobal presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
        else{
            [self presentViewController:_camerapicker animated:YES completion:^{
            }];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"No Cmaera" message:@"No Camera Available in the Device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }

}

- (IBAction)gallery:(id)sender {
    //---------For Gallery----------
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init] ;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        _popoverGlobal = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        _popoverGlobal.delegate = self;
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        
    }
    else
        [self presentViewController:imagePicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([picker sourceType] == UIImagePickerControllerSourceTypePhotoLibrary){
        _image = [info valueForKey:UIImagePickerControllerOriginalImage];
        //------------------------------------
        imgvw.image =  _image;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            [_popoverGlobal dismissPopoverAnimated:YES];
        }
        else
            [self dismissViewControllerAnimated:YES completion:nil];
           // [self removeAnimate];
        
       
        //[self editdata];
        
        if( _image != nil){
            ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage: _image];
            controller.delegate = self;
            controller.blurredBackground = YES;
            // set the cropped area
            // controller.cropArea = CGRectMake(0, 0, 100, 200);
            [[self navigationController] pushViewController:controller animated:YES];
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    else{
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        _image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //-------------------------------
        imgvw.image =  _image;
        
        [library writeImageToSavedPhotosAlbum:[ _image CGImage] orientation:ALAssetOrientationLeft completionBlock:^(NSURL *assetURL, NSError *error){
        }];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            [_popoverGlobal dismissPopoverAnimated:YES];
            
            
        }
        else
            [self dismissViewControllerAnimated:YES completion:nil];
          //  [self removeAnimate];
        
       // [self editdata];
        
        if( _image != nil){
            ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage: _image];
            controller.delegate = self;
            controller.blurredBackground = YES;
            // set the cropped area
            // controller.cropArea = CGRectMake(0, 0, 100, 200);
            [[self navigationController] pushViewController:controller animated:YES];
        }
        
    }
    
    
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   // [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:true];
    
}
- (void)ImageCropViewControllerSuccess:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
     _image = croppedImage;
    imgvw.image = croppedImage;
    CGRect cropArea = controller.cropArea;
   // [SVProgressHUD show];
    [[self navigationController] popViewControllerAnimated:YES];
    
    
    [self editdata];
}



- (void)ImageCropViewControllerDidCancel:(UIViewController *)controller
{
    
    
    
    [self.navigationController popViewControllerAnimated:true];
}



- (IBAction)close:(id)sender {
    
    [self removeAnimate];
}


-(void)showAnimate
{
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
    self.view.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
    
    self.view.alpha = 1.0;
        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        
    
    }];
}

-(void)removeAnimate
{
    [UIView animateWithDuration:0.25 animations:^{
    
        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
        self.view.alpha = 0.0;
    
    } completion:^(BOOL finished){
        
        
        if (finished) {
            [self.view removeFromSuperview];
        }
        
    }];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
