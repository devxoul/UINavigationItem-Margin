UINavigationItem+Margin
=======================

[![Build Status](https://travis-ci.org/devxoul/UINavigationItem-Margin.svg?branch=master)](https://travis-ci.org/devxoul/UINavigationItem-Margin)
[![CocoaPods](http://img.shields.io/cocoapods/v/UINavigationItem+Margin.svg?style=flat)](http://cocoapods.org/?q=name%3AUINavigationItem%2BMargin%20author%3Adevxoul)

Margin for UINavigationItem.


At a Glance
-----------

In your `AppDelegate.m` (or anywhere you want to use it):

```objc
[UINavigationItem setMargin:-16];
```

![](https://cloud.githubusercontent.com/assets/931655/5898748/e1d333a0-a595-11e4-85a3-9a492d1d38fc.png)

Wow, margin has disappeared.

If you don't like magic number such as `-16`, you can use `removeSystemMargin` for the same result:

```objc
[UINavigationItem removeSystemMargin]; // -16 in iOS 7
```

You can use both of them:

```objc
[UINavigationItem removeSystemMargin];
[UINavigationItem setMargin:12];
```

![](https://cloud.githubusercontent.com/assets/931655/5898749/e1d72cc6-a595-11e4-84b7-e7fd3e116567.png)

Awesome, looks great.


Installation
------------

I recommend you to use [CocoaPods](http://cocoapods.org).

**Podfile**

```ruby
pod 'UINavigationItem+Margin'
```


License
-------

UINavigationItem+Margin is under MIT license. See the LICENSE file for more info.
