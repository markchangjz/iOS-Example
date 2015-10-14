//
//  KitchenSinkViewController.m
//  Kitchen Sink
//
//  Created by JzChang on 12/12/20.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "KitchenSinkViewController.h"
#import "AskerViewController.h"
#import <MobileCoreServices/MobilefCoreServices.h>

@interface KitchenSinkViewController () <AskerViewControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *kitchenSink;
@property (weak, nonatomic) NSTimer *drainTimer;
@property (weak, nonatomic) UIActionSheet *actionSheet; // 必需使用 weak

@end

@implementation KitchenSinkViewController

@synthesize kitchenSink = _kitchenSink;
@synthesize drainTimer = _drainTimer;
@synthesize actionSheet = _actionSheet;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Create Label"]) {
        AskerViewController *asker = (AskerViewController *)segue.destinationViewController;
        asker.question = @"What do you want your label to say?";
        asker.answer = @"Label Text";
        asker.delegate = self;
    }
}

- (void)setRandomLocationForView:(UIView *)view
{
    CGRect sinkBounds = CGRectInset(self.kitchenSink.bounds, view.frame.size.width / 2, view.frame.size.height / 2);
    CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width / 2;
    CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height / 2;
    view.center = CGPointMake(x, y);
}

- (IBAction)tap:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.kitchenSink];
    for (UIView *view in self.kitchenSink.subviews) {
        if (CGRectContainsPoint(self.kitchenSink.frame, tapLocation)) {
            // UIViewAnimationOptionBeginFromCurrentState :
            // 如果我修改了進行中的動畫的一些屬性, 從中斷的位置開始新的動畫
            [UIView animateWithDuration:4.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self setRandomLocationForView:view];
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99); // 回復到"接近"原本的樣子
            } completion:^(BOOL finished){
                view.transform = CGAffineTransformIdentity; // 改回原本的樣子(恢復原狀)
            }];
        }
    }
}

#define DRAIN_DURATION 3.0

- (void)drain
{
    for (UIView *view in self.kitchenSink.subviews) {
        CGAffineTransform transform = view.transform; // transform 封裝了 scale, rotation 和 affine, tranforms
        if (CGAffineTransformIsIdentity(transform)) { // 避免已經正在旋轉消失的 view 再旋轉消失一次(只有還是原形才會執行)
            UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear; // 動畫選項
            [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.7, 0.7), 2*M_PI/3); // 一圈2*PI, 2*M_PI/3在左下角
            } completion:^(BOOL finished){
                if (finished) {
                    [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                        view.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 0.4, 0.4), -2*M_PI/3); // 一圈2*PI, -2*M_PI/3在左上角, 等同4*M_PI/3
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:DRAIN_DURATION/3 delay:0 options:options animations:^{
                                view.transform = CGAffineTransformScale(transform, 0.1, 0.1);
                            } completion:^(BOOL finished){
                                if (finished) [view removeFromSuperview]; // 旋轉一圈後 移除掉view
                            }];
                        }                        
                    }];
                }
            }];
        }
    }
}

- (void)drain:(NSTimer *)timer
{
    [self drain];
}

- (void)startDraining
{
    self.drainTimer = [NSTimer scheduledTimerWithTimeInterval:DRAIN_DURATION/3
                                                       target:self
                                                     selector:@selector(drain:) // 必需呼叫代(NSTimer *)參數的function - (void)drain:(NSTimer *)timer
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)stopDraining
{
    [self.drainTimer invalidate];
}

#define STOP_DRAIN @"Stopper Drain"
#define UNSTOP_DRAIN @"Unstopper Drain"

- (IBAction)controlSink:(UIBarButtonItem *)sender
{
    if (self.actionSheet) {
        // do nothing
//        [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else {
        NSString *drainButton = self.drainTimer ? STOP_DRAIN : UNSTOP_DRAIN;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Slink Controls"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Empty Sink"
                                                        otherButtonTitles:drainButton, nil];
        [actionSheet showFromBarButtonItem:sender animated:YES];
        self.actionSheet = actionSheet;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        [self.kitchenSink.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    else if ([choice isEqualToString:STOP_DRAIN]) {
        [self stopDraining];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(drip) object:nil]; // 取消之前的請求
    }
    else if ([choice isEqualToString:UNSTOP_DRAIN]) {
        [self startDraining];
        [self drip];
    }
}

- (void)addLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    static NSDictionary *colors = nil;
    if (!colors) {
        colors = [NSDictionary dictionaryWithObjectsAndKeys:
                  [UIColor blueColor], @"Blue",
                  [UIColor greenColor], @"Green",
                  [UIColor orangeColor], @"Orange",
                  [UIColor redColor], @"Red",
                  [UIColor purpleColor], @"Purple",
                  [UIColor brownColor], @"Brown",
                  nil];
    }
    
    if (![text length]) {
        NSString *color = [[colors allKeys] objectAtIndex:arc4random()%[colors count]];
        text = color;
        label.textColor = [colors objectForKey:color];
    }
        
    label.text = text;
    label.font = [UIFont systemFontOfSize:48.0];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit]; // 調成符合文字大小的空間

    [self setRandomLocationForView:label];
    [self.kitchenSink addSubview:label];
}

#define FAUCET_INTERVAL 2.0

- (void)drip
{
    if (self.kitchenSink.subviews) {
        [self addLabel:nil];
        [self performSelector:@selector(drip) withObject:nil afterDelay:FAUCET_INTERVAL];
        // @selector()中funtion沒打":"代表呼叫沒有參數的function
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startDraining];
    [self drip];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopDraining];
    [super viewWillDisappear:animated];
}

- (IBAction)addImage:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) { // 檢查相機是否可以使用
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([mediaTypes containsObject:(NSString *)kUTTypeImage]) { // 檢查是否可以拍照
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self; // 需要加入 UIImagePickerControllerDelegate, UINavigationControllerDelegate 兩個 protocol
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            [self presentModalViewController:picker animated:YES];
        }
    }
}

- (void)dismissImagePicker
{
    [self dismissModalViewControllerAnimated:YES];
}

#define MAX_IMAGE_WIDTH 200

// 按下 "Use"
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) { // 讓 picker.allowsEditing = NO 也能執行
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (image) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGRect frame = imageView.frame;
        while (frame.size.width > MAX_IMAGE_WIDTH) {
            frame.size.width /= 2;
            frame.size.height /= 2;
        }
        imageView.frame = frame;
        [self setRandomLocationForView:imageView];
        [self.kitchenSink addSubview:imageView];
    }
    [self dismissImagePicker];
}

// 按下 "Cancel"
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissImagePicker];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;    
}

// 實作 AskerViewControllerDelegate 的 protocol
- (void)askerViewController:(AskerViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer
{
    [self addLabel:answer];
    [self dismissModalViewControllerAnimated:YES];
}

@end
