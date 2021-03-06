//
//  PXExpressionUnit.m
//  pixate-expression-machine
//
//  Created by Kevin Lindsey on 3/2/14.
//  Copyright (c) 2014 Pixate, Inc. All rights reserved.
//

#import "PXExpressionUnit.h"
#import "PXExpressionEnvironment.h"
#import "PXExpressionByteCode.h"
#import "PXExpressionNodeUtils.h"

@implementation PXExpressionUnit

#pragma mark - Initializers

- (id)initWithByteCode:(PXExpressionByteCode *)byteCode
{
    return [self initWithByteCode:byteCode scope:nil ast:nil];
}

- (id)initWithByteCode:(PXExpressionByteCode *)byteCode scope:(id<PXExpressionScope>)scope
{
    return [self initWithByteCode:byteCode scope:scope ast:nil];
}

- (id)initWithByteCode:(PXExpressionByteCode *)byteCode scope:(id<PXExpressionScope>)scope ast:(id<PXExpressionNode>)ast
{
    if (self = [super init])
    {
        _byteCode = byteCode;
        _scope = scope;
        _ast = ast;
    }

    return self;
}

#pragma mark - Methods

- (void)executeWithEnvironment:(id)env
{
    if (_scope != nil)
    {
        [env pushScope:_scope];
    }

    [env executeByteCode:_byteCode];

    if (_scope != nil)
    {
        [env popScope];
    }
}

#pragma mark - Overrides

- (NSString *)description
{
    NSMutableArray *parts = [[NSMutableArray alloc] init];

    if (_ast != nil)
    {
        [parts addObject:@""];
        [parts addObject:@"AST"];
        [parts addObject:@"---"];
        [parts addObject:[PXExpressionNodeUtils descriptionForNode:_ast]];
    }

    if (_scope != nil)
    {
        [parts addObject:@""];
        [parts addObject:@"Scope"];
        [parts addObject:@"-----"];
        [parts addObject:_scope.description];
    }

    if (_byteCode != nil)
    {
        [parts addObject:@""];
        [parts addObject:@"Byte Code"];
        [parts addObject:@"---------"];
        [parts addObject:_byteCode.description];
    }

    return [parts componentsJoinedByString:@"\n"];
}

@end
