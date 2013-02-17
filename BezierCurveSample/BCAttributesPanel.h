//
//  BCAttributesPanel.h
//  BezierCurveSample
//
//  Created by Shogo on 2013/02/17.
//  Copyright (c) 2013年 oropon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCAttributesPanel : NSPanel

@property (readonly) NSPoint p0;
@property (readonly) NSPoint p1;
@property (readonly) NSPoint p2;
@property (readonly) NSPoint p3;
@property (readonly) float t;
@property (readonly) BOOL drawAdditionalLines;
@property (readonly) BOOL drawCurve;

@end
