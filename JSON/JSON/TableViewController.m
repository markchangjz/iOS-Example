//
//  TableViewController.m
//  JSON
//
//  Created by Mac on 2014/2/7.
//  Copyright (c) 2014年 KKBOX. All rights reserved.
//

#import "TableViewController.h"

static NSString *kCellIdentifier = @"Cell";
NSString *const KTXEventsURL = @"http://reg.kktix.com/api/v1/events.json";

@interface TableViewController () <NSURLSessionDelegate>
{
	NSMutableArray *events;
	NSUInteger total_pages, current_page, per_page;
	NSURLSession *URLSession;
	NSOperationQueue *operationQueue;
	NSURLSessionDataTask *task;
}

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		per_page = 20;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];

	operationQueue = [[NSOperationQueue alloc] init];
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	config.allowsCellularAccess = YES;
	config.timeoutIntervalForRequest = 60.0;
	URLSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:operationQueue];

	[self _loadEventsDataFromServerStartPage:1 andPerPage:per_page];
}

#pragma mark - Private function

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	[task cancel];
}

- (void)_loadEventsDataFromServerStartPage:(NSUInteger)inPage andPerPage:(NSUInteger)inPerPage
{
	if (!events) {
		events = [[NSMutableArray alloc] init];
	}

//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		NSString *eventsURL = [NSString stringWithFormat:@"%@?page=%d&per_page=%d&order_by=start_at_asc", KTXEventsURL, inPage, inPerPage];
//		NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:eventsURL]];
//		id APIResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//		[events addObjectsFromArray:APIResponse[@"data"]];
//		total_pages = [APIResponse[@"total_pages"] unsignedIntegerValue];
//		current_page = [APIResponse[@"current_page"] unsignedIntegerValue];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			[self.tableView reloadData];
//		});
//	});

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?page=%d&per_page=%d&order_by=start_at_asc", KTXEventsURL, inPage, inPerPage]]];
	task = [URLSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		id APIResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		[events addObjectsFromArray:APIResponse[@"data"]];
		total_pages = [APIResponse[@"total_pages"] unsignedIntegerValue];
		current_page = [APIResponse[@"current_page"] unsignedIntegerValue];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	}];
	[task resume];


//	total_count,
//	data,
//	total_pages,
//	per_page,
//	current_page
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];

	cell.textLabel.text = [NSString stringWithFormat:@"%ld) %@", indexPath.row + 1, events[indexPath.row][@"name"]];

	if (indexPath.row + 1 == events.count && current_page < total_pages) {
		[self _loadEventsDataFromServerStartPage:current_page + 1 andPerPage:per_page];
	}

    return cell;
}

@end
