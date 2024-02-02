//
//  LEDDigitView.m
//  LEDTextLabel
//
//  Created by Cocoa on 20/06/2021.
//

#import "LEDDigitView.h"
#import <vector>
#import <map>

@implementation LEDDigitView
@synthesize accentColor;
@synthesize offColor;
@synthesize floatingPointOn;
@synthesize displayfloatingPoint;
@synthesize c;

+ (void)setShape:(bool [14])shapes forChar:(char)c {
    std::vector<bool> shape;
    shape.assign(shapes, shapes + 14);
    [LEDDigitView sharedFontShapes][c] = shape;
}

+ (std::map<char, std::vector<bool>> &)sharedFontShapes {
    static std::map<char, std::vector<bool>> kLEDData = {
        {'0', {1,1,1,0,0,0,0,0,1,0,0,0,1,1}},
        {'1', {0,0,1,0,0,0,0,0,0,0,0,0,1,0}},
        {'2', {0,1,1,0,0,0,1,1,1,0,0,0,0,1}},
        {'3', {0,1,1,0,0,0,1,1,0,0,0,0,1,1}},
        {'4', {1,0,1,0,0,0,1,1,0,0,0,0,1,0}},
        {'5', {1,1,0,0,0,0,1,1,0,0,0,0,1,1}},
        {'6', {1,1,0,0,0,0,1,1,1,0,0,0,1,1}},
        {'7', {0,1,1,0,0,0,0,0,0,0,0,0,1,0}},
        {'8', {1,1,1,0,0,0,1,1,1,0,0,0,1,1}},
        {'9', {1,1,1,0,0,0,1,1,0,0,0,0,1,1}},
        {'A', {1,1,1,0,0,0,1,1,1,0,0,0,1,0}},
        {'B', {1,1,0,0,0,1,1,0,1,0,0,1,0,1}},
        {'b', {1,0,0,0,0,0,1,1,1,0,0,0,1,1}},
        {'C', {1,1,0,0,0,0,0,0,1,0,0,0,0,1}},
        {'c', {0,0,0,0,0,0,1,1,1,0,0,0,0,1}},
        {'D', {1,1,1,0,0,0,0,0,1,0,0,0,1,1}},
        {'d', {0,0,1,0,0,0,1,1,1,0,0,0,1,1}},
        {'E', {1,1,0,0,0,0,1,1,1,0,0,0,0,1}},
        {'F', {1,1,0,0,0,0,1,1,1,0,0,0,0,0}},
        {'G', {1,1,0,0,0,0,0,1,1,0,1,0,1,1}},
        {'H', {1,0,1,0,0,0,1,1,1,0,0,0,1,0}},
        {'h', {1,0,0,0,0,0,1,1,1,0,0,0,1,0}},
        {'I', {0,1,0,0,1,0,0,0,0,0,1,0,0,1}},
        {'J', {0,1,1,0,0,0,0,0,1,0,0,0,1,1}},
        {'K', {0,0,0,0,1,1,0,0,0,0,1,1,0,0}},
        {'L', {1,0,0,0,0,0,0,0,1,0,0,0,0,1}},
        {'M', {1,0,1,1,0,1,0,0,1,0,0,0,1,0}},
        {'N', {1,0,1,1,0,0,0,0,1,0,0,1,1,0}},
        {'O', {1,1,1,0,0,0,0,0,1,0,0,0,1,1}},
        {'o', {0,0,0,0,0,0,1,1,1,0,0,0,1,1}},
        {'P', {1,1,1,0,0,0,1,1,1,0,0,0,0,0}},
        {'p', {0,1,1,0,1,0,0,1,0,0,1,0,0,0}},
        {'Q', {1,1,1,0,0,0,0,0,1,0,0,1,1,1}},
        {'R', {1,1,1,0,0,0,1,1,1,0,0,1,0,0}},
        {'S', {1,1,0,0,0,0,1,1,0,0,0,0,1,1}},
        {'T', {0,1,0,0,1,0,0,0,0,0,1,0,0,0}},
        {'U', {1,0,1,0,0,0,0,0,1,0,0,0,1,1}},
        {'V', {1,0,0,0,0,1,0,0,1,1,0,0,0,0}},
        {'W', {1,0,1,0,0,0,0,0,1,1,0,1,1,0}},
        {'X', {0,0,0,1,0,1,0,0,0,1,0,1,0,0}},
        {'Y', {0,0,0,1,0,1,0,0,0,0,1,0,0,0}},
        {'Z', {0,1,0,0,0,1,0,0,0,1,0,0,0,1}},
        {'+', {0,0,0,0,1,0,1,1,0,0,1,0,0,0}},
        {'-', {0,0,0,0,0,0,1,1,0,0,0,0,0,0}},
        {'*', {0,0,0,1,1,1,1,1,0,1,1,1,0,0}},
        {'/', {0,0,0,0,0,1,0,0,0,1,0,0,0,0}},
        {':', {0,0,0,0,1,0,0,0,0,0,1,0,0,0}},
        {'=', {0,0,0,0,0,0,1,1,0,0,0,0,0,1}},
        {'[', {1,1,0,0,0,0,0,0,1,0,0,0,0,1}},
        {']', {0,1,1,0,0,0,0,0,0,0,0,0,1,1}},
        {'<', {0,0,0,0,0,1,0,0,0,0,0,1,0,0}},
        {'>', {0,0,0,1,0,0,0,0,0,1,0,0,0,0}},
        {'"', {0,0,1,0,1,0,0,0,0,0,0,0,0,0}},
        {',', {0,0,0,0,0,0,0,0,0,1,0,0,0,0}},
        {'?', {0,1,1,0,0,0,0,1,0,0,1,0,0,0}},
        {'\\', {0,0,0,1,0,0,0,0,0,0,0,1,0,0}},
        {' ', {0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    };
    return kLEDData;
}

- (void)default {
    self.accentColor = [NSColor colorWithRed: 0.586 green: 0.917 blue: 0.02 alpha: 1];
    self.offColor = [NSColor grayColor];
    self.margin = 1;
    self.segmentWidth = 10;
    self.segmentHeight = 50;
    self.c = ' ';
    
    self.shadow = [[NSShadow alloc] init];
    self.shadow.shadowColor = [NSColor.blackColor colorWithAlphaComponent: 0.06];
    self.shadow.shadowOffset = NSMakeSize(3, -1);
    self.shadow.shadowBlurRadius = 5;
    
    [self addKVO];
}

- (void)addKVO {
    [self addObserver:self forKeyPath:@"c" options:NSKeyValueObservingOptionNew context:(void *)0x1];
    [self addObserver:self forKeyPath:@"floatingPointOn" options:NSKeyValueObservingOptionNew context:(void *)0x1];
    [self addObserver:self forKeyPath:@"offColor" options:NSKeyValueObservingOptionNew context:(void *)0x1];
    [self addObserver:self forKeyPath:@"accentColor" options:NSKeyValueObservingOptionNew context:(void *)0x1];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == (void *)0x1) {
        [self setNeedsDisplay:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self default];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self default];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self default];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame accentColor:(NSColor *)accentColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self default];
        self.accentColor = accentColor;
    }
    return self;
}

- (void)drawSegment:(const std::vector<NSPoint> &)points state:(BOOL)isOn {
    NSBezierPath* segment = [NSBezierPath bezierPath];
    
    [segment moveToPoint:points[0]];
    for (size_t i = 1; i < points.size(); i++) {
        [segment lineToPoint:points[i]];
    }
    
    [NSGraphicsContext saveGraphicsState];
    [self.shadow set];
    if (isOn) {
        [self.accentColor setFill];
    } else {
        [self.offColor setFill];
    }
    
    [segment fill];
    [NSGraphicsContext restoreGraphicsState];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    std::map<char, std::vector<bool>> &shapes = [LEDDigitView sharedFontShapes];
    char drawChar = self.c;
    if (shapes.find(drawChar) == shapes.end()) {
        if (isalpha(drawChar)) {
            if ('a' <= drawChar && drawChar <= 'z') {
                drawChar -= 'a' - 'A';
            } else drawChar = ' ';
        } else drawChar = ' ';
    }
    std::vector<bool> &states = shapes[drawChar];
    
    self.segmentWidth = 10;
    CGFloat halfWidth = self.segmentWidth / 2.0f;
    self.segmentHeight = self.frame.size.width - 4 * halfWidth - self.margin * 2 - 5;
    CGFloat frameHeight = self.frame.size.height;
    
    /// Segment 0
    NSPoint s0p0 = NSMakePoint(halfWidth, frameHeight - halfWidth - self.margin);
    NSPoint s0p1 = s0p0;
    s0p1.x = self.segmentWidth; s0p1.y -= halfWidth;
    NSPoint s0p2 = s0p1; s0p2.y -= self.segmentHeight;
    NSPoint s0p3 = s0p2;
    s0p3.x = halfWidth; s0p3.y -= halfWidth;
    NSPoint s0p4 = s0p3;
    s0p4.x -= halfWidth; s0p4.y += halfWidth;
    NSPoint s0p5 = s0p4; s0p5.y += self.segmentHeight;
    [self drawSegment:{s0p0, s0p1, s0p2, s0p3, s0p4, s0p5, s0p0} state:states[0]];

    /// Segment 1
    NSPoint s1p0 = s0p0;
    s1p0.x += self.margin; s1p0.y += self.margin;
    NSPoint s1p1 = s1p0;
    s1p1.x += halfWidth; s1p1.y += halfWidth;
    NSPoint s1p2 = s1p1; s1p2.x += self.segmentHeight;
    NSPoint s1p3 = s1p2;
    s1p3.x += halfWidth; s1p3.y -= halfWidth;
    NSPoint s1p4 = s1p3;
    s1p4.x -= halfWidth; s1p4.y -= halfWidth;
    NSPoint s1p5 = s1p4; s1p5.x -= self.segmentHeight;
    [self drawSegment:{s1p0, s1p1, s1p2, s1p3, s1p4, s1p5, s1p0} state:states[1]];

    /// Segment 2 = Segment 0 + x offset
    CGFloat offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    NSPoint s2p0 = s0p0; s2p0.x += offset;
    NSPoint s2p1 = s0p1; s2p1.x += offset;
    NSPoint s2p2 = s0p2; s2p2.x += offset;
    NSPoint s2p3 = s0p3; s2p3.x += offset;
    NSPoint s2p4 = s0p4; s2p4.x += offset;
    NSPoint s2p5 = s0p5; s2p5.x += offset;
    [self drawSegment:{s2p0, s2p1, s2p2, s2p3, s2p4, s2p5, s2p0} state:states[2]];
    
    /// Segment 4 = Segment 0 + x offset, shrink in height
    offset = self.segmentHeight / 2 + halfWidth + self.margin;
    NSPoint s4p0 = s0p0; s4p0.x += offset; s4p0.y -= halfWidth;
    NSPoint s4p1 = s0p1; s4p1.x += offset; s4p1.y -= halfWidth;
    NSPoint s4p2 = s0p2; s4p2.x += offset; s4p2.y += self.margin;
    NSPoint s4p3 = s0p3; s4p3.x += offset; s4p3.y += self.margin;
    NSPoint s4p4 = s0p4; s4p4.x += offset; s4p4.y += self.margin;
    NSPoint s4p5 = s0p5; s4p5.x += offset; s4p5.y -= halfWidth;
    [self drawSegment:{s4p0, s4p1, s4p2, s4p3, s4p4, s4p5, s4p0} state:states[4]];
    
    /// Segment 3
    NSPoint s3p0 = s0p1; s3p0.x += self.margin;
    NSPoint s3p1 = NSMakePoint(s4p5.x - self.margin, s4p4.y + self.segmentWidth * 1.5);
    NSPoint s3p2 = s3p1; s3p2.y = s4p4.y;
    NSPoint s3p3 = s3p0; s3p3.y -= s3p1.y - s3p2.y;
    [self drawSegment:{s3p0, s3p1, s3p2, s3p3, s3p0} state:states[3]];
    
    /// Segment 5
    NSPoint s5p0 = s2p5; s5p0.x -= self.margin;
    NSPoint s5p1 = NSMakePoint(s4p1.x + self.margin, s4p4.y + self.segmentWidth * 1.5);
    NSPoint s5p2 = s5p1; s5p2.y = s4p2.y;
    NSPoint s5p3 = s5p0; s5p3.y -= s5p1.y - s5p2.y;
    [self drawSegment:{s5p0, s5p1, s5p2, s5p3, s5p0} state:states[5]];
    
    /// Segment 6 = Segment 1 + y offset, shrink in length
    offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    NSPoint s6p0 = s1p0; s6p0.y -= offset;
    NSPoint s6p1 = s1p1; s6p1.y -= offset;
    NSPoint s6p2 = s1p2; s6p2.y -= offset; s6p2.x -= self.segmentHeight / 2 + halfWidth;
    NSPoint s6p3 = s1p3; s6p3.y -= offset; s6p3.x -= self.segmentHeight / 2 + halfWidth;
    NSPoint s6p4 = s1p4; s6p4.y -= offset; s6p4.x -= self.segmentHeight / 2 + halfWidth;
    NSPoint s6p5 = s1p5; s6p5.y -= offset;
    [self drawSegment:{s6p0, s6p1, s6p2, s6p3, s6p4, s6p5, s6p0} state:states[6]];
    
    /// Segment 7 = Segment 6 + x offset
    offset = self.segmentHeight / 2 + halfWidth;
    NSPoint s7p0 = s6p0; s7p0.x += offset;
    NSPoint s7p1 = s6p1; s7p1.x += offset;
    NSPoint s7p2 = s6p2; s7p2.x += offset;
    NSPoint s7p3 = s6p3; s7p3.x += offset;
    NSPoint s7p4 = s6p4; s7p4.x += offset;
    NSPoint s7p5 = s6p5; s7p5.x += offset;
    [self drawSegment:{s7p0, s7p1, s7p2, s7p3, s7p4, s7p5, s7p0} state:states[7]];
    
    /// Segment 8
    offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    NSPoint s8p0 = s0p0; s8p0.y -= offset;
    NSPoint s8p1 = s0p1; s8p1.y -= offset;
    NSPoint s8p2 = s0p2; s8p2.y -= offset;
    NSPoint s8p3 = s0p3; s8p3.y -= offset;
    NSPoint s8p4 = s0p4; s8p4.y -= offset;
    NSPoint s8p5 = s0p5; s8p5.y -= offset;
    [self drawSegment:{s8p0, s8p1, s8p2, s8p3, s8p4, s8p5, s8p0} state:states[8]];
    
    /// Segment 9 = Segment 5 + x,y offset
    offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    CGFloat xoffset = self.segmentHeight / 2 + halfWidth + self.margin;
    NSPoint s9p0 = s5p0; s9p0.x -= xoffset; s9p0.y -= offset;
    NSPoint s9p1 = s5p1; s9p1.x -= xoffset; s9p1.y -= offset;
    NSPoint s9p2 = s5p2; s9p2.x -= xoffset; s9p2.y -= offset;
    NSPoint s9p3 = s5p3; s9p3.x -= xoffset; s9p3.y -= offset;
    [self drawSegment:{s9p0, s9p1, s9p2, s9p3, s9p0} state:states[9]];
    
    /// Segment 10 = Segment 4 + y offset
    offset = self.segmentHeight + halfWidth + self.margin * 3;
    NSPoint s10p0 = s4p0; s10p0.y -= offset;
    NSPoint s10p1 = s4p1; s10p1.y -= offset;
    NSPoint s10p2 = s4p2; s10p2.y -= offset;
    NSPoint s10p3 = s4p3; s10p3.y -= offset;
    NSPoint s10p4 = s4p4; s10p4.y -= offset;
    NSPoint s10p5 = s4p5; s10p5.y -= offset;
    [self drawSegment:{s10p0, s10p1, s10p2, s10p3, s10p4, s10p5, s10p0} state:states[10]];
    
    /// Segment 11 = Segment 3 + x,y offset
    offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    xoffset = self.segmentHeight / 2 + halfWidth + self.margin;
    NSPoint s11p0 = s3p0; s11p0.x += xoffset; s11p0.y -= offset;
    NSPoint s11p1 = s3p1; s11p1.x += xoffset; s11p1.y -= offset;
    NSPoint s11p2 = s3p2; s11p2.x += xoffset; s11p2.y -= offset;
    NSPoint s11p3 = s3p3; s11p3.x += xoffset; s11p3.y -= offset;
    [self drawSegment:{s11p0, s11p1, s11p2, s11p3, s11p0} state:states[11]];
    
    /// Segment 12 = Segment 8 + x offset
    offset = self.segmentHeight + halfWidth * 2 + self.margin * 2;
    NSPoint s12p0 = s8p0; s12p0.x += offset;
    NSPoint s12p1 = s8p1; s12p1.x += offset;
    NSPoint s12p2 = s8p2; s12p2.x += offset;
    NSPoint s12p3 = s8p3; s12p3.x += offset;
    NSPoint s12p4 = s8p4; s12p4.x += offset;
    NSPoint s12p5 = s8p5; s12p5.x += offset;
    [self drawSegment:{s12p0, s12p1, s12p2, s12p3, s12p4, s12p5, s12p0} state:states[12]];
    
    /// Segment 13
    offset = self.segmentHeight * 2 + halfWidth * 4 + self.margin * 4;
    NSPoint s13p0 = s1p0; s13p0.y -= offset;
    NSPoint s13p1 = s1p1; s13p1.y -= offset;
    NSPoint s13p2 = s1p2; s13p2.y -= offset;
    NSPoint s13p3 = s1p3; s13p3.y -= offset;
    NSPoint s13p4 = s1p4; s13p4.y -= offset;
    NSPoint s13p5 = s1p5; s13p5.y -= offset;
    [self drawSegment:{s13p0, s13p1, s13p2, s13p3, s13p4, s13p5, s13p0} state:states[13]];

    /// Floating point
    if (self.displayfloatingPoint) {
        NSBezierPath* ovalPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(s13p3.x + halfWidth / 2., s13p3.y - halfWidth * 1.5, halfWidth * 1.5, halfWidth * 1.5)];
        if (self.floatingPointOn) {
            [self.accentColor setFill];
        } else {
            [self.offColor setFill];
        }
        [ovalPath fill];
    }
}

@end
