//
//  Events.m
//  MySampleApp
//
//  Created by Massimo Moro on 19/02/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Events.h"
#import "AWSConfiguration.h"
#import <AWSS3/AWSS3.h>
@interface Events() {
    BOOL imUno;
    BOOL imDue;
    BOOL imTre;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation Events

-(id)init{
    self = [super init];
    if (self) {
        self.dateFormatter = [NSDateFormatter new];
        self.dateFormatter.dateStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.timeStyle = kCFDateFormatterShortStyle;
        self.dateFormatter.locale = [NSLocale currentLocale];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];

    }
    return self;
}


+ (NSString *)dynamoDBTableName {
    return @"Events";
}

+ (NSString *)hashKeyAttribute {
    return @"Name";
}
+ (NSString *)rangeKeyAttribute {
    return @"StartDate";
}

-(NSDate *)StartDate {
    
    return [self.dateFormatter dateFromString:_StartDate];;
}
-(NSDate *)EndDate {
    
    return [self.dateFormatter dateFromString:_EndDate];;
}
-(UIImage *)ImageName {
    if (_ImageName) {
      
        
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_ImageName];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        downloadRequest.bucket = S3BucketName;
        downloadRequest.key = _ImageName;
        
        downloadRequest.downloadingFileURL = downloadingFileURL;
        if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
            // Download the file.
            [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                   withBlock:^id(AWSTask *task) {
                                                                       if (task.error){
                                                                           if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                               switch (task.error.code) {
                                                                                   case AWSS3TransferManagerErrorCancelled:
                                                                                   case AWSS3TransferManagerErrorPaused:
                                                                                       break;
                                                                                       
                                                                                   default:
                                                                                       NSLog(@"Error: %@", task.error);
                                                                                       break;
                                                                               }
                                                                           } else {
                                                                               // Unknown error.
                                                                               NSLog(@"Error: %@", task.error);
                                                                           }
                                                                       }
                                                                       
                                                                       if (task.result) {
                                                                           AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               [self.theTableView reloadData];
                                                                           });
                                                                           
                                                                       }
                                                                       return nil;
                                                                   }];
        }
        
        
        return [UIImage imageWithContentsOfFile:downloadingFilePath];
   
    }

    return _ImageName;
}

-(UIImage *)ImageEvent1 {
    if (!imUno) {
    if ([_ImageEvent1 isKindOfClass:[NSString class]]) {
        
        imUno =YES;
        if ([(NSString *)_ImageEvent1 isEqualToString:@"NULL"]) {
            return nil;
        }
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_ImageEvent1];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        downloadRequest.bucket = S3BucketName;
        downloadRequest.key = _ImageEvent1;
        
        downloadRequest.downloadingFileURL = downloadingFileURL;
        if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
            // Download the file.
            [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                   withBlock:^id(AWSTask *task) {
                                                                       if (task.error){
                                                                           if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                               switch (task.error.code) {
                                                                                   case AWSS3TransferManagerErrorCancelled:
                                                                                   case AWSS3TransferManagerErrorPaused:
                                                                                       break;
                                                                                       
                                                                                   default:
                                                                                       NSLog(@"Error: %@", task.error);
                                                                                       break;
                                                                               }
                                                                           } else {
                                                                               // Unknown error.
                                                                               NSLog(@"Error: %@", task.error);
                                                                           }
                                                                       }
                                                                       
                                                                       if (task.result) {
                                                                           AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                           _ImageEvent1 = [UIImage imageWithContentsOfFile:downloadingFilePath];
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               [self.imK reloadData];
                                                                           });
                                                                           
                                                                       }
                                                                       return nil;
                                                                   }];
        }
        
        
        return [UIImage imageWithContentsOfFile:downloadingFilePath];
        
    }
    }
    return _ImageEvent1;
}
-(UIImage *)ImageEvent2 {
    if (!imDue) {
    if ([_ImageEvent2 isKindOfClass:[NSString class]]) {
        
        imDue =YES;
        if ([(NSString *)_ImageEvent2 isEqualToString:@"NULL"]) {
            return nil;
        }
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_ImageEvent2];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        downloadRequest.bucket = S3BucketName;
        downloadRequest.key = _ImageEvent2;
        
        downloadRequest.downloadingFileURL = downloadingFileURL;
        if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
            // Download the file.
            [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                   withBlock:^id(AWSTask *task) {
                                                                       if (task.error){
                                                                           if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                               switch (task.error.code) {
                                                                                   case AWSS3TransferManagerErrorCancelled:
                                                                                   case AWSS3TransferManagerErrorPaused:
                                                                                       break;
                                                                                       
                                                                                   default:
                                                                                       NSLog(@"Error: %@", task.error);
                                                                                       break;
                                                                               }
                                                                           } else {
                                                                               // Unknown error.
                                                                               NSLog(@"Error: %@", task.error);
                                                                           }
                                                                       }
                                                                       
                                                                       if (task.result) {
                                                                           AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                           _ImageEvent2 = [UIImage imageWithContentsOfFile:downloadingFilePath];
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               [self.imK reloadData];
                                                                           });
                                                                       }
                                                                       return nil;
                                                                   }];
        }
        
        
        return [UIImage imageWithContentsOfFile:downloadingFilePath];
        
    }
    }
    return _ImageEvent2;
}
-(UIImage *)ImageEvent3 {
    if (!imTre) {
        if ([_ImageEvent3 isKindOfClass:[NSString class]]) {
            imTre =YES;
            if ([(NSString *)_ImageEvent3 isEqualToString:@"NULL"]) {
                return nil;
            }
            

            AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
            AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
            
            NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:_ImageEvent3];
            NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
            downloadRequest.bucket = S3BucketName;
            downloadRequest.key = _ImageEvent3;
            
            downloadRequest.downloadingFileURL = downloadingFileURL;
            if ([UIImage imageWithContentsOfFile:downloadingFilePath] == nil) {
                // Download the file.
                [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                                       withBlock:^id(AWSTask *task) {
                                                                           if (task.error){
                                                                               if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                                   switch (task.error.code) {
                                                                                       case AWSS3TransferManagerErrorCancelled:
                                                                                       case AWSS3TransferManagerErrorPaused:
                                                                                           break;
                                                                                           
                                                                                       default:
                                                                                           NSLog(@"Error: %@", task.error);
                                                                                           break;
                                                                                   }
                                                                               } else {
                                                                                   // Unknown error.
                                                                                   NSLog(@"Error: %@", task.error);
                                                                               }
                                                                           }
                                                                           
                                                                           if (task.result) {
                                                                               AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                               _ImageEvent2 = [UIImage imageWithContentsOfFile:downloadingFilePath];
                                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                   [self.imK reloadData];
                                                                               });
                                                                           }
                                                                           return nil;
                                                                       }];
            }
            
            
            return [UIImage imageWithContentsOfFile:downloadingFilePath];
            
        }
    }
    return _ImageEvent3;
}
@end
