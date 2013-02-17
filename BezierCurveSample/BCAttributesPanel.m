//
//  BCAttributesPanel.m
//  BezierCurveSample
//
//  Created by Shogo on 2013/02/17.
//  Copyright (c) 2013年 oropon. All rights reserved.
//

#import "BCAttributesPanel.h"
#import "BCProjectController.h"

@implementation BCAttributesPanel
{
    IBOutlet __weak NSTextField*    _p0XTextField;
    IBOutlet __weak NSTextField*    _p0YTextField;
    IBOutlet __weak NSTextField*    _p1XTextField;
    IBOutlet __weak NSTextField*    _p1YTextField;
    IBOutlet __weak NSTextField*    _p2XTextField;
    IBOutlet __weak NSTextField*    _p2YTextField;
    IBOutlet __weak NSTextField*    _p3XTextField;
    IBOutlet __weak NSTextField*    _p3YTextField;
    IBOutlet __weak NSTextField*    _tTextField;
    IBOutlet __weak NSStepper*      _tStepper;
    IBOutlet __weak NSButton*       _drawAdditionalLineCheckBox;
    IBOutlet __weak NSButton*       _drawCurveCheckBox;

}

- (void)awakeFromNib
{
    [_p0XTextField setFloatValue:50.0f];
    [_p0YTextField setFloatValue:50.0f];
    [_p1XTextField setFloatValue:30.0f];
    [_p1YTextField setFloatValue:400.0f];
    [_p2XTextField setFloatValue:300.0f];
    [_p2YTextField setFloatValue:400.0f];
    [_p3XTextField setFloatValue:500.0f];
    [_p3YTextField setFloatValue:50.0f];
    [_tTextField setFloatValue:0.5f];
    [_tStepper setFloatValue:0.5f];
}

- (NSPoint)p0
{
    return NSMakePoint(_p0XTextField.floatValue, _p0YTextField.floatValue);
}

- (NSPoint)p1
{
    return NSMakePoint(_p1XTextField.floatValue, _p1YTextField.floatValue);
}

- (NSPoint)p2
{
    return NSMakePoint(_p2XTextField.floatValue, _p2YTextField.floatValue);
}

- (NSPoint)p3
{
    return NSMakePoint(_p3XTextField.floatValue, _p3YTextField.floatValue);
}

- (float)t
{
    return _tTextField.floatValue;
}

- (BOOL)drawAdditionalLines
{
    return (_drawAdditionalLineCheckBox.state == NSOnState);
}

- (BOOL)drawCurve
{
    return (_drawCurveCheckBox.state == NSOnState);
}

- (IBAction)p0Action:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)p1Action:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)p2Action:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)p3Action:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)tAction:(id)sender {
    float t = [sender floatValue];
    if (t < 0.f) {
        t = 0.f;
    }
    else if (t > 1.f) {
        t = 1.f;
    }
    if (t != [sender floatValue]) {
        [sender setFloatValue:t];
    }
    [_tStepper setFloatValue:t];
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)drawAdditionalLinesAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}

- (IBAction)drawCurveAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];    
}

- (IBAction)tStepperAction:(id)sender {
    [_tTextField setFloatValue:[sender floatValue]];
    [[NSNotificationCenter defaultCenter] postNotificationName:BCProjectCurveAttributesDidChangeNotification object:nil];
}


@end
