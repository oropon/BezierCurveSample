//
//  BCProjectController.h
//  BezierCurveSample
//
//  Created by Shogo on 2013/02/17.
//  Copyright (c) 2013年 oropon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString* const BCProjectCurveAttributesDidChangeNotification;
extern NSString* const BCProjectCurveAttributesP0Key;
extern NSString* const BCProjectCurveAttributesP1Key;
extern NSString* const BCProjectCurveAttributesP2Key;
extern NSString* const BCProjectCurveAttributesP3Key;
extern NSString* const BCProjectCurveAttributesTKey;
extern NSString* const BCProjectCurveAttributesDrawAdditionalLinesKey;
extern NSString* const BCProjectCurveAttributesDrawCurveKey;

@class BCAttributesPanel;
@class BCCurveView;
@interface BCProjectController : NSView

@property (nonatomic, weak) IBOutlet BCAttributesPanel* panel;
@property (nonatomic, weak) IBOutlet BCCurveView*   curveView;

- (NSDictionary*)curveAttributes;

@end
