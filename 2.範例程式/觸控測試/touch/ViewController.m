//
//  ViewController.m
//  touch
//
//  Created by EE Lab on 12/6/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize myView;
@synthesize touchPosition;
@synthesize lbl1;
@synthesize lbl2;
@synthesize lbl3;

CGFloat redColor = 0.0, greenColor = 0.0, blueColor = 0.0;  

- (void)viewDidLoad
{
    [super viewDidLoad];
    touchPosition.layer.masksToBounds = YES;
    touchPosition.layer.cornerRadius = 25;
    [touchPosition removeFromSuperview];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyView:nil];
    [self setLbl1:nil];
    [self setTouchPosition:nil];
    [self setLbl2:nil];
    [self setLbl3:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    int count = [[event allTouches] count];  
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:myView];
    [touchPosition setCenter:CGPointMake(location.x, location.y)];
    [myView addSubview:touchPosition];
    
    NSString *listPoints = @"";
    
    
    
    for (int i = 0; i < [[event allTouches] count]; i++) {
        UITouch *manyTouch = [[touches allObjects] objectAtIndex:i];
        CGPoint manyLocation = [manyTouch locationInView:myView];
        
        NSString *x = [NSString stringWithFormat:@"%f", manyLocation.x];
        int intX = [x intValue];
        NSString *y = [NSString stringWithFormat:@"%f", manyLocation.y];
        int intY = [y intValue];
        
        listPoints = [listPoints stringByAppendingFormat:@"%d -> (%03d, %03d) \n", i + 1, intX, intY];
        
    }  
    
        
    lbl1.text = [NSString stringWithFormat:@"點選座標 (%.1f, %.1f)", location.x, location.y];
    lbl2.text = [NSString stringWithFormat:@"觸控點數 %d", count];
    lbl3.text = listPoints;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    int count = [touches count];          
    
    switch (count) {
        case 1:
            redColor = (redColor > 1) ? 0 : redColor + 0.03;
            break;
        case 2:
            greenColor = (greenColor > 1) ? 0 : greenColor + 0.03;
            break;
        case 3:
            blueColor = (blueColor > 1) ? 0 : blueColor + 0.03;
            break;
    }
    
    myView.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0];
 

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touchPosition removeFromSuperview];
    lbl3.text = @"";
}

@end
