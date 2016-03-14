//
//  CMVHomeViewController.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 23/09/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVHomeViewController.h"
#import <Parse/Parse.h>
#import "DVOMarqueeView.h"
#import "CMVSetUpCurrency.h"
#import "CMVAppDelegate.h"
#import "CMVCheckWeekDay.h"
#import "CMVLocalize.h"
#import "CMVGradientForNews.h"
#import "CMVArrowChat.h"


#define VE 0
#define CN 1


@interface CMVHomeViewController (){
    DVOMarqueeView *labelMarquee;
}
@property (weak, nonatomic) IBOutlet UILabel *jackpot;

@property (weak, nonatomic) IBOutlet UILabel *labelJackpot;

@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UILabel *chatWithUs;
@property (weak, nonatomic) IBOutlet CMVArrowChat *arrowChat;


@property(strong,nonatomic)UILabel *labelMarqueeText;
@property(strong,nonatomic)DVOMarqueeView *labelMarquee;


@property(strong,nonatomic)UIButton *lockerButton;
@property (nonatomic,strong)CMVDataClass *site;


@property(strong,nonatomic)CMVSetUpCurrency *checkCurrency;
@end

@implementation CMVHomeViewController
@synthesize labelMarquee;
int Office;
BOOL VeSaPr = 0;
PFObject *storageFestivity;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStorageFestivity];
    [self setOffHelper];
    self.chatWithUs.layer.cornerRadius = 4.0;
    self.chatWithUs.layer.masksToBounds = YES;
    
    self.site=[CMVDataClass getInstance];
    
    
 
    
    UIImage *myGradient = [UIImage imageNamed:@"JackpotColorPattern"];
    self.labelJackpot.textColor   = [UIColor colorWithPatternImage:myGradient];
    if (iPAD) {
        self.jackpot.font=GOTHAM_Thin(53);
        self.labelJackpot.font=GOTHAM_XLight(45);
        self.today.font=GOTHAM_Medium(15);
    } else {
        self.jackpot.font=GOTHAM_Thin(43);
        self.labelJackpot.font=GOTHAM_XLight(40);
        self.today.font=GOTHAM_Medium(10);
    }
    //Init currency rates
    
    self.checkCurrency=[[CMVSetUpCurrency alloc] init];
    [self.checkCurrency exchangeRates];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Jackpot"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if ( ![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    
    [query getObjectInBackgroundWithId:@"ykIRbhqKUn" block:^(PFObject *gameScore, NSError *error) {
        self.jackpot.text=gameScore[@"jackpot"];
        self.jackpot.text=[self.checkCurrency setupCurrency:self.jackpot.text];
    }];
    
    self.mainTabBarController = (CMVMainTabbarController *)self.tabBarController;
    [self.mainTabBarController setCenterButtonDelegate:self];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        //[self addLabelMarquee];
    }
}

-(void)setOffHelper {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"contactUs"]) {
        self.chatWithUs.hidden = YES;
        self.arrowChat.hidden = YES;
        [userDefaults setBool:NO forKey:@"contactUs"];
        [userDefaults synchronize];
    } else {
        [userDefaults setBool:YES forKey:@"contactUs"];
        [userDefaults synchronize];
    }
    
}

-(void)loadFestivity:(NSString *)todayOpen andVSP:(NSString *)vsp{
  
 
        
        for (id object in storageFestivity[@"festivity"]) {
            
            if ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == [object[0] intValue] && [[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == [object[1] intValue]) {
                VeSaPr=1;
            }
        }
        
        [self checkWeekDAy:todayOpen andVSP:vsp];
   
}

-(void)loadStorageFestivity {
     PFQuery *queryFestivity = [PFQuery queryWithClassName:@"Festivity"];
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network. https://parse.com/docs/ios_guide#queries-caching/iOS
    //BOOL isInCache = [query hasCachedResult];
    //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [queryFestivity setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [queryFestivity setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    

    [queryFestivity getObjectInBackgroundWithId:@"7VTo3n7rum" block:^(PFObject *festivityarray, NSError *error) {
        if (!error) {
             storageFestivity = festivityarray;
        }
       
        
       
    }];
    
    
}

-(void)checkWeekDAy:(NSString *)todayOpen andVSP:(NSString *)vsp{
    
    if ([[CMVCheckWeekDay checkWeekDAy][@"month"] intValue] == 12 && (([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 24) || ([[CMVCheckWeekDay checkWeekDAy][@"day"] intValue] == 25))) {
        self.today.text=NSLocalizedString(@"Today is closed", @"");
    } else {
        if (([[CMVCheckWeekDay checkWeekDAy][@"weekday"] intValue] == 7) || VeSaPr) {
            self.today.text=todayOpen;
        } else {
            self.today.text=vsp;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateChat];
    NSString *value=@"";
    if ([CMVDataClass getInstance].location == VENEZIA) {
        value=@"HomeCN";
    } else {
        value=@"HomeVE";
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:value];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [self.mainTabBarController setCenterButtonDelegate:self];
    [self setOffice];
}

-(void)animateChat {
    //Animation
    [UIView animateWithDuration:3.5 delay:0 usingSpringWithDamping:0.05 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        
        self.chatWithUs.center=CGPointMake(self.chatWithUs.center.x, self.chatWithUs.center.y - 5);
        self.arrowChat.center=CGPointMake(self.arrowChat.center.x, self.arrowChat.center.y - 5);
    }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.chatWithUs.alpha = 0.0;
                         }
                          ];
                         [UIView animateWithDuration:1.0 animations:^(void) {
                             self.arrowChat.alpha = 0.0;
                         }
                          ];
                         
                     }];
}

- (void)addLabelMarquee
{
    
    self.labelMarqueeText=[UILabel new];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    [query getObjectInBackgroundWithId:@"PGGDgYmTik" block:^(PFObject *object, NSError *error) {
        
        switch ([CMVLocalize myDeviceLocaleIs]) {
            case IT :
                self.labelMarqueeText.text=object[@"NewsIT"];
                break;
            case DE :
                self.labelMarqueeText.text=object[@"NewsDE"];
                break;
            case FR :
                self.labelMarqueeText.text=object[@"NewsFR"];
                break;
            case ES :
                self.labelMarqueeText.text=object[@"NewsES"];
                break;
            case RU  :
                self.labelMarqueeText.text=object[@"NewsRU"];
                break;
            case ZH:
                self.labelMarqueeText.text=object[@"NewsZH"];
                break;
                
            default:
                self.labelMarqueeText.text=object[@"News"];
                break;
        }
        
        self.labelMarqueeText.textColor=[UIColor whiteColor];
        [ self.labelMarqueeText sizeToFit];
        
        labelMarquee = [[DVOMarqueeView alloc] initWithFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y -35, CGRectGetWidth(self.view.bounds), 30)];
        labelMarquee.viewToScroll =  self.labelMarqueeText;
        CMVGradientForNews *gradient=[[CMVGradientForNews alloc] initWithFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y -35, CGRectGetWidth(self.view.bounds), 30)];
        self.labelMarquee=labelMarquee;
        [self.view addSubview:labelMarquee];
        [self.view addSubview:gradient];
        
        [labelMarquee beginScrolling];
        
    }];
    
}

-(void)refreshLabelMarquee {
    self.labelMarqueeText.text=@"";
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    if (![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    [query getObjectInBackgroundWithId:@"PGGDgYmTik" block:^(PFObject *object, NSError *error) {
        
        switch ([CMVLocalize myDeviceLocaleIs]) {
            case IT :
                
                self.labelMarqueeText.text=object[@"NewsIT"];
                break;
            case DE :
                self.labelMarqueeText.text=object[@"NewsDE"];
                break;
            case FR :
                self.labelMarqueeText.text=object[@"NewsFR"];
                break;
            case ES :
                self.labelMarqueeText.text=object[@"NewsES"];
                break;
            case RU  :
                self.labelMarqueeText.text=object[@"NewsRU"];
                break;
            case ZH:
                self.labelMarqueeText.text=object[@"NewsZH"];
                break;
                
            default:
                self.labelMarqueeText.text=object[@"News"];
                
                break;
        }
        [self.labelMarqueeText sizeToFit];
        self.labelMarquee.viewToScroll =  self.labelMarqueeText;
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [self refreshLabelMarquee];
}



- (IBAction)openHelp:(id)sender {
    [self infoButtonPress:@"HelpSfhift"];
  
    [[Helpshift sharedInstance] showConversation:self withOptions:nil];
    //[[Helpshift sharedInstance] showFAQs:self
                            // withOptions:@{@"enableContactUs":@"ALWAYS"}];
    
}

-(void)infoButtonPress:(NSString *)type{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"INFORMATION"
                                                          action:@"press"
                                                           label:type
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}

#pragma mark - Center button delegate
-(void)centerButtonAction:(UIButton *)sender {
    
    [self setOffice];
    
}

-(void)setOffice {
    if (self.site.location == VENEZIA) {
        Office=CN;
        [self.homeImage setImage:[UIImage imageNamed:@"HomeBackgroundCaNoghera.png"]];
        self.tabBarController.tabBar.tintColor=BRAND_GREEN_COLOR;
        [self loadFestivity:NSLocalizedString(@"Today open 11:00 am - 03:45 am",nil) andVSP:NSLocalizedString(@"Today open 11:00 am - 03:15 am",nil)];
    } else {
        Office=VE;
        [self.homeImage setImage:[UIImage imageNamed:@"HomeBackgroundVenezia.png"]];
        self.tabBarController.tabBar.tintColor=BRAND_RED_COLOR;
        [self loadFestivity:NSLocalizedString(@"Today open 11.00 am - 03.15 am",nil) andVSP:NSLocalizedString(@"Today open 11:00 am - 02:45 am",nil)];
    }
}



@end
