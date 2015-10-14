//
//  ViewController.m
//  GCD
//
//  Created by Mac on 2014/1/28.
//  Copyright (c) 2014年 KKBOX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 參考網址:
// http://www.slideshare.net/cqtt191/grand-dispatch-central
// http://www.cnblogs.com/sunfrog/p/3313424.html
// http://www.hrchen.com/2013/07/multi-threading-programming-of-ios-part-3/
// http://psvsps2.blogspot.tw/2010/04/gcd.html
// http://blog.sina.com.cn/s/blog_7b9d64af0101c75e.html
// http://iosbasicprogramming.blogspot.tw/2013/03/grand-central-dispatch.html

- (void)viewDidLoad
{
    [super viewDidLoad];

//	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//	dispatch_group_t group = dispatch_group_create();
//
//	dispatch_group_async(group, queue, ^{
//		for (int i = 1; i <= 10; i++) {
//			NSLog(@"執行 Block_1 (%2d)", i);
//		}
//
//	});
//
//	dispatch_group_async(group, queue, ^{
//		for (int i = 1; i <= 10; i++) {
//			NSLog(@"執行 Block_2 (%2d)", i);
//		}
//	});
//
//	dispatch_group_notify(group, queue, ^{
//		// WAIT for all of them to complete.
//		NSLog(@"group 中所有的 queue 執行動作都結束");
//	});






//	dispatch_semaphore_t sem = dispatch_semaphore_create(10);
//
//	dispatch_queue_t queue = dispatch_queue_create("zenny_chen_firstQueue", nil);
//	dispatch_async(queue, ^(void) {
//		int sum = 0;
//		for(int i = 0; i < 100; i++)
//			sum += i;//myArray[i];
//		NSLog(@"The sum is: %d", sum);
//
//		while (true) {
//			NSLog(@"1");
//		}
//
//		// signal the semaphore
//		dispatch_semaphore_signal(sem);
//	});
//
//	dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);




	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (int i = 1; i <= 2; ++i)
	{
		dispatch_async(queue, ^{
			NSLog(@"(%d)wait %ld", i, dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER));
			[array addObject:[NSNumber numberWithInt:i]];
			NSLog(@"(%d)array : %@", i, array);
			NSLog(@"(%d)signal %ld", i, dispatch_semaphore_signal(semaphore));
		});
	}




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
