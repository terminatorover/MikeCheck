//
//  RGView.m
//  ScrollViewFun
//
//  Created by ROBERA GELETA on 1/20/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGView.h"

@implementation RGView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/






#pragma mark - Touch Handling Sequence
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.6;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0;
}

@end
