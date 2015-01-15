//
//  FVEasyShowCase.m
//
//  This software is released under the MIT License.
//
//  Copyright (c) 2015 Fernando Valle. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Except as contained in this notice, the name(s) of the above copyright holders shall not be used in advertising or otherwise to promote the sale, use or other dealings in this Software without prior written authorization.

#import "FVEasyShowCase.h"


//FVEasyShowCasePoint
//
@implementation FVEasyShowCasePoint : NSObject
@synthesize location;
@synthesize textLabel;
@synthesize radius;
@synthesize position;

-(FVEasyShowCasePoint *) initWithLocation:(CGRect)loc text:(NSString *)text labelPosition:(FVEasyShowCasePointPosition)pos
{
    radius = loc.size.width /3;
    location = loc;
    position = pos;
    
    textLabel = [[UILabel alloc] init];
    [textLabel setText:text];
    [textLabel sizeToFit];
    textLabel.textColor = [UIColor whiteColor];
    
    if(position == FVEasyShowCasePointPositionLeft)
        [textLabel setFrame:CGRectMake(location.origin.x-textLabel.frame.size.width, location.origin.y+location.size.height/2, textLabel.frame.size.width, textLabel.frame.size.height)];
    else if(position == FVEasyShowCasePointPositionTop)
        [textLabel setCenter:CGPointMake(loc.origin.x+loc.size.width/2.0, loc.origin.y-loc.size.height/2.0)];
    else if(position == FVEasyShowCasePointPositionRight)
        [textLabel setFrame:CGRectMake(location.origin.x+location.size.width, location.origin.y+location.size.height/2, textLabel.frame.size.width, textLabel.frame.size.height)];
    else if(position == FVEasyShowCasePointPositionBot)
        [textLabel setCenter:CGPointMake(loc.origin.x+loc.size.width/2.0, loc.origin.y+loc.size.height)];
    
    return self;
}

-(FVEasyShowCasePoint *) initWithTarget:(id)target inContainer:(id)containerView text:(NSString *)text labelPosition:(FVEasyShowCasePointPosition)pos
{
    return [self initWithLocation:[target convertRect:[target bounds] toView:containerView] text:(NSString *)text labelPosition:(FVEasyShowCasePointPosition)pos];
}


@end


//FVEasyShowCase
//
@interface FVEasyShowCase()
@property (nonatomic, retain) id containerView;

@property NSMutableArray *points;
@property (nonatomic) UIImageView *showcaseImageView;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *detailsColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *highlightColor;


@end

@implementation FVEasyShowCase

@synthesize delegate;
@synthesize showcaseImageView;
@synthesize containerView;
@synthesize points;


-(id) init
{
    return [self initWithBackgroundColor:[UIColor blackColor] highlightColor:[FVEasyShowCase colorFromHexString:@"#1397C5"]];
}


-(id)initWithBackgroundColor:(UIColor *)backColor highlightColor:(UIColor *)highColor
{
    self.backgroundColor = backColor;
    self.highlightColor = highColor;
    
    points = [[NSMutableArray alloc] init];
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}


-(void) show
{
    [self showInContainer:containerView];
}

-(void) showInContainer:(id)container
{
    containerView = container;
    self.alpha = 1.0f;
    for (UIView* view in [container subviews])
    {
        [view setUserInteractionEnabled:NO];
    }
    
    
    [UIView transitionWithView:container
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [container addSubview:self];
                    }
                    completion:^(BOOL finished) {
                        [delegate FVEasyShowCaseShown];
                    }];
}


- (void) setupShowcase
{
    [self setupBackground];
    [self addSubview:showcaseImageView];
    [self addLabels];
    [self addGestureRecognizer:[self getGesture]];
}



- (void) setupBackground
{
    // Black Background
    UIGraphicsBeginImageContextWithOptions([[UIScreen mainScreen] bounds].size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
    CGContextFillRect(context, [containerView bounds]);
    
    for(FVEasyShowCasePoint *point in points)
    {
        CGPoint center = CGPointMake(point.location.origin.x + point.location.size.width / 2.0f, point.location.origin.y + point.location.size.height / 2.0f);
        
        // Draw Highlight
        CGContextSetLineWidth(context, 2.54f);
        CGContextSetShadowWithColor(context, CGSizeZero, 30.0f, self.highlightColor.CGColor);
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        CGContextSetStrokeColorWithColor(context, self.highlightColor.CGColor);
        //CGContextAddArc(context, center.x, center.y, self.radius * 2.0f, 0, 2 * M_PI, 0);
        //CGContextDrawPath(context, kCGPathFillStroke);
        CGContextAddArc(context, center.x, center.y, point.radius, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        // Clear Circle
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextAddArc(context, center.x, center.y, point.radius - 0.54, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathFill);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
    }

    
    
    showcaseImageView = [[UIImageView alloc] initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    [showcaseImageView setAlpha:0.75f];
}


-(void)addLabels
{
    for(FVEasyShowCasePoint *point in points)
    {
        [self addSubview:[point textLabel]];
    }
}



-(void) addPoint:(FVEasyShowCasePoint *)point
{
    [points addObject:point];
}


+ (UIColor*) colorFromHexString:(NSString *)hexCode
{
    NSString *cleanString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

- (UITapGestureRecognizer*) getGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showcaseTapped)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    return singleTap;
}

- (void) showcaseTapped
{
    [UIView animateWithDuration:0.5 animations:^{ self.alpha = 0.0f; } completion:^(BOOL finished) { [self onAnimationComplete]; } ];
}

-(void) onAnimationComplete
{
    for (UIView *view in [self.containerView subviews])
    {
        [view setUserInteractionEnabled:YES];
    }
    
    
    for(FVEasyShowCasePoint *point in points)
    {
        [[point textLabel] removeFromSuperview];
    }
    
    [showcaseImageView removeFromSuperview];
    showcaseImageView = NULL;
    [self removeFromSuperview];
    
    [delegate FVEasyShowCaseDismissed];
}


@end


