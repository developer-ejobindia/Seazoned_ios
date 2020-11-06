//
//  SendMoney.m
//  DemoDsgn
//
//  Created by os4ed on 3/6/17.
//  Copyright © 2017 os4ed. All rights reserved.
//

#import "SendMoney.h"
//#import "paypalViewController.h"
#import "PayPal.h"
#import "PayPalPayment.h"
#import "PayPalAdvancedPayment.h"
#import "PayPalAmounts.h"
#import "PayPalReceiverAmounts.h"
#import "PayPalAddress.h"
#import "PayPalInvoiceItem.h"
//#import "WebService.h"
//#import "homeViewController.h"
#import "SVProgressHUD.h"
//#import "WebService.h"
#define SPACING 3.
@interface SendMoney ()

{

    IBOutlet UIView *view_hidden;

}

@end

@implementation SendMoney
@synthesize STR_KEY;
- (void)viewDidLoad {
    [super viewDidLoad];
      _indicator.hidden=YES;

    // Do any additional setup after loading the view.
    
    [self showAnimate];
    self.view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.0];
    
    view_succ.clipsToBounds=YES;
    view_cancell.clipsToBounds=YES;
    con_view1.clipsToBounds=YES;
    con_view2.clipsToBounds=YES;
    con_view1.layer.cornerRadius=con_view1.frame.size.height/2;
    con_view2.layer.cornerRadius=con_view1.frame.size.height/2;
    view_succ.layer.cornerRadius=6;
    view_cancell.layer.cornerRadius=6;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = con_view1.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:19.0/255.0 green:192.0/255.0 blue:155.0/255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.0/255.0 green:236.0/255.0 blue:182.0/255.0 alpha:1.0].CGColor];
    
    
    
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    
    [con_view1.layer insertSublayer:gradient atIndex:0];
    [con_view2.layer insertSublayer:gradient atIndex:0];
    
 //   [self pay:nil];
    
         [self loadpay:STR_KEY];
    
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

-(IBAction)call:(id)sender
{


}

-(IBAction)click:(id)sender   //after paymentsection
{




}


//#pragma mark -
//#pragma mark Utility methods
//
//- (void)addLabelWithText:(NSString *)text andButtonWithType:(PayPalButtonType)type withAction:(SEL)action {
//    UIFont *font = [UIFont boldSystemFontOfSize:14.];
//    CGSize size = [text sizeWithFont:font];
//
//    //you should call getPayButton to have the library generate a button for you.
//    //this button will be disabled if device interrogation fails for any reason.
//    //
//    //-- required parameters --
//    //target is a class which implements the PayPalPaymentDelegate protocol.
//    //action is the selector to call when the button is clicked.
//    //inButtonType is the button type (desired size).
//    //
//    //-- optional parameter --
//    //inButtonText can be either BUTTON_TEXT_PAY (default, displays "Pay with PayPal"
//    //in the button) or BUTTON_TEXT_DONATE (displays "Donate with PayPal" in the
//    //button). the inButtonText parameter also affects some of the library behavior
//    //and the wording of some messages to the user.
//    UIButton *button = [[PayPal getPayPalInst] getPayButtonWithTarget:self andAction:action andButtonType:type];
//    CGRect frame = button.frame;
//    frame.origin.x = round((self.view.frame.size.width - button.frame.size.width) / 2.);
//    frame.origin.y = round(y + size.height);
//    button.frame = frame;
//    [self.view addSubview:button];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, y, size.width, size.height)];
//    label.font = font;
//    label.text = text;
//    label.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:label];
//
//    y += size.height + frame.size.height + SPACING;
//}
//
//- (UITextField *)addTextFieldWithPlaceholder:(NSString *)placeholder {
//    CGFloat width = 294.;
//    CGFloat x = round((self.view.frame.size.width - width) / 2.);
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, 30.)] ;
//    textField.placeholder = placeholder;
//    textField.font = [UIFont systemFontOfSize:14.];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.delegate = self;
//    textField.keyboardType = UIKeyboardTypeDefault;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [self.view addSubview:textField];
//
//    y += 30. + SPACING;
//
//    return textField;
//}
//
//- (void)addAppInfoLabel {
//    NSString *text = [NSString stringWithFormat:@"Library Version: %@\nDemo App Version: %@",
//                      [PayPal buildVersion], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
//    UIFont *font = [UIFont systemFontOfSize:14.];
//    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(round((self.view.frame.size.width - size.width) / 2.), y, size.width, size.height)] ;
//    label.font = font;
//    label.text = text;
//    label.textAlignment = UITextAlignmentCenter;
//    label.numberOfLines = 0;
//    label.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:label];
//}
//
//
//- (void)loadView {
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] ;
//    self.view.autoresizesSubviews = FALSE;
//    UIColor *color = [UIColor groupTableViewBackgroundColor];
//    if (CGColorGetPattern(color.CGColor) == NULL) {
//        color = [UIColor lightGrayColor];
//    }
//    self.view.backgroundColor = color;
//    self.title = @"Simple Demo";
//
//    status = PAYMENTSTATUS_CANCELED;
//
//    // ios7 layout bug fix
//    if ([self respondsToSelector:NSSelectorFromString(@"setEdgesForExtendedLayout:")]) {
//        [self setValue:@(0) forKey:@"edgesForExtendedLayout"];
//    }
//
//    y = 2.;
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake((self.view.frame.size.width - 125), 2, 75, 25);
//
//    [button setTitle:@"Retry Init" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(RetryInitialization) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//
//
//    [self addLabelWithText:@"Parallel Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(parallelPayment)];
//
//
//    [self addAppInfoLabel];
//}


- (void)parallelPayment {
    //dismiss any native keyboards
   // [preapprovalField resignFirstResponder];
  //  [WebService alertview:@"fff"];
    //optional, set shippingEnabled to TRUE if you want to display shipping
    //options to the user, default: TRUE
    [PayPal getPayPalInst].shippingEnabled = true;
    [PayPal getPayPalInst].delegate=self;
    //optional, set dynamicAmountUpdateEnabled to TRUE if you want to compute
    //shipping and tax based on the user's address choice, default: FALSE
    [PayPal getPayPalInst].dynamicAmountUpdateEnabled = false;

    //optional, choose who pays the fee, default: FEEPAYER_EACHRECEIVER
//   [PayPal getPayPalInst].feePayer = FEEPAYER_EACHRECEIVER;
      [PayPal getPayPalInst].feePayer = FEEPAYER_SENDER;
    //for a payment with multiple recipients, use a PayPalAdvancedPayment object
    PayPalAdvancedPayment *payment = [[PayPalAdvancedPayment alloc] init] ;
    payment.paymentCurrency = @"USD";

    // A payment note applied to all recipients.
    payment.memo = @"A Note applied to all recipients";

    //receiverPaymentDetails is a list of PPReceiverPaymentDetails objects
    payment.receiverPaymentDetails = [NSMutableArray array];

    //Frank's Robert's Julie's Bear Parts;

    NSString *str_txt=self.str_price;
    float ddd=[str_txt floatValue ];
    
    float per=[self.str_percentage floatValue];

    float com=ddd* per/100;
    //zackshumidors@gmail.com
   // for (int i = 1; i <= 3; i++) {
        PayPalReceiverPaymentDetails *details = [[PayPalReceiverPaymentDetails alloc] init] ;
        details.paymentType=TYPE_NOT_SET;
       details.recipient=self.str_adminemailid;// admin paypal email id
    details.merchantName=@"convenience fee";
 //   dwipen.ejobindia@gmail.com
  //  details.recipient=@"dwipen.ejobindia@gmail.com";// admin paypal email id

        details.description=@"Commission payment";
         details.subTotal =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",com]];


    float pa=ddd-com;

    PayPalReceiverPaymentDetails *details1 = [[PayPalReceiverPaymentDetails alloc] init] ;
    details1.paymentType=TYPE_NOT_SET;
    details1.recipient=self.str_landscaperemailid;//paypal_id receiver email id
     details1.merchantName=@"Seazoned";
 //   details1.recipient=@"pinki._1340955413_per@gmail.com";//paypal_id receiver email id

    details1.description=@"Service Payment";
    details1.subTotal =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",pa]];
        // Customize the payment notes for one of the three recipient.
//        if (i == 2) {
//            details.description = [NSString stringWithFormat:@"Bear Component %d", i];
//        }

//        details.recipient = [NSString stringWithFormat:@"example-merchant-%d@paypal.com", 4 - i];
//        details.merchantName = [NSString stringWithFormat:@"%@ Bear Parts",[nameArray objectAtIndex:i-1]];
//
//        unsigned long long order, tax, shipping;
//        order = i * 100;
//        tax = i * 7;
//        shipping = i * 14;

        //subtotal of all items for this recipient, without tax and shipping
      //  details.subTotal = [NSDecimalNumber decimalNumberWithMantissa:order exponent:-2 isNegative:FALSE];

        //invoiceData is a PayPalInvoiceData object which contains tax, shipping, and a list of PayPalInvoiceItem objects
//        details.invoiceData = [[PayPalInvoiceData alloc] init] ;
//        details.invoiceData.totalShipping = [NSDecimalNumber decimalNumberWithMantissa:shipping exponent:-2 isNegative:FALSE];
//        details.invoiceData.totalTax = [NSDecimalNumber decimalNumberWithMantissa:tax exponent:-2 isNegative:FALSE];
//
//        //invoiceItems is a list of PayPalInvoiceItem objects
//        //NOTE: sum of totalPrice for all items must equal details.subTotal
//        //NOTE: example only shows a single item, but you can have more than one
//        details.invoiceData.invoiceItems = [NSMutableArray array];
//        PayPalInvoiceItem *item = [[PayPalInvoiceItem alloc] init] ;
//        item.totalPrice = details.subTotal;
//        item.name = @"Bear Stuffing";
//        [details.invoiceData.invoiceItems addObject:item];
//
    [payment.receiverPaymentDetails addObject:details1];
    [payment.receiverPaymentDetails addObject:details];
   // }

    [[PayPal getPayPalInst] advancedCheckoutWithPayment:payment];
}



- (IBAction)pay:(id)sender {
   //  [self parallelPayment];
    

    NSString * str_pay = [NSString stringWithFormat:@"Pay $%@",self.str_price];
    NSLog(@"%@",self.str_landscaperemailid);
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"Confirm Payment" message:@"Do you want to pay now?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:str_pay style:UIAlertActionStyleDefault handler:^(UIAlertAction*  _Nonnull action) {
          //  NSLog(@"Changed Value %@", [[alerController textFields][0] text]);
            //compare the current password and do action here


            [self parallelPayment];
        }];

        [alerController addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*  _Nonnull action) {
            NSLog(@"Canelled");
            [self removeAnimate];
        }];
        [alerController addAction:cancelAction];
        [self presentViewController:alerController animated:YES completion:nil];
   
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
#pragma mark -
#pragma mark PayPalPaymentDelegate methods

-(void)RetryInitialization
{
    [PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];

     //[PayPal initializeWithAppID:@"APP-2Y378622S4663890K" forEnvironment:ENV_LIVE];

    //DEVPACKAGE
    //    [PayPal initializeWithAppID:@"your live app id" forEnvironment:ENV_LIVE];
    //    [PayPal initializeWithAppID:@"anything" forEnvironment:ENV_NONE];
}

//paymentSuccessWithKey:andStatus: is a required method. in it, you should record that the payment
//was successful and perform any desired bookkeeping. you should not do any user interface updates.
//payKey is a string which uniquely identifies the transaction.
//paymentStatus is an enum value which can be STATUS_COMPLETED, STATUS_CREATED, or STATUS_OTHER
- (void)paymentSuccessWithKey:(NSString *)payKey andStatus:(PayPalPaymentStatus)paymentStatus {
    NSString *severity = [[PayPal getPayPalInst].responseMessage objectForKey:@"severity"];
    NSLog(@"severity: %@", severity);
    NSString *category = [[PayPal getPayPalInst].responseMessage objectForKey:@"category"];
    NSLog(@"category: %@", category);
    NSString *errorId = [[PayPal getPayPalInst].responseMessage objectForKey:@"errorId"];
    NSLog(@"errorId: %@", errorId);
    NSString *message = [[PayPal getPayPalInst].responseMessage objectForKey:@"message"];
    NSLog(@"message: %@", message);
    STR_KEY=[NSString stringWithFormat:@"%@",payKey];

    // [self.navigationController pushViewController:[[homeViewController alloc] init]  animated:TRUE];
    status = PAYMENTSTATUS_SUCCESS;
}

//paymentFailedWithCorrelationID is a required method. in it, you should
//record that the payment failed and perform any desired bookkeeping. you should not do any user interface updates.
//correlationID is a string which uniquely identifies the failed transaction, should you need to contact PayPal.
//errorCode is generally (but not always) a numerical code associated with the error.
//errorMessage is a human-readable string describing the error that occurred.
- (void)paymentFailedWithCorrelationID:(NSString *)correlationID {

    NSString *severity = [[PayPal getPayPalInst].responseMessage objectForKey:@"severity"];
    NSLog(@"severity: %@", severity);
    NSString *category = [[PayPal getPayPalInst].responseMessage objectForKey:@"category"];
    NSLog(@"category: %@", category);
    NSString *errorId = [[PayPal getPayPalInst].responseMessage objectForKey:@"errorId"];
    NSLog(@"errorId: %@", errorId);
    NSString *message = [[PayPal getPayPalInst].responseMessage objectForKey:@"message"];
    NSLog(@"message: %@", message);

    status = PAYMENTSTATUS_FAILED;
}

//paymentCanceled is a required method. in it, you should record that the payment was canceled by
//the user and perform any desired bookkeeping. you should not do any user interface updates.
- (void)paymentCanceled {
    status = PAYMENTSTATUS_CANCELED;
}

-(void)show1
{

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

   visualeffectview = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    [visualeffectview setFrame:self.view.bounds];

    [self.view addSubview:visualeffectview];



    // Vibrancy effect

    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];

    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];

    [vibrancyEffectView setFrame:self.view.bounds];

    [self.view addSubview:view_cancell];

    view_cancell.center=self.view.center;





    view_cancell.transform=CGAffineTransformMakeScale(1.3, 1.3);



    view_cancell.alpha=0;





    [UIView animateWithDuration:0.4 animations:^{



        //visualeffectview.effect=effect;






        view_cancell.alpha=1;



        view_cancell.transform=CGAffineTransformIdentity;







    }];


}
-(void)show
{

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    visualeffectview = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    [visualeffectview setFrame:self.view.bounds];

    [self.view addSubview:visualeffectview];



    // Vibrancy effect

    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];

    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];

    [vibrancyEffectView setFrame:self.view.bounds];


    [self.view addSubview:view_succ];

    view_succ.center=self.view.center;


    view_succ.transform=CGAffineTransformMakeScale(1.3, 1.3);



    view_succ.alpha=0;





    [UIView animateWithDuration:0.4 animations:^{



        //visualeffectview.effect=effect;






        view_succ.alpha=1;



        view_succ.transform=CGAffineTransformIdentity;







    }];


}
//paymentLibraryExit is a required method. this is called when the library is finished with the display
//and is returning control back to your app. you should now do any user interface updates such as
//displaying a success/failure/canceled message.
- (void)paymentLibraryExit {
    UIAlertView *alert = nil;
    switch (status) {



        case PAYMENTSTATUS_SUCCESS:

            lbl_transaction_id.text=[NSString stringWithFormat:@"%@",STR_KEY];

            //[self show];

            [SVProgressHUD showWithStatus:@"Payment Processing..."];
            [self loadpay:STR_KEY];




         //   [self pay:STR_KEY];
//             alert =[[UIAlertView alloc] initWithTitle:@"Payment sucessfull"
//                                       message:@"nil"
//                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

           //  NSLog(@"======%@",STR_KEY);
         //  [WebService alertview:STR_KEY];


//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//            homeViewController *obj=[s instantiateViewControllerWithIdentifier:@"home"];
//            [self.navigationController pushViewController:obj animated:YES];

         // [self.navigationController pushViewController:[[homeViewController alloc] init]  animated:TRUE];


            break;
        case PAYMENTSTATUS_FAILED:
            alert = [[UIAlertView alloc] initWithTitle:@"Payment failed"
                                               message:@"nil"
                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            break;
        case PAYMENTSTATUS_CANCELED:
            [self show1];
//            alert = [[UIAlertView alloc] initWithTitle:@"Payment canceled"
//                                               message:nil
//                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            break;
    }
    [alert show];

}

//adjustAmountsForAddress:andCurrency:andAmount:andTax:andShipping:andErrorCode: is optional. you only need to
//provide this method if you wish to recompute tax or shipping when the user changes his/her shipping address.
//for this method to be called, you must enable shipping and dynamic amount calculation on the PayPal object.
//the library will try to use the advanced version first, but will use this one if that one is not implemented.
- (PayPalAmounts *)adjustAmountsForAddress:(PayPalAddress const *)inAddress andCurrency:(NSString const *)inCurrency andAmount:(NSDecimalNumber const *)inAmount
                                    andTax:(NSDecimalNumber const *)inTax andShipping:(NSDecimalNumber const *)inShipping andErrorCode:(PayPalAmountErrorCode *)outErrorCode {
    //do any logic here that would adjust the amount based on the shipping address
    PayPalAmounts *newAmounts = [[PayPalAmounts alloc] init] ;
    newAmounts.currency = @"USD";
    newAmounts.payment_amount = (NSDecimalNumber *)inAmount;

    //change tax based on the address
    if ([inAddress.state isEqualToString:@"CA"]) {
        newAmounts.tax = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",[inAmount floatValue] * .1]];
    } else {
        newAmounts.tax = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",[inAmount floatValue] * .08]];
    }
    newAmounts.shipping = (NSDecimalNumber *)inShipping;

    //if you need to notify the library of an error condition, do one of the following
    //*outErrorCode = AMOUNT_ERROR_SERVER;
    //*outErrorCode = AMOUNT_CANCEL_TXN;
    //*outErrorCode = AMOUNT_ERROR_OTHER;

    return newAmounts;
}


//adjustAmountsAdvancedForAddress:andCurrency:andReceiverAmounts:andErrorCode: is optional. you only need to
//provide this method if you wish to recompute tax or shipping when the user changes his/her shipping address.
//for this method to be called, you must enable shipping and dynamic amount calculation on the PayPal object.
//the library will try to use this version first, but will use the simple one if this one is not implemented.
- (NSMutableArray *)adjustAmountsAdvancedForAddress:(PayPalAddress const *)inAddress andCurrency:(NSString const *)inCurrency
                                 andReceiverAmounts:(NSMutableArray *)receiverAmounts andErrorCode:(PayPalAmountErrorCode *)outErrorCode {
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:[receiverAmounts count]];
    for (PayPalReceiverAmounts *amounts in receiverAmounts) {
        //leave the shipping the same, change the tax based on the state
        if ([inAddress.state isEqualToString:@"CA"]) {
            amounts.amounts.tax = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",[amounts.amounts.payment_amount floatValue] * .1]];
        } else {
            amounts.amounts.tax = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",[amounts.amounts.payment_amount floatValue] * .08]];
        }
        [returnArray addObject:amounts];
    }

    //if you need to notify the library of an error condition, do one of the following
    //*outErrorCode = AMOUNT_ERROR_SERVER;
    //*outErrorCode = AMOUNT_CANCEL_TXN;
    //*outErrorCode = AMOUNT_ERROR_OTHER;

    return returnArray;
}

//-(IBAction)home:(id)sender
//{
//    [visualeffectview removeFromSuperview];
//    [UIView animateWithDuration:0.4 animations:^{
//
//
//        view_succ.transform=CGAffineTransformMakeScale(1.3, 1.3);
//
//        view_succ.alpha=1;
//
//
//        //visualeffectview.effect=nil;
//
//
//
//
//
//    }];
//
//
//
//    [view_succ removeFromSuperview];
//
////    [SVProgressHUD showWithStatus:@"Payment Processing..."];
////    [self loadpay:STR_KEY];
//
//}

//-(IBAction)home_cancell:(id)sender
//{
//    [visualeffectview removeFromSuperview];
//    [UIView animateWithDuration:0.4 animations:^{
//
//       view_cancell.transform=CGAffineTransformMakeScale(1.3, 1.3);
//
//       view_cancell.alpha=1;
//
//        //visualeffectview.effect=nil;
//
//    }];
//
//    [view_cancell removeFromSuperview];
//}


//-(void)payment:(NSString*)paykey
//{
//
//    [SVProgressHUD show];
////http://192.168.1.2:8080/mytippingpal/api/payment?sender_id=1
//   // &receiver_id=2&amount=100&paypal_txn_id=txn001
//    NSMutableDictionary*data_dic=[[NSMutableDictionary alloc]init];
//
//    [data_dic setObject:self.order_id forKey:@"order_id"];
//    [data_dic setObject:self.order_no  forKey:@"order_no"];
//    [data_dic setObject:self.str_price forKey:@"landscaper_amount"];
//    [data_dic setObject:paykey forKey:@"payKey"];
//    //  NSDictionary *json = [responseObject objectFromJSONString];
//    //NSString *str_url=[NSString stringWithFormat:@"%@%@",BASE_URL,transaction1];
//    NSString *str_url=@"http://192.168.1.2:8080/dev/seazonedapp/public/api/pay-using-paypal";
//
//    //NSString *str_url=@"http://103.230.103.142:8080/dev/seazonedapp/public/api/pay-using-paypal";
//    [WEBSERVICE postRequest:str_url param:data_dic success:^(id responseObject) {
//        [SVProgressHUD dismiss];
//        NSDictionary *json = [responseObject objectFromJSONString];
//
//        NSString *str=[json objectForKey:@"success"];
//        //  [WebService alertview:str];
//
//        int succ=[str intValue];
//        if (succ==1) {
//
//             [WebService alertview:[json objectForKey:@"status"]];
//
//            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
//            [df setObject:[self.dic objectForKey:@"sender_id"] forKey:@"uid"];
//            [df setObject:[self.dic objectForKey:@"sys_id"] forKey:@"sys_id"];
//
//            [df setObject:[self.dic objectForKey:@"paypal_id"] forKey:@"name"];
//            // [WebService alertview:[json objectForKey:@"status"]];
//
//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//              homeViewController *obj=[s instantiateViewControllerWithIdentifier:@"home"];
//            [self.navigationController pushViewController:obj animated:YES];
//        }
//
//        else
//        {
//            [WebService alertview:[json objectForKey:@"status"]];
//
//        }
//    }
//                    failure:^(NSError *error) {
//                        [SVProgressHUD dismiss];
//
//                        [WebService alertview:@"Network Problem"];
//
//                    }];
//
//
//
//
//}

-(void)loadpay:(NSString*)paykey
{
    
    
    NSDate *currentDate = [NSDate date] ;
    
    NSLog(@"%@", currentDate) ;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init ] ;
    formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss z" ;
    NSDate *date1 = [formatter1 dateFromString: [NSString stringWithFormat:@"%@", currentDate]] ;
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init ] ;
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss" ;
    NSString *str_result = [formatter2 stringFromDate:date1] ;
    
    NSLog(@"%@", str_result) ;
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    NSString * str_token = [df valueForKey:@"token"];
    
  //  NSString *url = [NSString stringWithFormat:@"http://192.168.1.2:8080/dev/seazonedapp/public/api/pay-using-paypal?"];
  //   NSString *url = @"http://103.230.103.142:8080/dev/seazonedapp/public/api/pay-using-paypal?";
    
    NSString *url = @"http://seazoned.com/api/pay-using-paypal?";

   // http://seazoned.com/api
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:str_token forHTTPHeaderField:@"token"];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
   
    
    //  parameter id
    
    NSString*user_id=[df objectForKey:@"user_id"];
    
    NSLog(@"gggbg----%@",user_id);
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"payKey\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[paykey dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"landscaper_amount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.str_price dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"admin_amount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"20.00" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"order_no\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.order_no dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"order_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self.order_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"payment_time\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[str_result dataUsingEncoding:NSUTF8StringEncoding]];
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
    NSString *msg=[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"msg"]];
    if ([succ isEqualToString:@"1"]) {
        
        //[self load_Profile];
        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//
//        [self.navigationController popViewControllerAnimated:YES];
//        //[self removeAnimate];
        [self show];
        [SVProgressHUD dismiss];
        
    }
    
    else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [self removeAnimate];
        [SVProgressHUD dismiss];
        
    }
    
    //[SVProgressHUD dismiss];
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (IBAction)btncontinue1:(id)sender {
    
        [visualeffectview removeFromSuperview];
        [UIView animateWithDuration:0.4 animations:^{
    
           view_cancell.transform=CGAffineTransformMakeScale(1.3, 1.3);
    
           view_cancell.alpha=1;
    
            //visualeffectview.effect=nil;
    
        }];
    
        [view_cancell removeFromSuperview];
    
    [self removeAnimate];
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
    
}

- (IBAction)btncontinue2:(id)sender
{
    
    [visualeffectview removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        
        
        view_succ.transform=CGAffineTransformMakeScale(1.3, 1.3);
        
        view_succ.alpha=1;
        
        
        //visualeffectview.effect=nil;
        
        
        
        
        
    }];
    
    
    
    [view_succ removeFromSuperview];
    
    [self removeAnimate];
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
    
}

@end

