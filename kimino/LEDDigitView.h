//
//  LEDDigitView.h
//  LEDTextLabel
//
//  Created by Cocoa on 20/06/2021.
//

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEDDigitView : NSView

/// Set custom style for char c
/// @param shape a 14-element boolean array that controls the on/off state of the LED segments
/// @param c char
/// @note index
///  111111111111111111111
///  0         4         2
///  0 3       4       5 2
///  0  3      4      5  2
///  0   3     4     5   2
///  0    3    4    5    2
///  0     3   4   5     2
///  0      3  4  5      2
///  0 666666  4  777777 2
///  8      9 10 11      12
///  8     9  10  11     12
///  8    9   10   11    12
///  8   9    10    11   12
///  8  9     10     11  12
///  8 9      10      11 12
///  13 13 13 13 13  13  13
+ (void)setShape:(bool [_Nonnull 14])shape forChar:(char)c;

/// Init
/// @param frame frame
/// @param accentColor color for LED segments in on state
- (instancetype)initWithFrame:(NSRect)frame accentColor:(NSColor *)accentColor;

/// Display char
@property (assign, atomic) char c;

/// State for the floating point segment
@property (assign, atomic, getter=isFloatingPointOn) BOOL floatingPointOn;

/// Color for LED segments in off state
@property (strong, atomic) NSColor * offColor;

/// Color for LED segments in on state
@property (strong, atomic) NSColor * accentColor;

/// Display floating point (dot)
@property (assign, atomic) BOOL displayfloatingPoint;

/// Margin space for segments and border
@property (assign) CGFloat margin;

/// Width for a single (vertical) segment
@property (assign) CGFloat segmentWidth;

/// Height for a single (vertical) segment
@property (assign) CGFloat segmentHeight;

@end

NS_ASSUME_NONNULL_END
