//
//  BCProjectController.m
//  BezierCurveSample
//
//  Created by Shogo on 2013/02/17.
//  Copyright (c) 2013年 oropon. All rights reserved.
//

NSString* const BCProjectCurveAttributesDidChangeNotification = @"BCProjectCurveAttributesDidChangeNotification";
NSString* const BCProjectCurveAttributesP0Key = @"BCProjectCurveAttributesP0Key";
NSString* const BCProjectCurveAttributesP1Key = @"BCProjectCurveAttributesP1Key";
NSString* const BCProjectCurveAttributesP2Key = @"BCProjectCurveAttributesP2Key";
NSString* const BCProjectCurveAttributesP3Key = @"BCProjectCurveAttributesP3Key";
NSString* const BCProjectCurveAttributesTKey = @"BCProjectCurveAttributesTKey";
NSString* const BCProjectCurveAttributesDrawAdditionalLinesKey = @"BCProjectCurveAttributesDrawAdditionalLinesKey";
NSString* const BCProjectCurveAttributesDrawCurveKey = @"BCProjectCurveAttributesDrawCurveKey";

#import "BCProjectController.h"
#import "BCAttributesPanel.h"
#import "BCCurveView.h"

@implementation BCProjectController

- (NSDictionary *)curveAttributes
{
    return @{
        BCProjectCurveAttributesP0Key: [NSValue valueWithPoint:_panel.p0],
        BCProjectCurveAttributesP1Key: [NSValue valueWithPoint:_panel.p1],
        BCProjectCurveAttributesP2Key: [NSValue valueWithPoint:_panel.p2],
        BCProjectCurveAttributesP3Key: [NSValue valueWithPoint:_panel.p3],
        BCProjectCurveAttributesTKey: [NSNumber numberWithFloat:_panel.t],
        BCProjectCurveAttributesDrawAdditionalLinesKey: [NSNumber numberWithBool:_panel.drawAdditionalLines],
        BCProjectCurveAttributesDrawCurveKey: [NSNumber numberWithBool:_panel.drawCurve],
    };
}


@end
