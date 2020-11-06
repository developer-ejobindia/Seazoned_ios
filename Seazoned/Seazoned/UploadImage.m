//
//  UploadImage.m
//  Seazoned
//
//  Created by Apple on 22/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

#import "UploadImage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "MF_Base64Additions.h"
#import "NSObject+SBJSON.h"
#import <SVProgressHUD/SVProgressHUD.h>




@interface UploadImage ()

@end

@implementation UploadImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showAnimate];
    self.view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.0];
    [self editdata];
}
-(void)editdata
{
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    
    //NSString*str_id=[df objectForKey:@"user_id"];
    
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];    //NSString *str_uid=@"4";
    
    
    // AppDelegate *appdel=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    
    //edit_restaurant_image?restaurant_id=1&restaurant_img=menu2.jpg&image_type=thumb
    //103.230.103.142:8080/dev/ondemandcrapp/public/api/
    
    //  NSString *url = [NSString stringWithFormat:@"http://103.230.103.142:8080/dev/seazonedapp/public/api/upload-service-image?"];
    NSString *url = [NSString stringWithFormat:@"http://seazoned.com/api/upload-service-image?"];

   //NSString *url = [NSString stringWithFormat:@"http://192.168.1.2:8080/dev/seazonedapp/public/api/upload-service-image?"];
       // http://seazoned.com/api
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    UIImage *img1=self.img;
    
    NSData *imgdata = UIImageJPEGRepresentation(img1, 0.2);
    
    // NSString* myString;
    //  myString = [[NSString alloc] initWithData:imgdata encoding:NSASCIIStringEncoding];
    NSString *encodedStr   = [MF_Base64Codec base64StringFromData:imgdata];
    
    NSLog(@"encoded str=%@",encodedStr);
    
    
    
    //  parameter id
    
    
    NSString*user_id=[df objectForKey:@"user_id"];
    
    NSLog(@"gggbg----%@",user_id);
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"bookServiceId\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.bookserid dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload_by\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.uploadby dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"source\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"iphone" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"property_image\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
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
        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"!!!Congratulations!!!" message:@"Your service request has been submitted to the Seazoned provider that you chose.You will be notified shortly that the provider has accepted the request.Stay Seazoned" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
//        [alert show];
        
       // [df setObject:@"1" forKey:@"back_flag"];
        
       // [self.navigationController popViewControllerAnimated:YES];
       // [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
        [_delegate sendata];
        
   //     UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        [self removeAnimate];
        
    }
    
    else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[dic1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [self removeAnimate];
        
    }
    
    //[SVProgressHUD dismiss];
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
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
