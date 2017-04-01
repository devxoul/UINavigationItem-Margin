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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UINavigationItem+Margin.h"

@interface UINavigationItem_MarginTests : XCTestCase

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIBarButtonItem *customButton;

@end

@implementation UINavigationItem_MarginTests

- (void)setUp
{
    [super setUp];

    self.viewController = [[UIViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // we cannot use `-[UIWindow makeKeyAndVisible:]` on test environment.
    [self.window addSubview:self.navigationController.view];

    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                    target:nil
                                                                    action:nil];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:nil
                                                                    action:nil];

    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    customView.backgroundColor = [UIColor redColor];
    self.customButton = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)tearDown
{
    self.navigationController.navigationItem.leftMargin = [UINavigationItem systemMargin];
    self.navigationController.navigationItem.rightMargin = [UINavigationItem systemMargin];
    [super tearDown];
}


#pragma mark -

CGRect relativeRect(UIBarButtonItem *barButtonItem)
{
    UIButton *button = [barButtonItem valueForKey:@"view"];
    return [button.superview convertRect:button.frame fromView:button.superview];
}

CGFloat left(UIBarButtonItem *barButtonItem)
{
    return CGRectGetMinX(relativeRect(barButtonItem));
}

CGFloat right(UIBarButtonItem *barButtonItem)
{
    UIButton *button = [barButtonItem valueForKey:@"view"];
    return CGRectGetWidth(button.superview.bounds) - CGRectGetMaxX(relativeRect(barButtonItem));
}


#pragma mark - Get/Set Items

- (void)testLeftSetItemGetItem
{
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    XCTAssertEqual(self.viewController.navigationItem.leftBarButtonItem, self.editButton);
}

- (void)testLeftSetItemGetItems
{
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    XCTAssertEqual(self.viewController.navigationItem.leftBarButtonItems[0], self.editButton);
}

- (void)testLeftSetItemsGetItem
{
    self.viewController.navigationItem.leftBarButtonItems = @[self.editButton, self.doneButton];
    XCTAssertEqual(self.viewController.navigationItem.leftBarButtonItem, self.editButton);
}

- (void)testLeftSetItemsGetItems
{
    self.viewController.navigationItem.leftBarButtonItems = @[self.editButton, self.doneButton];
    XCTAssertEqual(self.viewController.navigationItem.leftBarButtonItems[0], self.editButton);
}

- (void)testLeftSetNil
{
    self.viewController.navigationItem.leftBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.leftBarButtonItem);
}

- (void)testLeftSetNilAfterSetItem
{
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    self.viewController.navigationItem.leftBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.leftBarButtonItem);
}

- (void)testLeftSetNilAfterSetItems
{
    self.viewController.navigationItem.leftBarButtonItems = @[self.editButton, self.doneButton];
    self.viewController.navigationItem.leftBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.leftBarButtonItem);
}

- (void)testLeftSetEmptyItems
{
    self.viewController.navigationItem.leftBarButtonItems = @[];
    XCTAssertNil(self.viewController.navigationItem.leftBarButtonItem);
}

- (void)testRightSetItemGetItem
{
    self.viewController.navigationItem.rightBarButtonItem = self.editButton;
    XCTAssertEqual(self.viewController.navigationItem.rightBarButtonItem, self.editButton);
}

- (void)testRightSetItemGetItems
{
    self.viewController.navigationItem.rightBarButtonItem = self.editButton;
    XCTAssertEqual(self.viewController.navigationItem.rightBarButtonItems[0], self.editButton);
}

- (void)testRightSetItemsGetItem
{
    self.viewController.navigationItem.rightBarButtonItems = @[self.editButton, self.doneButton];
    XCTAssertEqual(self.viewController.navigationItem.rightBarButtonItem, self.editButton);
}

- (void)testRightSetItemsGetItems
{
    self.viewController.navigationItem.rightBarButtonItems = @[self.editButton, self.doneButton];
    XCTAssertEqual(self.viewController.navigationItem.rightBarButtonItems[0], self.editButton);
}

- (void)testRightSetNil
{
    self.viewController.navigationItem.rightBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.rightBarButtonItem);
}

- (void)testRightSetNilAfterSetItem
{
    self.viewController.navigationItem.rightBarButtonItem = self.doneButton;
    self.viewController.navigationItem.rightBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.rightBarButtonItem);
}

- (void)testRightSetNilAfterSetItems
{
    self.viewController.navigationItem.rightBarButtonItems = @[self.editButton, self.doneButton];
    self.viewController.navigationItem.rightBarButtonItem = nil;
    XCTAssertNil(self.viewController.navigationItem.rightBarButtonItem);
}

- (void)testRightSetEmptyItems
{
    self.viewController.navigationItem.rightBarButtonItems = @[];
    XCTAssertNil(self.viewController.navigationItem.rightBarButtonItem);
}


#pragma mark - Default Margin

- (void)testDefaultLeftMargin
{
    XCTAssertEqual(self.viewController.navigationItem.leftMargin, [UINavigationItem systemMargin]);
}

- (void)testDefaultRightMargin
{
    XCTAssertEqual(self.viewController.navigationItem.rightMargin, [UINavigationItem systemMargin]);
}


#pragma mark - UINavigationItem

- (void)testLeftMargin_UINavigationItem
{
    self.viewController.navigationItem.leftMargin = 10;
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    XCTAssertEqual(left(self.viewController.navigationItem.leftBarButtonItem), 10);
}

- (void)testRightMargin_UINavigationItem
{
    self.viewController.navigationItem.rightMargin = 11;
    self.viewController.navigationItem.rightBarButtonItem = self.doneButton;
    XCTAssertEqual(right(self.viewController.navigationItem.rightBarButtonItem), 11);
}

- (void)testLeftMargin_UINavigationItem_later
{
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    self.viewController.navigationItem.leftMargin = 12;
    XCTAssertEqual(left(self.viewController.navigationItem.leftBarButtonItem), 12);
}

- (void)testRightMargin_UINavigationItem_later
{
    self.viewController.navigationItem.rightMargin = 13;
    self.viewController.navigationItem.rightBarButtonItem = self.doneButton;
    XCTAssertEqual(right(self.viewController.navigationItem.rightBarButtonItem), 13);
}


#pragma mark - Custom View

- (void)testLeftMargin_customView
{
    self.viewController.navigationItem.leftMargin = 10;
    self.viewController.navigationItem.leftBarButtonItem = self.customButton;
    XCTAssertEqual(left(self.viewController.navigationItem.leftBarButtonItem), 10);
}

- (void)testRightMargin_customView
{
    self.viewController.navigationItem.rightMargin = 10;
    self.viewController.navigationItem.rightBarButtonItem = self.customButton;
    XCTAssertEqual(right(self.viewController.navigationItem.rightBarButtonItem), 10);
}

- (void)testLeftMargin_customView_later
{
    self.viewController.navigationItem.leftBarButtonItem = self.customButton;
    self.viewController.navigationItem.leftMargin = 10;
    XCTAssertEqual(left(self.viewController.navigationItem.leftBarButtonItem), 10);
}

- (void)testRightMargin_customView_later
{
    self.viewController.navigationItem.rightBarButtonItem = self.customButton;
    self.viewController.navigationItem.rightMargin = 10;
    XCTAssertEqual(right(self.viewController.navigationItem.rightBarButtonItem), 10);
}

@end
