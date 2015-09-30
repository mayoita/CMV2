//
//  CMVShowImage.h
//  CMV
//
//  Created by Massimo Moro on 23/04/13.
//  Copyright (c) 2013 Massimo Moro. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Parse/Parse.h>

@interface CMVShowImage : UIViewController <UIScrollViewDelegate>
//@property (strong, nonatomic) PFObject *object;
@property(nonatomic, strong) UIImage *largePhoto;
-(IBAction)done:(id) sender;

@end
