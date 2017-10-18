//
//  UINavigationBarContentView+Margin.m
//  UINavigationItem+Margin
//
//  Created by Suyeol Jeon on 17/10/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

#import "UINavigationBarContentViewLayout+Margin.h"
#import "Swizzle.h"

@implementation NSObject (UINavigationBarContentViewLayout_Margin)

void perform(id object, NSString *selectorName)
{
    SEL selector = NSSelectorFromString(selectorName);
    IMP imp = [object methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(object, selector);
}

- (void)_navigationitem_margin_layoutSubviews {
    [self _navigationitem_margin_layoutSubviews];
    if (![NSStringFromClass(self.class) isEqualToString:@"_UINavigationBarContentView"]) {
        return;
    }

    id layout = [self valueForKey:@"_layout"];
    if (!layout) {
        return;
    }
    perform(layout, @"_updateMarginConstraints");
}

@end
