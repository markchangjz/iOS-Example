//
//  ViewController.m
//  EventKit
//
//  Created by Mac on 13/10/29.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ViewController () <EKEventEditViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    

    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        /* iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE */
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if ( granted )
             {
                 NSLog(@"User has granted permission!");
             }
             else
             {
                 NSLog(@"User has not granted permission!");
             }
         }];
    }
    
    
    EKEventStore *store = [[EKEventStore alloc] init];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//    }];

    
    
    // 行事曆類型列表
    NSArray *arrayCalndars = [store calendarsForEntityType:EKEntityTypeEvent]; // In ios 6.o
    NSLog(@"%@", arrayCalndars);

    for (EKCalendar *calendar in arrayCalndars) {
        NSLog(@"%@", calendar.title);
    }
    
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    
    NSDate *startDate = [fmt dateFromString:@"2013/10/28 12:00"];
    NSDate *endDate   = [fmt dateFromString:@"2013/11/29 12:00"];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate
                                                                 endDate:endDate
                                                               calendars:nil];
    
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    
    NSLog(@"%@", events);
    
    for (EKEvent *ee in events) {
        NSLog(@"%@", ee.eventIdentifier);
    }
    
    

    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.calendar  = [eventStore defaultCalendarForNewEvents];
    event.title     = @"/dev/world/2011";
    event.location  = @"Melbourne";
    event.notes     = @"AUC Developer Conference";
    event.startDate = startDate;
    event.endDate   = endDate;
    event.allDay    = YES;

    [eventStore saveEvent:event span:EKSpanThisEvent error:nil];

    NSLog(@"%@", [[NSString alloc] initWithFormat:@"%@", event.eventIdentifier]);
}

-(void)eventEditViewController:(EKEventEditViewController *)controller
         didCompleteWithAction:(EKEventEditViewAction)action {
    
    switch (action) {
        case EKEventEditViewActionCanceled:
            // User tapped "cancel"
            break;
        case EKEventEditViewActionSaved:
            // User tapped "save"
            break;
        case EKEventEditViewActionDeleted:
            // User tapped "delete"
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)eventViewController:(EKEventViewController *)controller didCompleteWithAction:(EKEventViewAction)action
{
    NSLog(@"No se que esta pasando aqui!");
}

- (IBAction)addEvent:(id)sender
{

    EKEventStore *eventStore = [[EKEventStore alloc] init];

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    
    NSDate *startDate = [fmt dateFromString:@"2014/01/07 14:00"];
    NSDate *endDate   = [fmt dateFromString:@"2014/01/09 10:00"];
    
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.calendar  = [eventStore defaultCalendarForNewEvents];
    event.title     = @"活動名稱";
    event.location  = @"活動地點";
    event.notes     = @"其他訊息";
    event.startDate = startDate;
    event.endDate   = endDate;
    
    EKEventEditViewController *controller = [[EKEventEditViewController alloc] init];
    
    controller.eventStore       = eventStore;
    controller.event            = event;
    controller.editViewDelegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
     
    
    /*
    EKEventStore* store = [[EKEventStore alloc] init];
    EKEvent* event2 = [store eventWithIdentifier:str];
    if (event2 != nil) {
        NSError* error = nil;
        [store removeEvent:event2 span:EKSpanThisEvent error:&error];
    }
    */
}

@end
