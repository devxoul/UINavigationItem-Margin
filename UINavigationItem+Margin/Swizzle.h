//
//  Swizzle.h
//  UINavigationItem+Margin
//
//  Created by Suyeol Jeon on 17/10/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

void _navigationitem_margin_swizzle_self(Class class, NSString *oldSelectorName);
void _navigationitem_margin_swizzle(Class oldClass, NSString *oldSelectorName, Class newClass);
void swizzleUINavigationBarContentViewIfNeeded(void);
