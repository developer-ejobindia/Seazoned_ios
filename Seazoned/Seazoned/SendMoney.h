//
//  SendMoney.h
//  DemoDsgn
//
//  Created by os4ed on 3/6/17.
//  Copyright © 2017 os4ed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"
typedef enum PaymentStatuses {
    PAYMENTSTATUS_SUCCESS,
    PAYMENTSTATUS_FAILED,
    PAYMENTSTATUS_CANCELED,
} PaymentStatus;

@interface SendMoney : UIViewController < UIAlertViewDelegate,UITextFieldDelegate,PayPalPaymentDelegate>
{
    IBOutlet UIButton *pay_btn,*r_2,*r_5,*r_10;
    
    
    UIVisualEffectView   * visualeffectview;
    IBOutlet UILabel *lbl_transaction_id;
    IBOutlet UIView *view_succ,*view_cancell;
    IBOutlet UILabel *lbl_desc;
    
    IBOutlet   UIButton *pop_btn,*pop_btn_cancel;
    IBOutlet UIView *pop_view;
    IBOutlet UILabel *a_v;
    
    IBOutlet UIView *top_view;
    
    IBOutlet UITextField *rcvr_idtxt;
    IBOutlet UIView *main_view;
    
    
    IBOutlet UIImageView *imgvw;
    
    IBOutlet UILabel *name_txt;
    
    IBOutlet UILabel *rcvr_idlbl;
    
    IBOutlet UILabel *lbl_dollr;
    
    IBOutlet UIView *vw_two;
    
    IBOutlet UIView *vw_five;
    
    IBOutlet UIView *vw_ten;
    
    IBOutlet UIView *money_vw;
    
    IBOutlet UITextField *txt_dollr;
    
    IBOutlet UIView *send_vw;
    
   
    @private
        UITextField *preapprovalField;
        CGFloat y;
        BOOL resetScrollView;
        PaymentStatus status;
    
    
    
    __weak IBOutlet UIView *con_view1;
    
    __weak IBOutlet UIView *con_view2;
    

    
   
    
    
    
}

- (IBAction)btncontinue1:(id)sender;
- (IBAction)btncontinue2:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, retain) UITextField *preapprovalField;
@property(strong,nonatomic)NSString *str_data_transfer_flag;
@property(strong,nonatomic) NSDictionary *dic,*dic1;
@property(strong,nonatomic)NSString*str_adminemailid,*str_percentage,*str_landscaperemailid,*str_price,*order_id,*order_no, *STR_KEY;
@end

