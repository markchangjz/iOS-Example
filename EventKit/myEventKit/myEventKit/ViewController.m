//
//  ViewController.m
//  Events
//
//  Created by JzChang on 13/10/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ViewController () <EKEventEditViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) NSMutableDictionary *events;  // 不同類型行事曆中的事件 (EKCalendar.calendarIdentifier => 包裝多個 EKEvent)
@property (nonatomic, strong) NSArray *calendars;           // 不同類型的行事曆      (包裝多個 EKCalendar)

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Events";
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self
                                      action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                  action:@selector(addEvent:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.eventStore = [[EKEventStore alloc] init];
    
    // 存取行事曆權限
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent
                                    completion:^(BOOL granted, NSError *error) {
                                        if (granted) {
                                            [self _fetchEvents];
                                        }
                                        else {
                                            NSLog(@"Access not granted: %@", error);
                                        }
                                    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleEnterForeground:)
                                                 name:@"UIApplicationWillEnterForegroundNotification"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIApplicationWillEnterForegroundNotification"
                                                  object:nil];
    
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refresh:self];
    
    [super viewWillAppear:animated];
}

- (void)_fetchEvents
{
    self.calendars = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    self.events = [[NSMutableDictionary alloc] initWithCapacity:[self.calendars count]];

    for (EKCalendar *calendar in self.calendars) {
        NSPredicate *allEventsPredicate = [self.eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeIntervalSinceNow:- 2 * (60.0 * 60.0 * 24.0) * 365.0]
                                                                                   endDate:[NSDate distantFuture]
                                                                                 calendars:@[calendar]];
        
        NSArray *eventsInThisCalendar = [self.eventStore eventsMatchingPredicate:allEventsPredicate];
        
        if (eventsInThisCalendar) {
            [self.events setObject:eventsInThisCalendar forKey:calendar.calendarIdentifier];
        }
    }
    
    // because the fetchEvents is invoked on an arbitrary thread and any user interface−related code must be run on the main thread
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView reloadData];
    });
}

- (EKCalendar *)_calendarAtSection:(NSInteger)section
{
    return self.calendars[section];
}

- (EKEvent *)_eventAtIndexPath:(NSIndexPath *)indexPath
{
    EKCalendar *calendar = [self _calendarAtSection:indexPath.section];
    NSArray *calendarEvents = [self _eventsForCalendar:calendar];
    return [calendarEvents objectAtIndex:indexPath.row];
}

- (NSArray *)_eventsForCalendar:(EKCalendar *)calendar
{
    return [self.events objectForKey:calendar.calendarIdentifier];
}

-(EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
    return [self.eventStore defaultCalendarForNewEvents];
}

#pragma mark - selector

- (void)refresh:(id)sender
{
    [self _fetchEvents];
    [self.tableView reloadData];
}

- (void)addEvent:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"選擇要新增的行事曆類型"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    for (EKCalendar *calendar in self.calendars) {
        [actionSheet addButtonWithTitle:calendar.title];
    }
    
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.cancelButtonIndex = self.calendars.count;
    [actionSheet showInView:self.view];
}

- (void)handleEnterForeground:(NSNotification*)notification
{
    [self refresh:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.calendars count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    EKCalendar *calendar = [self _calendarAtSection:section];
    return [self _eventsForCalendar:calendar].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self _calendarAtSection:section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Calendar Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self _eventAtIndexPath:indexPath].title;
    
    NSDateFormatter *df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[self _eventAtIndexPath:indexPath].timeZone];
    [df_local setDateFormat:@"HH:mm:ss"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ~ %@", [df_local stringFromDate:[self _eventAtIndexPath:indexPath].startDate], [df_local stringFromDate:[self _eventAtIndexPath:indexPath].endDate]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EKEventViewController *eventVC = [[EKEventViewController alloc] init];
    eventVC.event = [self _eventAtIndexPath:indexPath];
    eventVC.allowsEditing = YES;
    [self.navigationController pushViewController:eventVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EKEventEditViewController *eventEditVC = [[EKEventEditViewController alloc] init];
    eventEditVC.event = [self _eventAtIndexPath:indexPath];
    eventEditVC.eventStore = self.eventStore;
    eventEditVC.editViewDelegate = self;
    [self presentViewController:eventEditVC animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EKEvent *deleteEvent = [self _eventAtIndexPath:indexPath];
        [self.eventStore removeEvent:deleteEvent span:EKSpanThisEvent error:nil];
        [self _fetchEvents];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        return;
    }
    
    EKCalendar *selectedCalendar = self.calendars[buttonIndex];
    
    if (selectedCalendar.allowsContentModifications) {
        EKEvent *event  = [EKEvent eventWithEventStore:self.eventStore];
        event.calendar = selectedCalendar;
        
        EKEventEditViewController *eventEditVC = [[EKEventEditViewController alloc] init];
        
        eventEditVC.eventStore       = self.eventStore;
        eventEditVC.event            = event;
        eventEditVC.editViewDelegate = self;
        
        [self presentViewController:eventEditVC animated:YES completion:nil];
    }
    else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"警告"
                                                             message:@"選擇的行事曆類型無法修改"
                                                            delegate:nil
                                                   cancelButtonTitle:@"好"
                                                   otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - EKEventEditViewDelegate

-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    switch (action)
    {
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

@end
