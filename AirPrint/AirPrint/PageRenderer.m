//
//  SendItOutPageRenderer.m
//  AirPrint
//
//  Created by Mac on 13/10/29.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "PageRenderer.h"
//#import "UIImageResizing.h"
#import "UIImage+Resizing.h"

@implementation PageRenderer

- (void)drawHeaderForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)headerRect
{
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:12.0];
    CGSize titleSize = [@"票卷" sizeWithFont:font];
    CGFloat drawXTitle = CGRectGetMaxX(headerRect) - titleSize.width;
    CGFloat drawXCompany = CGRectGetMinX(headerRect);
    CGFloat drawY = CGRectGetMinY(headerRect);
    
    [@"票卷" drawAtPoint:CGPointMake(drawXTitle, drawY) withFont:font];
    [@"KKTIX" drawAtPoint:CGPointMake(drawXCompany, drawY) withFont:font];
}

- (void)drawFooterForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)footerRect
{
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSString *pageNumber = [NSString stringWithFormat:@"%d", pageIndex + 1];
    CGSize pageNumSize = [pageNumber sizeWithFont:font];
    CGFloat drawX = CGRectGetMaxX(footerRect) / 2.0 - pageNumSize.width;
    CGFloat drawY = CGRectGetMaxY(footerRect) - pageNumSize.height;
    CGPoint drawPoint = CGPointMake(drawX, drawY);
    
    [pageNumber drawAtPoint:drawPoint withFont:font];
}

- (void)drawPrintFormatter:(UIPrintFormatter *)printFormatter forPageAtIndex:(NSInteger)pageIndex
{
    if (pageIndex == 0) {
        CGSize QRCodeImageSize = CGSizeMake(150, 150);
        NSUInteger drawStartY = 50;
        NSUInteger padding = 20;
        NSUInteger drawNextY;
        NSUInteger drawImageY = 50;
        
        // QRCodeImage
        UIImage *QRCodeImage = [UIImage imageFromImage:self.printData[@"QRCodeImage"] scaledToSize:QRCodeImageSize];
        [QRCodeImage drawAtPoint:CGPointMake((self.printableRect.size.width - QRCodeImage.size.width) / 2 + self.printableRect.origin.x, drawImageY)];
        drawNextY = drawStartY + QRCodeImageSize.height + padding;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        UIFont *font = [UIFont fontWithName:@"Noteworthy-Bold" size:30];
        NSDictionary *stringAttributes = @{NSFontAttributeName: font,
                                           NSForegroundColorAttributeName: [UIColor grayColor],
                                           NSParagraphStyleAttributeName: paragraphStyle};
        
        // ticketOrderString
        NSAttributedString *ticketOrderString = [[NSAttributedString alloc] initWithString:self.printData[@"ticketOrder"] attributes:stringAttributes];
        CGSize ticketOrderTextSize = [self _stringTextSize:self.printData[@"ticketOrder"] andFont:font];
        [ticketOrderString drawInRect:CGRectMake((self.printableRect.size.width - ticketOrderTextSize.width) / 2 + self.printableRect.origin.x , drawNextY, self.printableRect.size.width, ticketOrderTextSize.height)];
        drawNextY += ticketOrderTextSize.height + padding;
        
        // ticketNameString
        NSAttributedString *ticketNameString = [[NSAttributedString alloc] initWithString:self.printData[@"ticketName"] attributes:stringAttributes];
        CGSize ticketNameTextSize = [self _stringTextSize:self.printData[@"ticketName"] andFont:font];
        [ticketNameString drawInRect:CGRectMake((self.printableRect.size.width - ticketNameTextSize.width) / 2 + self.printableRect.origin.x, drawNextY, self.printableRect.size.width, ticketNameTextSize.height)];
        drawNextY += ticketNameTextSize.height + padding;
        
        // ticketPriceString
        NSAttributedString *ticketPriceString = [[NSAttributedString alloc] initWithString:self.printData[@"ticketPrice"] attributes:stringAttributes];
        CGSize ticketPriceTextSize = [self _stringTextSize:self.printData[@"ticketPrice"] andFont:font];
        [ticketPriceString drawInRect:CGRectMake((self.printableRect.size.width - ticketPriceTextSize.width) / 2 + self.printableRect.origin.x, drawNextY, self.printableRect.size.width, ticketPriceTextSize.height)];
    }
}

- (CGSize)_stringTextSize:(NSString *)string andFont:(UIFont *)font
{
    return [string sizeWithFont:font
              constrainedToSize:CGSizeMake(self.printableRect.size.width, self.printableRect.size.height)
                  lineBreakMode:NSLineBreakByWordWrapping];
}

@end
