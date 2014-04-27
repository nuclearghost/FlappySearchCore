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
    
    NSManagedObjectContext *context = [StoreManagerCloud sharedStoreManagerCloud].managedObjectContext;
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Application"
                                                                      inManagedObjectContext:context];
    
    [newManagedObject setValue:[self.detailMO valueForKey:@"trackName"] forKey:@"name"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (IBAction)viewTapped:(id)sender {
    NSNumber *id = [self.detailMO valueForKey:@"trackId"];
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@", id];
    NSLog(@"%@", url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
