//
//  Swizzle.m
//  UINavigationItem+Margin
//
//  Created by Suyeol Jeon on 17/10/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Swizzle.h"

void _navigationitem_margin_swizzle_full(Class oldClass, NSString *oldSelectorName,
                                         Class newClass, NSString *newSelectorName) {
    Method old = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelectorName));
    Method new = class_getInstanceMethod(newClass, NSSelectorFromString(newSelectorName));
    method_exchangeImplementations(old, new);
}

void _navigationitem_margin_swizzle_self(Class class, NSString *oldSelectorName) {
    _navigationitem_margin_swizzle(class, oldSelectorName, class);
}

void _navigationitem_margin_swizzle(Class oldClass, NSString *oldSelectorName, Class newClass) {
    NSString *newSelectorName = [NSString stringWithFormat:@"_navigationitem_margin_%@", oldSelectorName];
    _navigationitem_margin_swizzle_full(oldClass, oldSelectorName, newClass, newSelectorName);
}

