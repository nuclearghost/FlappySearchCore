//
//  FavoritesTableViewController.h
//  Flappy Favs
//
//  Created by Mark Meyer on 4/26/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreManagerCloud.h"

@interface FavoritesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
