//
//  ViewController.m
//  AirPrint
//
//  Created by Mac on 13/10/28.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "ViewController.h"
#import "PageRenderer.h"

@interface ViewController () <UIPrintInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *ticketOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketPriceLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Private Function

- (NSString *)_generateHtmlCode:(NSDictionary *)inTicketMap
{
    NSString *htmlTemplate = [[NSString alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ticketTemplate.html"]
                                                             encoding:NSUTF8StringEncoding
                                                                error:nil];
    
    NSLog(@"%@", inTicketMap[@"QRCodeImagePath"]);
    
    return [NSString stringWithFormat:htmlTemplate, inTicketMap[@"QRCodeImagePath"], inTicketMap[@"ticketOrder"], inTicketMap[@"ticketName"], inTicketMap[@"ticketPrice"]];
}

#pragma mark - IBAction

- (IBAction)tapPrintHtml:(UIBarButtonItem *)sender
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = self.title;
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printInfo.orientation = UIPrintInfoOrientationPortrait;
    pic.printInfo = printInfo;
    
    NSString *QRCodeImagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/QRCode.png"];
    [UIImagePNGRepresentation(self.QRCodeImageView.image) writeToFile:QRCodeImagePath atomically:YES];
    
    NSMutableDictionary *ticketData = [[NSMutableDictionary alloc] init];
    ticketData[@"QRCodeImagePath"] = QRCodeImagePath;
    ticketData[@"ticketOrder"]     = self.ticketOrderLabel.text;
    ticketData[@"ticketName"]      = self.ticketNameLabel.text;
    ticketData[@"ticketPrice"]     = self.ticketPriceLabel.text;
    
    UIMarkupTextPrintFormatter *markupTextPF = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:[self _generateHtmlCode:ticketData]];

    pic.printFormatter = markupTextPF;
    pic.showsPageRange = YES;
    
    [pic presentAnimated:YES
       completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
           if (!completed && (error != nil)) {
               NSLog(@"Error Printing: %@", error);
           }
           else {
               NSLog(@"Printing Cancelled");
           }
       }];
}

- (IBAction)tapPrint:(UIBarButtonItem *)sender
{
    if ([UIPrintInteractionController isPrintingAvailable]) {
        UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = self.title;
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printInfo.orientation = UIPrintInfoOrientationPortrait;
        pic.printInfo = printInfo;
        
        UISimpleTextPrintFormatter *simpleText = [[UISimpleTextPrintFormatter alloc] initWithText:@"KKTIX"];
        
        PageRenderer *pageRenderer = [[PageRenderer alloc] init];
        pageRenderer.printData = [[NSMutableDictionary alloc] init];
        
        pageRenderer.printData = @{@"ticketOrder": self.ticketOrderLabel.text,
                                   @"ticketName" : self.ticketNameLabel.text,
                                   @"ticketPrice": self.ticketPriceLabel.text,
                                   @"QRCodeImage": self.QRCodeImageView.image};

        pageRenderer.headerHeight = 72.0 / 2;
        pageRenderer.footerHeight = 72.0 / 2;
        [pageRenderer addPrintFormatter:simpleText startingAtPageAtIndex:0];
        
        pic.printPageRenderer = pageRenderer;
        pic.showsPageRange = YES;
        
        [pic presentAnimated:YES
           completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
               if (!completed && (error != nil)) {
                   NSLog(@"Error Printing: %@", error);
               }
               else {
                   NSLog(@"Printing Cancelled");
               }
           }];
    }
}

@end
