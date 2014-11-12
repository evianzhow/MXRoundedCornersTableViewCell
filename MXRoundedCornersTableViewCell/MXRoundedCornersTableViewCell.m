//
//    Copyright (c) 2014 Max Sokolov (http://maxsokolov.net)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MXRoundedCornersTableViewCell.h"

typedef NS_ENUM(NSUInteger, MXRoundedCornersTableViewCellPosition) {

    MXRoundedCornersTableViewCellPositionNone,
    MXRoundedCornersTableViewCellPositionTop,
    MXRoundedCornersTableViewCellPositionMiddle,
    MXRoundedCornersTableViewCellPositionBottom,
    MXRoundedCornersTableViewCellPositionSingle
};

@interface MXRoundedCornersTableViewCell ()

@property (nonatomic, assign) MXRoundedCornersTableViewCellPosition cellPosition;
@property (nonatomic, strong) UIColor *fillColor;

@end

@implementation MXRoundedCornersTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // default settings
        self.cellPosition = MXRoundedCornersTableViewCellPositionNone;
        self.separatorEdgeInset = UIEdgeInsetsZero;
        self.cornerRadius = 10.0f;
        self.borderWidth = 1.0f;
        self.separatorHeight = 2.0f;
        self.edgeOffset = 20.0f;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    [super setBackgroundColor:[UIColor clearColor]];
    self.fillColor = backgroundColor;
}

#pragma mark - Public methods

- (void)configureRoundedCornersWithRowIndex:(NSInteger)row andNumberOfRowsInSection:(NSInteger)count {

    if (row == 0 && row == count - 1)
        self.cellPosition = MXRoundedCornersTableViewCellPositionSingle;
    else if (row == count - 1)
        self.cellPosition = MXRoundedCornersTableViewCellPositionBottom;
    else if (row == 0)
        self.cellPosition = MXRoundedCornersTableViewCellPositionTop;
    else
        self.cellPosition = MXRoundedCornersTableViewCellPositionMiddle;

    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {

    rect = CGRectInset(rect, self.edgeOffset, 0.0f);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, self.borderWidth);
    CGContextSetFillColorWithColor(context, [self.fillColor CGColor]);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    switch (self.cellPosition) {
        case MXRoundedCornersTableViewCellPositionTop: {
            
            CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
            CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
            minx = minx + self.borderWidth / 2.0f;
            miny = miny + self.borderWidth / 2.0f;
            maxx = maxx - self.borderWidth / 2.0f;
            
            CGContextMoveToPoint(context, minx, maxy);
            CGContextAddArcToPoint(context, minx, miny, midx, miny, self.cornerRadius);
            CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, self.cornerRadius);
            CGContextAddLineToPoint(context, maxx, maxy);
            CGContextDrawPath(context, kCGPathFillStroke);

            // draw separator
            CGContextSetStrokeColorWithColor(context, self.cellSeparatorColor.CGColor);
            CGContextSetLineWidth(context, self.separatorHeight);
            CGContextMoveToPoint(context, minx + self.separatorEdgeInset.left, maxy);
            CGContextAddLineToPoint(context, maxx - self.separatorEdgeInset.right, maxy);
            CGContextDrawPath(context, kCGPathFillStroke);
            // end separator
            
            return;
        }
        case MXRoundedCornersTableViewCellPositionMiddle: {
            
            CGFloat minx = CGRectGetMinX(rect), maxx = CGRectGetMaxX(rect);
            CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
            minx = minx + self.borderWidth / 2.0f;
            maxx = maxx - self.borderWidth / 2.0f;
            
            // fill background
            CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
            CGContextAddRect(context, CGRectInset(rect, self.borderWidth / 2.0f, 0));
            CGContextDrawPath(context, kCGPathFillStroke);

            // draw side lines
            CGContextSetStrokeColorWithColor(context, [self.borderColor CGColor]);
            CGContextMoveToPoint(context, minx, miny);
            CGContextAddLineToPoint(context, minx, maxy);
            CGContextDrawPath(context, kCGPathFillStroke);
            
            CGContextMoveToPoint(context, maxx, miny);
            CGContextAddLineToPoint(context, maxx, maxy);
            CGContextDrawPath(context, kCGPathFillStroke);

            // draw separator
            CGContextSetLineWidth(context, self.separatorHeight);
            CGContextSetStrokeColorWithColor(context, self.cellSeparatorColor.CGColor);
            CGContextMoveToPoint(context, minx + self.separatorEdgeInset.left, maxy);
            CGContextAddLineToPoint(context, maxx - self.separatorEdgeInset.right, maxy);
            CGContextDrawPath(context, kCGPathFillStroke);
            // end separator
            
            return;
        }
        case MXRoundedCornersTableViewCellPositionBottom: {
            
            CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
            CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
            minx = minx + self.borderWidth / 2.0f;
            
            maxx = maxx - self.borderWidth / 2.0f;
            maxy = maxy - self.borderWidth / 2.0f;
            
            CGContextMoveToPoint(context, minx, miny);
            CGContextAddArcToPoint(context, minx, maxy, midx, maxy, self.cornerRadius);
            CGContextAddArcToPoint(context, maxx, maxy, maxx, miny, self.cornerRadius);
            CGContextAddLineToPoint(context, maxx, miny);
            
            CGContextDrawPath(context, kCGPathFillStroke);
            
            return;
        }
        case MXRoundedCornersTableViewCellPositionSingle: {
            
            CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
            CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
            minx = minx + self.borderWidth / 2.0f;
            miny = miny + self.borderWidth / 2.0f;
            
            maxx = maxx - self.borderWidth / 2.0f;
            maxy = maxy - self.borderWidth / 2.0f;

            CGContextMoveToPoint(context, minx, midy);
            CGContextAddArcToPoint(context, minx, miny, midx, miny, self.cornerRadius);
            CGContextAddArcToPoint(context, maxx, miny, maxx, midy, self.cornerRadius);
            CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, self.cornerRadius);
            CGContextAddArcToPoint(context, minx, maxy, minx, midy, self.cornerRadius);

            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
            
            return;
        }
        default:
            return;
    }
}

@end