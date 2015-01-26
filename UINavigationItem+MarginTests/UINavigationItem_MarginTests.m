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

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation UINavigationItem_MarginTests

- (void)setUp
{
    [super setUp];

    self.viewController = [[UIViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                    target:nil
                                                                    action:nil];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:nil
                                                                    action:nil];
}

- (void)tearDown
{
    [UINavigationItem restoreSystemMargin];
    [UINavigationItem setMargin:0];
    [super tearDown];
}


#pragma mark - System Margin

- (void)testRemoveSystemMargin
{
    [UINavigationItem removeSystemMargin];
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    UIButton *button = [self.editButton valueForKey:@"view"];
    XCTAssert(CGRectGetMinX(button.frame) == -16);
}


#pragma mark - Left

- (void)testLeftBarButtonItemPosition
{
    [UINavigationItem setMargin:-16];
    self.viewController.navigationItem.leftBarButtonItem = self.editButton;
    UIButton *button = [self.editButton valueForKey:@"view"];
    XCTAssert(CGRectGetMinX(button.frame) == -16);
}

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

- (void)testLeftSetEmptyItems
{
    self.viewController.navigationItem.leftBarButtonItems = @[];
    XCTAssertNil(self.viewController.navigationItem.leftBarButtonItem);
}


#pragma mark - Right

- (void)testRightBarButtonItemPosition
{
    [UINavigationItem setMargin:-16];
    self.viewController.navigationItem.rightBarButtonItem = self.editButton;
    UIButton *button = [self.editButton valueForKey:@"view"];
    XCTAssert(CGRectGetMaxX(button.frame) == CGRectGetMaxX(self.navigationController.navigationBar.frame) + 16);
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

- (void)testRightSetEmptyItems
{
    self.viewController.navigationItem.rightBarButtonItems = @[];
    XCTAssertNil(self.viewController.navigationItem.rightBarButtonItem);
}

@end
