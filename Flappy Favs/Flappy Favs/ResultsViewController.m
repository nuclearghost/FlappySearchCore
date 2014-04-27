//
//  ResultsViewController.m
//  Flappy Favs
//
//  Created by Mark Meyer on 4/21/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

static NSString *CellIdentifier = @"Cell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Result"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    return [objects count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Result"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    NSManagedObject *matches = nil;
    
    if ([objects count] >= indexPath.row) {
        matches = objects[indexPath.row];
        //NSString *tags = [matches valueForKey:@"tags"];
        NSData *pngData = [matches valueForKey:@"thumbpng"];
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
        imgView.image = [UIImage imageWithData:pngData];
        
        UILabel *labelView = (UILabel *)[cell viewWithTag:101];
        labelView.text = [matches valueForKey:@"trackName"];
        
        collectionBtn *btn = (collectionBtn *)[cell viewWithTag:102];
        btn.detailMO = matches;
        
        [btn addTarget:self action:@selector(respondToTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(void)respondToTapGesture:(id)sender
{
    NSLog(@"Tapped");
    [self performSegueWithIdentifier:@"ModalSegue" sender:sender];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ModalSegue"]){
        DetailViewController *dvc = (DetailViewController*)segue.destinationViewController;
        collectionBtn *btn = (collectionBtn *)sender;
        dvc.detailMO = btn.detailMO;
    }
}

@end
