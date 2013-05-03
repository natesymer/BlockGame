//
//  BackgroundView.m
//  ballgame
//
//  Created by Nathaniel Symer on 4/10/13.
//  Copyright (c) 2013 Nathaniel Symer. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (void)drawRect:(CGRect)rect {
    UIImage *scaled = [UIImage imageWithCGImage:[[UIImage imageNamed:@"background"]CGImage] scale:[[UIScreen mainScreen]scale] orientation:UIImageOrientationUp];
    [scaled drawInRect:self.bounds];
}

@end
