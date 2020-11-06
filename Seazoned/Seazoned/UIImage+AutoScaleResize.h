//
//  UIImage+AutoScaleResize.h
//  precession
//
//Copyright (c) 2014 StudentKafe. All rights reserved.//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface UIImage_AutoScaleResize : UIImage
+ (UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *) imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
@end
