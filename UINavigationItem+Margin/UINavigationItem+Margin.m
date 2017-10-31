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

#import <execinfo.h>
#import <objc/runtime.h>

#import "UINavigationItem+Margin.h"
#import "Swizzle.h"

#define isCalledFromSystem (BOOL)^(void) { \
    int depth = 3; \
    void *callstack[depth]; \
    int frames = backtrace(callstack, depth); \
    char **symbols = backtrace_symbols(callstack, frames); \
    int contains = 0; \
    if (strstr(symbols[depth - 1], "UIKit") != NULL) { \
        contains = 1; \
    } \
    free(symbols); \
    return contains; \
}()
#define iOS11 (BOOL)^(void){ \
    if (@available(iOS 11, *)) { \
        return YES; \
    } else { \
        return NO; \
    } \
}()

@implementation UINavigationItem (Margin)

+ (void)load {
    // left
    _navigationitem_margin_swizzle_self(self, @"leftBarButtonItem");
    _navigationitem_margin_swizzle_self(self, @"setLeftBarButtonItem:animated:");
    _navigationitem_margin_swizzle_self(self, @"leftBarButtonItems");
    _navigationitem_margin_swizzle_self(self, @"setLeftBarButtonItems:animated:");

    // right
    _navigationitem_margin_swizzle_self(self, @"rightBarButtonItem");
    _navigationitem_margin_swizzle_self(self, @"setRightBarButtonItem:animated:");
    _navigationitem_margin_swizzle_self(self, @"rightBarButtonItems");
    _navigationitem_margin_swizzle_self(self, @"setRightBarButtonItems:animated:");
}

#pragma mark - Global

+ (CGFloat)systemMargin {
    return 16; // iOS 7~
}


#pragma mark - Spacer

- (UIBarButtonItem *)spacerForItem:(UIBarButtonItem *)item withMargin:(CGFloat)margin {
    UIBarButtonSystemItem type = UIBarButtonSystemItemFixedSpace;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:type target:self action:nil];
    if (iOS11) {
        spacer.width = margin + 8;
    } else {
        spacer.width = margin - [self.class systemMargin];
    }

    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    // a margin of private class `UINavigationButton` is different from custom view
    if (!iOS11 && !item.customView && screenWidth < 375) { // 3.5 and 4 inch
        spacer.width += 8;
    } else if (screenWidth >= 414) { // 5.5 inch
        spacer.width -= 4;
    }
    return spacer;
}

- (UIBarButtonItem *)leftSpacerForItem:(UIBarButtonItem *)item {
    return [self spacerForItem:item withMargin:self.leftMargin];
}

- (UIBarButtonItem *)rightSpacerForItem:(UIBarButtonItem *)item {
    return [self spacerForItem:item withMargin:self.rightMargin];
}


#pragma mark - Margin

- (void)initializeMarginsIfNeeded {
    NSNumber *leftMargin = objc_getAssociatedObject(self, @selector(leftMargin));
    if (!leftMargin) {
        self.leftMargin = [self.class systemMargin];
    }

    NSNumber *rightMargin = objc_getAssociatedObject(self, @selector(rightMargin));
    if (!rightMargin) {
        self.rightMargin = [self.class systemMargin];
    }
}

- (CGFloat)leftMargin {
    [self initializeMarginsIfNeeded];
    NSNumber *value = objc_getAssociatedObject(self, @selector(leftMargin));
    return value.floatValue;
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    swizzleUINavigationBarContentViewIfNeeded();
    objc_setAssociatedObject(self, @selector(leftMargin), @(leftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.leftBarButtonItems = self.leftBarButtonItems;
}

- (CGFloat)rightMargin {
    [self initializeMarginsIfNeeded];
    NSNumber *value = objc_getAssociatedObject(self, @selector(rightMargin));
    return value.floatValue;
}

- (void)setRightMargin:(CGFloat)rightMargin {
    swizzleUINavigationBarContentViewIfNeeded();
    objc_setAssociatedObject(self, @selector(rightMargin), @(rightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.rightBarButtonItems = self.rightBarButtonItems;
}


#pragma mark - Original Bar Button Items

- (NSArray *)originalLeftBarButtonItems {
    NSArray *items = objc_getAssociatedObject(self, @selector(originalLeftBarButtonItems));
    if (!items) {
        items = [self _navigationitem_margin_leftBarButtonItems];
        self.originalLeftBarButtonItems = items;
    }
    return items;
}

- (void)setOriginalLeftBarButtonItems:(NSArray *)items {
    objc_setAssociatedObject(self, @selector(originalLeftBarButtonItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)originalRightBarButtonItems {
    NSArray *items = objc_getAssociatedObject(self, @selector(originalRightBarButtonItems));
    if (!items) {
        items = [self _navigationitem_margin_rightBarButtonItems];
        self.originalRightBarButtonItems = items;
    }
    return items;
}

- (void)setOriginalRightBarButtonItems:(NSArray *)items {
    objc_setAssociatedObject(self, @selector(originalRightBarButtonItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Bar Button Item

- (UIBarButtonItem *)_navigationitem_margin_leftBarButtonItem {
    if (iOS11 && isCalledFromSystem) {
        return [self _navigationitem_margin_leftBarButtonItem];
    } else {
        return self.originalLeftBarButtonItems.firstObject;
    }
}

- (void)_navigationitem_margin_setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    if (!item) {
        [self setLeftBarButtonItems:nil animated:animated];
    } else {
        [self setLeftBarButtonItems:@[item] animated:animated];
    }
}

- (UIBarButtonItem *)_navigationitem_margin_rightBarButtonItem {
    if (iOS11 && isCalledFromSystem) {
        return [self _navigationitem_margin_rightBarButtonItem];
    } else {
        return self.originalRightBarButtonItems.firstObject;
    }
}

- (void)_navigationitem_margin_setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    if (!item) {
        [self setRightBarButtonItems:nil animated:animated];
    } else {
        [self setRightBarButtonItems:@[item] animated:animated];
    }
}


#pragma mark - Bar Button Items

- (NSArray *)_navigationitem_margin_leftBarButtonItems {
    if (iOS11 && isCalledFromSystem) {
        return [self _navigationitem_margin_leftBarButtonItems];
    } else {
        return self.originalLeftBarButtonItems;
    }
}

- (void)_navigationitem_margin_setLeftBarButtonItems:(NSArray *)items animated:(BOOL)animated {
    if (items.count) {
        self.originalLeftBarButtonItems = items;
        UIBarButtonItem *spacer = [self leftSpacerForItem:items.firstObject];
        NSArray *itemsWithMargin = [@[spacer] arrayByAddingObjectsFromArray:items];
        [self _navigationitem_margin_setLeftBarButtonItems:itemsWithMargin animated:animated];
    } else {
        self.originalLeftBarButtonItems = nil;
        [self _navigationitem_margin_setLeftBarButtonItems:nil animated:animated];
    }
}

- (NSArray *)_navigationitem_margin_rightBarButtonItems {
    if (iOS11 && isCalledFromSystem) {
        return [self _navigationitem_margin_rightBarButtonItems];
    } else {
        return self.originalRightBarButtonItems;
    }
}

- (void)_navigationitem_margin_setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated {
    if (items.count) {
        self.originalRightBarButtonItems = items;
        UIBarButtonItem *spacer = [self rightSpacerForItem:items.firstObject];
        NSArray *itemsWithMargin = [@[spacer] arrayByAddingObjectsFromArray:items];
        [self _navigationitem_margin_setRightBarButtonItems:itemsWithMargin animated:animated];
    } else {
        self.originalRightBarButtonItems = nil;
        [self _navigationitem_margin_setRightBarButtonItems:nil animated:animated];
    }
}

@end
