//
//  Events.h
//  MySampleApp
//
//  Created by Massimo Moro on 19/02/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>
#import <UIKit/UIKit.h>


@interface Events : AWSDynamoDBObjectModel<AWSDynamoDBModeling>

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *StartDate;
@property (nonatomic, strong) NSDate *EndDate;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *DescriptionDE;
@property (nonatomic, strong) NSString *DescriptionES;
@property (nonatomic, strong) NSString *DescriptionFR;
@property (nonatomic, strong) NSString *DescriptionIT;
@property (nonatomic, strong) NSString *DescriptionRU;
@property (nonatomic, strong) NSString *DescriptionZH;
@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSString *ImageEvent1;
@property (nonatomic, strong) NSString *ImageEvent2;
@property (nonatomic, strong) NSString *ImageEvent3;
@property (nonatomic, strong) UIImage *ImageName;
@property (nonatomic, strong) NSString *isSlotEvents;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *memoDE;
@property (nonatomic, strong) NSString *memoES;
@property (nonatomic, strong) NSString *memoFR;
@property (nonatomic, strong) NSString *memoIT;
@property (nonatomic, strong) NSString *memoRU;
@property (nonatomic, strong) NSString *memoZH;
@property (nonatomic, strong) NSString *NameDE;
@property (nonatomic, strong) NSString *NameES;
@property (nonatomic, strong) NSString *NameFR;
@property (nonatomic, strong) NSString *NameIT;
@property (nonatomic, strong) NSString *NameRU;
@property (nonatomic, strong) NSString *NameZH;
@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong)UITableView *theTableView;

@end
