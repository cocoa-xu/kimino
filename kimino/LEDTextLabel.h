//
//  LEDTextLabel.h
//  LEDTextLabel
//
//  Created by Cocoa on 20/06/2021.
//

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum FloatingPointDisplayStyle : NSUInteger {
    IfAndOnlyIfCharIsDot,
    All,
    None
} FloatingPointDisplayStyle;

@interface LEDTextLabel : NSView

/// Displaying text
@property (strong, nonatomic) NSString * text;

/// Color for LED segments in on state
@property (strong, nonatomic) NSColor * accentColor;

/// Color for LED segments in off state
@property (strong, nonatomic) NSColor * offColor;

/// Floating point displays style (dot)
@property (assign, atomic) FloatingPointDisplayStyle floatingPointStyle;

/// Height for a single character
@property (assign) CGFloat fontHeight;

/// Should '.' be compressed to the LED before it.
@property (assign, getter=isCompact) BOOL compact;

@end

NS_ASSUME_NONNULL_END
