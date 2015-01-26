//
// The MIT License (MIT)
//
// Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import <objc/runtime.h>

#import "UINavigationItem+Margin.h"

@implementation UINavigationItem (Margin)

+ (void)load
{
    // left
    [self sj_swizzle:@selector(leftBarButtonItem)];
    [self sj_swizzle:@selector(setLeftBarButtonItem:animated:)];
    [self sj_swizzle:@selector(leftBarButtonItems)];
    [self sj_swizzle:@selector(setLeftBarButtonItems:animated:)];

    // right
    [self sj_swizzle:@selector(rightBarButtonItem)];
    [self sj_swizzle:@selector(setRightBarButtonItem:animated:)];
    [self sj_swizzle:@selector(rightBarButtonItems)];
    [self sj_swizzle:@selector(setRightBarButtonItems:animated:)];
}

+ (void)sj_swizzle:(SEL)selector
{
    NSString *name = [NSString stringWithFormat:@"sj_%@", NSStringFromSelector(selector)];

    Method m1 = class_getInstanceMethod(self, selector);
    Method m2 = class_getInstanceMethod(self, NSSelectorFromString(name));

    method_exchangeImplementations(m1, m2);
}


#pragma mark -

#pragma mark Margin

+ (CGFloat)systemMargin
{
    return 16; // iOS 7
}

+ (void)removeSystemMargin
{
    [self setSystemMarginRemoved:YES];
}

+ (void)restoreSystemMargin
{
    [self setSystemMarginRemoved:NO];
}

+ (BOOL)systemMarginRemoved
{
    return [objc_getAssociatedObject(self, @selector(systemMarginRemoved)) boolValue];
}

+ (void)setSystemMarginRemoved:(BOOL)removed
{
    objc_setAssociatedObject(self, @selector(systemMarginRemoved), @(removed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)margin
{
    CGFloat margin = [objc_getAssociatedObject(self, @selector(margin)) floatValue];
    if ([self systemMarginRemoved]) {
        margin -= [self systemMargin];
    }
    return margin;
}

+ (void)setMargin:(CGFloat)margin
{
    return objc_setAssociatedObject(self, @selector(margin), @(margin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIBarButtonItem *)spacer
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                          target:self
                                                                          action:nil];
    item.width = [self margin];
    return item;
}


#pragma mark Left Items

- (NSArray *)sj_leftItems
{
    return objc_getAssociatedObject(self, @selector(sj_leftItems));
}

- (void)sj_setLeftItems:(NSArray *)items
{
    objc_setAssociatedObject(self, @selector(sj_leftItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Left Bar Button Item(s)

- (UIBarButtonItem *)leftBarButtonItem
{
    return [self leftBarButtonItems].firstObject;
}

- (void)sj_setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
    [self setLeftBarButtonItems:@[item] animated:animated];
}

- (NSArray *)sj_leftBarButtonItems
{
    return [self sj_leftItems];
}

- (void)sj_setLeftBarButtonItems:(NSArray *)items animated:(BOOL)animated
{
    [self sj_setLeftItems:items];
    [self sj_setLeftBarButtonItems:[@[[self.class spacer]] arrayByAddingObjectsFromArray:items] animated:animated];
}


#pragma mark Right Items

- (NSArray *)sj_rightItems
{
    return objc_getAssociatedObject(self, @selector(sj_rightItems));
}

- (void)sj_setRightItems:(NSArray *)items
{
    objc_setAssociatedObject(self, @selector(sj_rightItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Right Bar Button Item(s)

- (UIBarButtonItem *)rightBarButtonItem
{
    return [self rightBarButtonItems].firstObject;
}

- (void)sj_setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
    [self setRightBarButtonItems:@[item] animated:animated];
}

- (NSArray *)sj_rightBarButtonItems
{
    return [self sj_rightItems];
}

- (void)sj_setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated
{
    [self sj_setRightItems:items];
    [self sj_setRightBarButtonItems:[@[[self.class spacer]] arrayByAddingObjectsFromArray:items] animated:animated];
}

@end
