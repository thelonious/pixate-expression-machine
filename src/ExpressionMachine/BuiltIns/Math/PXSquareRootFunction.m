//
//  PXSquareRootFunction.m
//  pixate-expression-machine
//
//  Created by Kevin Lindsey on 3/10/14.
//  Copyright (c) 2014 Pixate, Inc. All rights reserved.
//

#import "PXSquareRootFunction.h"

@implementation PXSquareRootFunction

#pragma mark - PXFunctionValue Implementation

- (void)invokeWithEnvironment:(PXExpressionEnvironment *)env
             invocationObject:(id<PXExpressionValue>)invocationObject
                         args:(id<PXExpressionArray>)args
{
    if (args.length > 0)
    {
        id<PXExpressionValue> item = [args valueForIndex:0];

        [env pushDouble:sqrt(item.doubleValue)];
    }
    else
    {
        [env pushDouble:0.0];
    }
}

@end
