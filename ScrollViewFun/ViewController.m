//
//  ViewController.m
//  ScrollViewFun
//
//  Created by ROBERA GELETA on 1/20/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "ViewController.h"
#import "RGView.h"
#import "RGScrollView.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet RGScrollView *scrollView;


//------>
//@property (weak, nonatomic) IBOutlet RGView *view1;
//@property (weak, nonatomic) IBOutlet RGView *view2;
//@property (weak, nonatomic) IBOutlet RGView *view3;


//--CHeck
@property (weak, nonatomic) IBOutlet UIView *check;

@end

@implementation ViewController
{
    UIVisualEffectView *visualEffectView;
    UIWindow *window;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    window = [UIApplication sharedApplication].windows.firstObject;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    visualEffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    visualEffectView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    //--> add a view to the effect View
    RGView *visualEffectSubView1 = [[RGView alloc]initWithFrame:CGRectMake(10, 10, 100, 200)];
    RGView *visualEffectSubView2 = [[RGView alloc]initWithFrame:CGRectMake(160,10, 100, 200)];
    [self addHoldGestureRecognizer:visualEffectSubView1];
    [self addHoldGestureRecognizer:visualEffectSubView2];
    
    
    
    RGView *subView1OfMainView = [[RGView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    subView1OfMainView.backgroundColor  = [UIColor colorWithRed:0.52 green:0.42 blue:0.57 alpha:1];
    RGView *subView2OfMainView = [[RGView alloc]initWithFrame:CGRectMake(0, 200, 150, 150)];
    subView2OfMainView.backgroundColor = [UIColor colorWithRed:0.08 green:0.09 blue:0.11 alpha:1];
    RGView *subView3OfMainView = [[RGView alloc]initWithFrame:CGRectMake(0, 400, 150, 150)];
    subView3OfMainView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:subView1OfMainView];
    [self.view addSubview:subView2OfMainView];
    [self.view addSubview:subView3OfMainView];
    
    [self.view sendSubviewToBack:subView1OfMainView];
    [self.view sendSubviewToBack:subView2OfMainView];
    [self.view sendSubviewToBack:subView3OfMainView];
    
    
    [self addHoldGestureRecognizer:subView1OfMainView];
    [self addHoldGestureRecognizer:subView2OfMainView];
    [self addHoldGestureRecognizer:subView3OfMainView];

    
    
    visualEffectSubView1.backgroundColor = [UIColor colorWithRed:0.27 green:0.53 blue:0.98 alpha:1];
    visualEffectSubView2.backgroundColor = [UIColor colorWithRed:0.95 green:0.71 blue:0.51 alpha:1];
    
    
    [visualEffectView.contentView addSubview:visualEffectSubView1];
    [visualEffectView.contentView addSubview:visualEffectSubView2];
    
    [self.scrollView addSubview:visualEffectView];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.scrollView.bounds.size.height + visualEffectView.bounds.size.height);
    
    self.scrollView.contentOffset = CGPointMake(0,visualEffectView.bounds.size.height);
    //--->
    UIPanGestureRecognizer *scrollViewPanGestureRecognizer = self.scrollView.panGestureRecognizer;
    [self.view addGestureRecognizer:scrollViewPanGestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addHoldGestureRecognizer:(RGView *)view
{
    UILongPressGestureRecognizer *holdGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAndHold:)];
    holdGesture.delegate = self;
    [view addGestureRecognizer:holdGesture];
}


- (void)handleTapAndHold:(UILongPressGestureRecognizer *)sender
{
    switch (sender.state ) {
        case UIGestureRecognizerStateBegan:
            [self beganMovingWithGestureRecognizer:sender];
            break;
        case UIGestureRecognizerStateChanged:
            [self continutedMovingWithGestureRecognizer:sender];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self finishedMovingWithGestureRecognizer:sender];
            break;
        default:
            break;
    }
}


- (void)beganMovingWithGestureRecognizer:(UILongPressGestureRecognizer *)sender
{
    //---> makes the pan gesture recognizer drop the touches that are(obviously since we're here)
    //the tap and hold gesture is recognizing
    self.scrollView.panGestureRecognizer.enabled = NO;
    self.scrollView.panGestureRecognizer.enabled = YES;
    
    UIView *selectedView = sender.view;

    CGPoint newCenter = [window convertPoint:selectedView.center fromView:sender.view.superview];
    selectedView.center = newCenter;
    [window addSubview:sender.view];
    
    [UIView animateWithDuration:.2 animations:^{
        selectedView.alpha = .6;
        selectedView.transform = CGAffineTransformMakeScale(1.2, 1.2);

        [self continutedMovingWithGestureRecognizer:sender];
    }];
    
    
}

- (void)continutedMovingWithGestureRecognizer:(UILongPressGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:window];
    UIView *selectedView = sender.view;
    selectedView.center = location;
    
}

- (void)finishedMovingWithGestureRecognizer:(UILongPressGestureRecognizer *)sender
{
    
 
    /**
     *  Another Way
     */
    CGPoint locationOfTouchInBlurEffectView = [sender locationInView:visualEffectView   ];
    
    if(CGRectContainsPoint([visualEffectView bounds], locationOfTouchInBlurEffectView))
    {
        [visualEffectView.contentView addSubview:sender.view];
    }
    else
    {
        [self.view   addSubview:sender.view];
        [self.view sendSubviewToBack:sender.view];
    }
    

    sender.view.center =  [window convertPoint:sender.view.center toView:sender.view.superview];
    CGPoint point = sender.view.center;
    
    [UIView animateWithDuration:.2
                     animations:^{
                         sender.view.transform = CGAffineTransformIdentity;
                         sender.view.alpha = 1.0;

    }
                     completion:^(BOOL finished) {


    }];
    

}




#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


//TODO: REMOVE
- (void)checkSetup
{
//    self.view1
}








@end
