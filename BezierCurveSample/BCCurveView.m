//
//  BCCurveView.m
//  BezierCurveSample
//
//  Created by Shogo on 2013/02/17.
//  Copyright (c) 2013年 oropon. All rights reserved.
//

#import "BCCurveView.h"
#import "BCProjectController.h"

@implementation BCCurveView

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeCurveAttributes:) name:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (void)didChangeCurveAttributes:(NSNotification*)notification
{
    self.needsDisplay = YES;
}

NSPoint linear_bezier_pt(NSPoint p0, NSPoint p1, float t)
{
    float s = 1.f - t;
    return NSMakePoint(s * p0.x + t * p1.x, s * p0.y + t * p1.y);
}

NSPoint cubic_bezier_pt(NSPoint p0, NSPoint p1, NSPoint p2, NSPoint p3, float t)
{
    float (^solveCubic)(float, float, float, float, float) = ^float(float x0, float x1, float x2, float x3, float t) {
        float s = 1.f - t;
        return powf(s, 3) * x0 +
               3 * powf(s, 2) * t * x1 +
               3 * s * powf(t, 2) * x2 +
               powf(t, 3) * x3;
    };
    return NSMakePoint(solveCubic(p0.x, p1.x, p2.x, p3.x, t), solveCubic(p0.y, p1.y, p2.y, p3.y, t));
}

NSBezierPath* markForPoint(NSPoint pt)
{
    float radius = 3.f;
    NSRect markRect;
    markRect = NSMakeRect(pt.x - radius, pt.y - radius, 2.f * radius, 2.f * radius);
    return [NSBezierPath bezierPathWithRoundedRect:markRect xRadius:radius yRadius:radius];
}

float curveLength(NSPoint p0, NSPoint p1, NSPoint p2, NSPoint p3, int steps)
{
    float length = 0.f;
    for (int i = 0; i < steps; i++) {
        float stepT = 1.f / steps;
        float t0 = stepT * i;
        float t1 = stepT * (i + 1);
        NSPoint s0 = cubic_bezier_pt(p0, p1, p2, p3, t0);
        NSPoint s1 = cubic_bezier_pt(p0, p1, p2, p3, t1);
        length += powf(powf(fabsf(s1.x - s0.x), 2.f) + powf(fabsf(s1.y - s0.y), 2.f), 0.5f);
    }
    return length;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Get context
    CGContextRef context;
    context = [NSGraphicsContext currentContext].graphicsPort;
    
    // Draw background
    CGContextSetFillColorWithColor(context, [NSColor whiteColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
    // Get attributes
    NSDictionary*   attributes;
    NSPoint p0, p1, p2, p3;
    NSPoint q0, q1, q2;
    NSPoint r0, r1;
    NSPoint b;
    float t, s;
    BOOL drawAdditionalLines, drawCurve;;
    attributes = _projectController.curveAttributes;
    p0 = [attributes[BCProjectCurveAttributesP0Key] pointValue];
    p1 = [attributes[BCProjectCurveAttributesP1Key] pointValue];
    p2 = [attributes[BCProjectCurveAttributesP2Key] pointValue];
    p3 = [attributes[BCProjectCurveAttributesP3Key] pointValue];
    t = [attributes[BCProjectCurveAttributesTKey] floatValue];
    s = 1.f - t;
    drawAdditionalLines = [attributes[BCProjectCurveAttributesDrawAdditionalLinesKey] boolValue];
    drawCurve = [attributes[BCProjectCurveAttributesDrawCurveKey] boolValue];
    
    // Get points
    q0 = linear_bezier_pt(p0, p1, t);
    q1 = linear_bezier_pt(p1, p2, t);
    q2 = linear_bezier_pt(p2, p3, t);
    r0 = linear_bezier_pt(q0, q1, t);
    r1 = linear_bezier_pt(q1, q2, t);
    b = linear_bezier_pt(r0, r1, t);
    
    // Draw curve
    if (drawCurve) {
        // Get curve
        NSBezierPath*   curve;// p0 to p3
        NSBezierPath*   halfway;// p0 to b

        curve = [NSBezierPath bezierPath];
        [curve moveToPoint:p0];
        [curve curveToPoint:p3 controlPoint1:q1 controlPoint2:p2];
        
        halfway = [NSBezierPath bezierPath];
        [halfway moveToPoint:p0];
        [halfway curveToPoint:b controlPoint1:q0 controlPoint2:r0];
        
        [[NSColor redColor] setStroke];
        [halfway stroke];
    }
    
    // Draw 'p' lines
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextAddLineToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, p2.x, p2.y);
    CGContextAddLineToPoint(context, p3.x, p3.y);
    CGContextSetStrokeColorWithColor(context, [NSColor grayColor].CGColor);
    CGContextStrokePath(context);
    
    // Draw 'p' labels
    [@"p0" drawAtPoint:NSMakePoint(p0.x - 20.f, p0.y - 10.f) withAttributes:nil];
    [@"p1" drawAtPoint:NSMakePoint(p1.x - 20.f, p1.y - 10.f) withAttributes:nil];
    [@"p2" drawAtPoint:NSMakePoint(p2.x + 10.f, p2.y - 10.f) withAttributes:nil];
    [@"p3" drawAtPoint:NSMakePoint(p3.x + 10.f, p3.y - 10.f) withAttributes:nil];
    
    
    // Draw additional lines
    if (drawAdditionalLines) {
        // Draw 'q' lines
        CGContextMoveToPoint(context, q0.x, q0.y);
        CGContextAddLineToPoint(context, q1.x, q1.y);
        CGContextAddLineToPoint(context, q2.x, q2.y);
        CGContextSetStrokeColorWithColor(context, [NSColor greenColor].CGColor);
        CGContextStrokePath(context);
        
        // Draw 'q' points
        [[NSColor greenColor] setFill];
        [markForPoint(q0) fill];
        [markForPoint(q1) fill];
        
        // Draw 'q' labels
        [@"q0" drawAtPoint:NSMakePoint(q0.x - 20.f, q0.y - 10.f) withAttributes:nil];
        [@"q1" drawAtPoint:NSMakePoint(q1.x - 20.f, q1.y - 10.f) withAttributes:nil];
        [@"q2" drawAtPoint:NSMakePoint(q2.x - 20.f, q2.y - 10.f) withAttributes:nil];
        
        // Draw 'r' lines
        CGContextMoveToPoint(context, r0.x, r0.y);
        CGContextAddLineToPoint(context, r1.x, r1.y);
        CGContextSetStrokeColorWithColor(context, [NSColor blueColor].CGColor);
        CGContextStrokePath(context);
        
        // Draw 'r' points
        [[NSColor blueColor] setFill];
        [markForPoint(r0) fill];
        [markForPoint(r1) fill];
        
        // Draw 'r' labels
        [@"r0" drawAtPoint:NSMakePoint(r0.x - 20.f, r0.y - 10.f) withAttributes:nil];
        [@"r1" drawAtPoint:NSMakePoint(r1.x - 20.f, r1.y - 10.f) withAttributes:nil];

        // Draw 'b'
        [[NSColor redColor] setFill];
        [markForPoint(b) fill];
        
        // Draw 'b' label
        [@"b" drawAtPoint:NSMakePoint(b.x - 20.f, b.y - 10.f) withAttributes:nil];
    }
    
    [[NSString stringWithFormat:@"total length: %.3f, p0 to b: %.3f", curveLength(p0, p1, p2, p3, 10), curveLength(p0, q0, r0, b, 10)] drawAtPoint:NSMakePoint(0.f, 0.f) withAttributes:nil];
}

@end
