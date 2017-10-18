//
//  UINavigationBarContentViewLayout+Margin.m
//  UINavigationItem+Margin
//
//  Created by Suyeol Jeon on 17/10/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

#import "UINavigationBarContentViewLayout+Margin.h"
#import "Swizzle.h"

@implementation NSObject (UINavigationBarContentViewLayout_Margin)

- (void)_navigationitem_margin__updateMarginConstraints {
    [self _navigationitem_margin__updateMarginConstraints];
    [self _manipulateLeadingBarConstraints];
    [self _manipulateTrailingBarConstraints];
}

- (void)_manipulateLeadingBarConstraints {
    NSArray<NSLayoutConstraint *> *leadingBarConstraints = [self valueForKey:@"_leadingBarConstraints"];
    if (!leadingBarConstraints) {
        return;
    }
    for (NSLayoutConstraint *constraint in leadingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeLeading) {
            constraint.constant = -16;
        }
    }
}

- (void)_manipulateTrailingBarConstraints {
    NSArray<NSLayoutConstraint *> *trailingBarConstraints = [self valueForKey:@"_trailingBarConstraints"];
    if (!trailingBarConstraints) {
        return;
    }
    for (NSLayoutConstraint *constraint in trailingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTrailing) {
            constraint.constant = 16;
        }
    }
}

@end
