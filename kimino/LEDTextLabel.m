//
//  LEDTextLabel.m
//  LEDTextLabel
//
//  Created by Cocoa on 20/06/2021.
//

#import "LEDTextLabel.h"
#import "LEDDigitView.h"

@interface LEDTextLabel() {
    NSMutableArray<LEDDigitView *> * digits;
}

@end

@implementation LEDTextLabel

@synthesize text;
@synthesize accentColor;
@synthesize offColor;
@synthesize fontHeight;
@synthesize compact;

- (void)initialise {
    self->digits = [NSMutableArray new];
    self->fontHeight = 50.0f;
    self.accentColor = [NSColor colorWithRed:0.586 green:0.917 blue:0.02 alpha:1];
    self.offColor = [NSColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.05];
    self.floatingPointStyle = All;

    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:(void *)0x1];
    [self addObserver:self forKeyPath:@"accentColor" options:NSKeyValueObservingOptionNew context:(void *)0x2];
    [self addObserver:self forKeyPath:@"offColor" options:NSKeyValueObservingOptionNew context:(void *)0x3];
    [self addObserver:self forKeyPath:@"fontHeight" options:NSKeyValueObservingOptionNew context:(void *)0x4];
    [self addObserver:self forKeyPath:@"compact" options:NSKeyValueObservingOptionNew context:(void *)0x5];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [self setNeedsDisplay:YES];
    } else if (context == (void *)0x2) {
        for (LEDDigitView * d in self->digits) {
            d.accentColor = self.accentColor;
        }
    } else if (context == (void *)0x3) {
        for (LEDDigitView * d in self->digits) {
            d.offColor = self.offColor;
        }
    } else if (context == (void *)0x4) {
        [self setNeedsDisplay:YES];
    } else if (context == (void *)0x5) {
        [self setNeedsDisplay:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialise];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialise];
        self->fontHeight = self.frame.size.height;
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialise];
        self->fontHeight = frame.size.height;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    CGFloat fontWidth = self->fontHeight / 143.0 * 81.0;
    
    const char * cText = self.text.UTF8String;
    if (cText) {
        size_t len = strlen(cText);
        size_t i = 0;
        for (size_t index = 0; index < len; index++) {
            char c = cText[index];
            
            if (i >= self->digits.count) {
                LEDDigitView * digitView = [[LEDDigitView alloc] initWithFrame:NSMakeRect(fontWidth * i, 0, fontWidth, self.fontHeight) accentColor:self.accentColor];
                [self addSubview:digitView];
                [self->digits addObject:digitView];
            }
            
            self->digits[i].c = c;
            self->digits[i].displayfloatingPoint = NO;
            if (self.floatingPointStyle == All) {
                self->digits[i].displayfloatingPoint = YES;
            }
            if (c == '.') {
                self->digits[i].floatingPointOn = YES;
                if (self.floatingPointStyle != None) {
                    self->digits[i].displayfloatingPoint = YES;
                }
            } else if (self.compact && index < len && cText[index + 1] == '.') {
                self->digits[i].floatingPointOn = YES;
                if (self.floatingPointStyle != None) {
                    self->digits[i].displayfloatingPoint = YES;
                }
                index++;
            }
            self->digits[i].offColor = self.offColor;
            self->digits[i].accentColor = self.accentColor;
            i++;
        }
        
        for (size_t index = i; index < self->digits.count; index++) {
            [self->digits[index] removeFromSuperview];
        }
        [self->digits removeObjectsInRange:NSMakeRange(i, self->digits.count - i)];
    }
}

@end
