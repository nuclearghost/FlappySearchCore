//
//  DataViewController.m
//  FlappySearch
//
//  Created by Mark Meyer on 4/18/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "DataViewController.h"


@interface DataViewController ()

@end

@implementation DataViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *url = [NSString
                     stringWithFormat:@"https://itunes.apple.com/search?term=flappy&media=software&limit=200"];
    
    NSLog(@"url:%@",url);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url]
                                 completionHandler:^(NSData *data,
                                                     NSURLResponse *response,
                                                     NSError *error) {
                                     
                                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                     
                                     NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                                     
                                     if (httpResp.statusCode == 200) {
                                         NSError *jsonError;
                                         
                                         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                                         
                                         NSLog(@"dictioanry Data:%@", dictionary);
                                         
                                         NSArray *results = [dictionary objectForKey:@"results"];
                                         
                                         NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
                                         NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes: [NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
                                         
                                         AppDelegate *appDelegate =
                                         [[UIApplication sharedApplication] delegate];
                                         
                                         NSManagedObjectContext *context =
                                         [appDelegate managedObjectContext];
                                         
                                         NSManagedObject *newResult;
                                         NSError *error;
                                         
                                         for (int i = 0; i < results.count; ++i) {
                                             NSDictionary *result = [results objectAtIndex:i];
                                             
                                             newResult = [NSEntityDescription
                                                          insertNewObjectForEntityForName:@"Result"
                                                          inManagedObjectContext:context];
                                             
                                             [newResult setValue: [result objectForKey:@"trackName"] forKey:@"trackName"];
                                             [newResult setValue: [result objectForKey:@"artistId"] forKey:@"artistId"];
                                             [newResult setValue: [result objectForKey:@"artistName"] forKey:@"artistName"];
                                             [newResult setValue: [result objectForKey:@"artistViewUrl"] forKey:@"artistViewUrl"];
                                             [newResult setValue: [result objectForKey:@"artworkUrl60"] forKey:@"artworkUrl60"];
                                             [newResult setValue: [result objectForKey:@"artworkUrl100"] forKey:@"artworkUrl100"];
                                             [newResult setValue: [result objectForKey:@"artworkUrl512"] forKey:@"artworkUrl512"];
                                             [newResult setValue: [result objectForKey:@"averageUserRating"] forKey:@"averageUserRating"];
                                             [newResult setValue: [result objectForKey:@"averageUserRating"] forKey:@"averageUserRating"];
                                             [newResult setValue: [result objectForKey:@"averageUserRatingForCurrentVersion"] forKey:@"averageUserRatingForCurrentVersion"];
                                             [newResult setValue: [result objectForKey:@"contentAdvisoryRating"] forKey:@"contentAdvisoryRating"];
                                             [newResult setValue: [result objectForKey:@"currency"] forKey:@"currency"];
                                             [newResult setValue: [result objectForKey:@"fileSizeBytes"] forKey:@"fileSizeBytes"];
                                             [newResult setValue: [result objectForKey:@"formattedPrice"] forKey:@"formattedPrice"];
                                             [newResult setValue: [result objectForKey:@"averageUserRatingForCurrentVersion"] forKey:@"averageUserRatingForCurrentVersion"];
                                             [newResult setValue: [result objectForKey:@"isGameCenterEnabled"] forKey:@"isGameCenterEnabled"];
                                             [newResult setValue: [result objectForKey:@"price"] forKey:@"price"];
                                             [newResult setValue: [result objectForKey:@"averageUserRatingForCurrentVersion"] forKey:@"averageUserRatingForCurrentVersion"];
                                             [newResult setValue: [result objectForKey:@"primaryGenreId"] forKey:@"primaryGenreId"];
                                             [newResult setValue: [result objectForKey:@"primaryGenreName"] forKey:@"primaryGenreName"];
                                             [newResult setValue: [result objectForKey:@"releaseDate"] forKey:@"releaseDate"];
                                             [newResult setValue: [result objectForKey:@"releaseNotes"] forKey:@"releaseNotes"];
                                             [newResult setValue: [result objectForKey:@"sellerName"] forKey:@"sellerName"];
                                             [newResult setValue: [result objectForKey:@"trackCensoredName"] forKey:@"trackCensoredName"];
                                             [newResult setValue: [result objectForKey:@"trackId"] forKey:@"trackId"];
                                             [newResult setValue: [result objectForKey:@"trackName"] forKey:@"trackName"];
                                             [newResult setValue: [result objectForKey:@"trackViewUrl"] forKey:@"trackViewUrl"];
                                             [newResult setValue: [result objectForKey:@"userRatingCount"] forKey:@"userRatingCount"];
                                             [newResult setValue: [result objectForKey:@"userRatingCountForCurrentVersion"] forKey:@"userRatingCountForCurrentVersion"];
                                             [newResult setValue: [result objectForKey:@"version"] forKey:@"version"];
                                             [newResult setValue: [result objectForKey:@"wrapperType"] forKey:@"wrapperType"];
                                             
                                             [newResult setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"artworkUrl512"]]] forKey:@"thumbpng"];
                                             
                                             //Tagging area
                                             NSString *descrption = [result objectForKey:@"description"];
                                             NSMutableString *tags = [[NSMutableString alloc] init];
                                             [newResult setValue:descrption forKey:@"descript"];
                                             tagger.string = descrption;
                                             [tagger enumerateTagsInRange:NSMakeRange(0, [descrption length])
                                                                   scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
                                                                  options:options
                                                               usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                                                                   NSString *token = [descrption substringWithRange:tokenRange];
                                                                   //NSLog(@"%@: %@", token, tag);
                                                                   if ([tag isEqualToString:@"Noun"] ||
                                                                       [tag isEqualToString:@"Adjective"] ||
                                                                       [tag isEqualToString:@"PersonalName"] ||
                                                                       [tag isEqualToString:@"OrganizationName"])
                                                                   {
                                                                       [tags appendFormat:@"%@ ", token];
                                                                   }
                                                               }];
                                             
                                             [newResult setValue:tags forKey:@"tags"];
                                             
                                         }
                                         [context save:&error];

                                         //dispatch_async(dispatch_get_main_queue(), ^{
                                         //   successCompletion(array,nil);
                                         //});
                                     } else {
                                         NSLog(@"Get Shops Failed: Not 200");
                                         /*
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                          if (failureCompletion) failureCompletion();
                                          });
                                          */
                                     }
                                 }] resume];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnTapped:(id)sender {
    [self fetchData];
}

- (IBAction)getTapped:(id)sender {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Result"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    self.label.text = [NSString stringWithFormat:@"Count: %lu", (unsigned long)objects.count];
    
    if ([objects count] == 0) {
    } else {
        matches = objects[0];
        NSString *tags = [matches valueForKey:@"tags"];
        NSLog(@"%@", tags);
    }
}
@end
