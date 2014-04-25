//
//  DataViewController.h
//  FlappySearch
//
//  Created by Mark Meyer on 4/18/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DataViewController : UIViewController

- (IBAction)btnTapped:(id)sender;
- (IBAction)getTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
