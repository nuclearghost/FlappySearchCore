//
//  DetailViewController.m
//  Flappy Favs
//
//  Created by Mark Meyer on 4/24/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.detailMO != nil) {
        NSData *pngData = [self.detailMO valueForKey:@"thumbpng"];
        self.iconImg.image = [UIImage imageWithData:pngData];
        
        self.titleLabel.text = [self.detailMO valueForKey:@"trackName"];
        
        self.descriptionText.text = [self.detailMO valueForKey:@"descript"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (IBAction)addTapped:(id)sender {
}

- (IBAction)viewTapped:(id)sender {
    NSNumber *id = [self.detailMO valueForKey:@"trackId"];
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@", id];
    NSLog(@"%@", url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
