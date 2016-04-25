//
//  STCImageView.m
//  youngcity
//
//  Created by chen xiaosong on 16/4/22.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "STCImageView.h"

#define STCObservingkeyPath @"contentOffset"

@implementation STCImageView
{
    CGRect  orgRect;
    
    __weak UIScrollView *scrollV;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithScrollView:(UIScrollView*)v height:(CGFloat)h
{
    CGRect rect = v.frame;
    rect.size.height = h;
    rect.size.width  = [UIScreen mainScreen].bounds.size.width;
    
    orgRect = rect;

    self = [super initWithFrame:rect];
    if (self) {
        scrollV = v;
        UIView *superV = v.superview;
        [superV insertSubview:self belowSubview:v];
        
        [v addObserver:self forKeyPath:STCObservingkeyPath options:NSKeyValueObservingOptionNew context:nil];

        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:STCObservingkeyPath])
    {
        CGFloat offsetY = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        
        [self animateCoverImage:offsetY];
    }
}

- (void)animateCoverImage:(CGFloat)contentOffset
{
    CGAffineTransform headerTransform = CGAffineTransformIdentity;

    if (contentOffset < 0){
        [self setupFrameTop:orgRect.origin.y];
        
        CGFloat headerScaleFactor = -(contentOffset) / orgRect.size.height;

        headerTransform = CGAffineTransformScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor);
        
        self.transform = headerTransform;
        
    }else{
        [self setupFrameTop:orgRect.origin.y-contentOffset];
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
}

- (void)dealloc
{
    [scrollV removeObserver:self forKeyPath:STCObservingkeyPath];
}

- (void)setupFrameTop:(CGFloat)top
{
    NSLog(@"offset %lf", top);
    
    CGRect frame = self.frame;
    
    frame.origin.y = top;
    
    self.frame = frame;
}
@end
