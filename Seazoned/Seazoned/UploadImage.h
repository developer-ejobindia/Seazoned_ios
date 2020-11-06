//
//  UploadImage.h
//  Seazoned
//
//  Created by Apple on 22/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadImagedelegate <NSObject>

-(void)sendata;
@end


@interface UploadImage : UIViewController
@property(strong,nonatomic) UIImage * img;
@property(strong,nonatomic) NSString * bookserid;
@property(strong,nonatomic) NSString * uploadby;
@property(strong,nonatomic) NSString * msg;
@property (nonatomic,retain) id<UploadImagedelegate> delegate;

@end
