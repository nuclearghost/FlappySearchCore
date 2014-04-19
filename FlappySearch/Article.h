//
//  Article.h
//  FlappySearch
//
//  Created by Mark Meyer on 4/18/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSArray *categories;

@end
