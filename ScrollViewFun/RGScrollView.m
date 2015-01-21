//
//  RGScrollView.m
//  ScrollViewFun
//
//  Created by ROBERA GELETA on 1/20/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGScrollView.h"

@implementation RGScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *returnedView = [super hitTest:point withEvent:event];
    if(returnedView == self)
    {
        return nil;
    }
    return returnedView;
}

@end
