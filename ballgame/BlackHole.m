//
//  BlackHole.m
//  ballgame
//
//  Created by Nate Symer on 3/31/12.
//  Copyright (c) 2012 Nathaniel Symer. All rights reserved.
//

#import "BlackHole.h"

@implementation BlackHole

- (void)muckWithFrame:(CGRect)ballframe {
    int adjustedWidth = (int)floor(_screenBounds.size.width-60);
    int adjustedHeight = (int)floor(_screenBounds.size.height-60);
    int x = (arc4random()%adjustedWidth)+30;
    int y = (arc4random()%adjustedHeight)+30;

    CGRect adjustedFrame = CGRectMake(x-75, y-75, self.frame.size.width+150, self.frame.size.height+150);
    
    if (CGRectIntersectsRect(adjustedFrame, ballframe)) {
        [self muckWithFrame:ballframe];
    } else {
        self.frame = CGRectMake(x, y, 33, 33);
    }
}

- (void)move {
    CGPoint center = self.center;
    CGPoint perspectiveCenter = CGPointMake(center.x+(_directionVector.width/30), center.y+_directionVector.height/30);
    
    if (!CGRectContainsPoint(_screenBounds, perspectiveCenter)) {
        BOOL xTooHigh = (perspectiveCenter.x > _screenBounds.size.width || perspectiveCenter.x <= 0);
        BOOL yTooHigh = (perspectiveCenter.y > _screenBounds.size.height || perspectiveCenter.y <= 0);
        _directionVector = CGSizeMake(xTooHigh?-1*_directionVector.width:_directionVector.width, yTooHigh?-1*_directionVector.height:_directionVector.height);
        perspectiveCenter = CGPointMake(center.x+(_directionVector.width/35), center.y+(_directionVector.height/35));
    }
    
    self.center = perspectiveCenter;
    
    if (_isMoving) {
        [self performSelector:@selector(move) withObject:nil afterDelay:1/60];
    }
}

- (void)startMoving {
    
    if (_isMoving) {
        return;
    }
    
    _directionVector = CGSizeMake(1, 1);
    _isMoving = YES;
    [self move];
}

- (void)stopMoving {
    _isMoving = NO;
    _directionVector = CGSizeMake(1, 1);
}

- (id)init {
    self = [super init];
    if (self) {
        self.screenBounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithBallframe:(CGRect)ballframe {
    self = [super initWithFrame:self.frame];
    if (self) {
        self.screenBounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self muckWithFrame:ballframe];
    }
    return self;
}

- (void)redrawRectWithBallFrame:(CGRect)ballFrame {
    [self muckWithFrame:ballFrame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.shouldRasterize = YES;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.7f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 5.0f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-5, -5, 44, 44)].CGPath;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectb = self.bounds;
    
    CGFloat colorsOne[] = { 1, 1, 1, 1, 1, 0, 0, 1 };
    CGFloat colorsTwo[] = { 0, 0, 0, 1, 0.65625, 0.8046875, 0.9453125, 1 };
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientOne = CGGradientCreateWithColorComponents(rgb, colorsOne, nil, 2);
    CGGradientRef gradientTwo = CGGradientCreateWithColorComponents(rgb, colorsTwo, nil, sizeof(colorsTwo)/(sizeof(colorsTwo[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGAffineTransform transform = CGAffineTransformMakeScale(self.bounds.size.width, self.bounds.size.height);
    
    CGContextSaveGState(context);
    
    CGContextAddEllipseInRect(context, rectb);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradientOne, CGPointMake(CGRectGetMidX(rectb), CGRectGetMinY(rectb)), CGPointMake(CGRectGetMidX(rectb), CGRectGetMaxY(rectb)), 0);
    
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextConcatCTM(context, transform);
    CGContextBeginPath(context);
    CGContextAddArc(context, 0.5, 0.5, 0.3, 0, 6.28318531, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradientTwo, CGPointMake(0.5, 0), CGPointMake(0.5, 1), 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradientOne);
    CGGradientRelease(gradientTwo);
}

@end
