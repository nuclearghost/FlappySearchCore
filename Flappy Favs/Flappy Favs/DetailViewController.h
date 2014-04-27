//
//  DetailViewController.h
//  Flappy Favs
//
//  Created by Mark Meyer on 4/24/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreManagerCloud.h"

@interface DetailViewController : UIViewController
- (IBAction)closeTapped:(id)sender;
- (IBAction)addTapped:(id)sender;
- (IBAction)viewTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *screenShotImg;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (strong, nonatomic) NSManagedObject *detailMO;

@end
