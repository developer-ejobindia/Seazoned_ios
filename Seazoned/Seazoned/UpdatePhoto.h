//
//  UpdatePhoto.h
//  Seazoned
//
//  Created by Student on 02/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePhoto : UIViewController
{
    IBOutlet UIView *pop_view;
    
    IBOutlet UIView *cancel_view;
    
    IBOutlet UIImageView *imgvw;
    
}

@property(strong,nonatomic) UIImagePickerController*camerapicker;
@property (nonatomic,strong) UIPopoverController *popoverGlobal;


@end
