//
//  CMVSharedClass.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 18/02/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVSharedClass.h"
#import <Parse/Parse.h>
#import "CMVAppDelegate.h"

@implementation CMVSharedClass


-(NSMutableArray *)retrieveObjects:(NSString *)className eventType:(int)eventChar office:(int)officeLocation tableView:(UITableView *)myTableView {
    
    
    PFQuery *query = [PFQuery queryWithClassName:className];
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network. https://parse.com/docs/ios_guide#queries-caching/iOS
    //BOOL isInCache = [query hasCachedResult];
    //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    
    NSArray *eventStrings = [CMVSharedClass eventTypeStrings];
    NSArray *officeString = [CMVSharedClass officeTypeString];
    NSString *eventType = eventStrings[eventChar];
    NSString *officeType = officeString[officeLocation];
    if (!([className  isEqual: @"Poker"] || [className  isEqual: @"Tournaments"])) {
        [query whereKey:@"eventType" containsString:eventType];
    }
    
    [query whereKey:@"office" equalTo:officeType];
    [query orderByDescending:@"StartDate"];
    
    NSMutableArray *allObjects = [NSMutableArray array];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            // Do something with the found objects
//            for (PFObject *object in objects) {
//                
//            }
            if ([allObjects count] == 0) {
                
                [allObjects addObjectsFromArray:objects];
             
                [myTableView reloadData];
                
                
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
   
    return allObjects;
}

-(NSMutableArray *)retrieveSlotsEvents:(NSString *)className eventType:(int)eventChar carousel:(iCarousel *) myCaraousel{
    
    
    PFQuery *query = [PFQuery queryWithClassName:className];
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network. https://parse.com/docs/ios_guide#queries-caching/iOS
    //BOOL isInCache = [query hasCachedResult];
    //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    
    NSArray *eventStrings = [CMVSharedClass eventTypeStrings];
    NSString *eventType = eventStrings[eventChar];
   
    
    [query whereKey:@"eventType" containsString:eventType];
    [query whereKey:@"isSlotsEvents" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"StartDate"];
    
    NSMutableArray *allObjects = [NSMutableArray array];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            // Do something with the found objects
//                        for (PFObject *object in objects) {
//                            
//                                PFFile *imageFile1=[object objectForKey:@"ImageEvent1"];
//                            if ([allObjects count] != [objects count]) {
//                                 [allObjects addObject:imageFile1];
//                            }
//                    
//                        }
            if ([allObjects count] == 0) {
                
                [allObjects addObjectsFromArray:objects];
                
                
            }
            [myCaraousel reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return allObjects;
}

+ (NSArray *)eventTypeStrings
{
    return @[@"E",@"A",@"T"];
}

+ (NSArray *)officeTypeString
{
    return @[@"VE",@"CN"];
}
@end
