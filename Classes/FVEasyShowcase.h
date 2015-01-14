//
//  FVEasyShowCase.h
//
//  Created by Fernando on 13/01/15.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol FVEasyShowCaseDelegate <NSObject>

-(void) FVEasyShowCaseShown;
-(void) FVEasyShowCaseDismissed;

@end


typedef enum : NSUInteger{
    FVEasyShowCasePointPositionLeft = 1,
    FVEasyShowCasePointPositionTop = 2,
    FVEasyShowCasePointPositionRight = 3,
    FVEasyShowCasePointPositionBot = 4
}  FVEasyShowCasePointPosition;


@interface FVEasyShowCasePoint : NSObject

@property CGRect location;
@property UILabel *textLabel;
@property (nonatomic) CGFloat radius;
@property FVEasyShowCasePointPosition position;

-(FVEasyShowCasePoint *) initWithLocation:(CGRect)loc text:(NSString *)text labelPosition:(FVEasyShowCasePointPosition)pos;
-(FVEasyShowCasePoint *) initWithTarget:(id)target inContainer:(id)containerView text:(NSString *)text labelPosition:(FVEasyShowCasePointPosition)pos;
@end



@interface FVEasyShowCase : UIView

@property (nonatomic, assign) id delegate;

-(id) init;
- (void) setContainerView: (id) container;
- (void) show;
- (void) showInContainer: (id) container;
-(void) setupShowcase;
-(void) addPoint:(FVEasyShowCasePoint *)point;



+ (UIColor*) colorFromHexString:(NSString *)hexCode;

@end




