//
//  GKImageCropOverlayView.m
//  GKImagePicker
//
//  Created by Georg Kitz on 6/1/12.
//  Copyright (c) 2012 Aurora Apps. All rights reserved.
//

#import "GKImageCropOverlayView.h"

@interface GKImageCropOverlayView ()
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation GKImageCropOverlayView

#pragma mark -
#pragma Getter/Setter

@synthesize cropSize;
@synthesize toolbar;

#pragma mark -
#pragma Overriden

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect{
    
    CGFloat toolbarSize = 70;
    CGFloat x = floor(self.frame.size.width / 2 - self.cropSize.width / 2);
    CGFloat y = floor((self.frame.size.height - toolbarSize) / 2 - self.cropSize.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(
        0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:0];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(
        x, y, self.cropSize.width, self.cropSize.height) cornerRadius:self.cornerRadius];
    
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];

    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.4;
    [self.layer addSublayer:fillLayer];
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(
        x - self.borderWidth + 1, y - self.borderWidth + 1,
        self.cropSize.width + self.borderWidth * 2 - 2,
        self.cropSize.height + self.borderWidth * 2 - 2) cornerRadius:self.cornerRadius];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = borderPath.CGPath;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    borderLayer.lineWidth = self.borderWidth;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:borderLayer];
}

@end

