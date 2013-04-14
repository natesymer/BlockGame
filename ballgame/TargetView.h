//
//  TargetView.h
//  ballgame
//
//  Created by Nathaniel Symer on 4/9/13.
//
//

#import <UIKit/UIKit.h>

@interface TargetView : UIView

- (void)redrawWithBackgroundColor:(UIColor *)color vertically:(BOOL)vertically;
- (void)setClassicMode:(BOOL)cm;
- (void)redrawImageWithIsHorizontal:(BOOL)isH;

@end
