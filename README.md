UINavigationItem+Margin
=======================

[![Build Status](https://travis-ci.org/devxoul/UINavigationItem-Margin.svg?branch=master)](https://travis-ci.org/devxoul/UINavigationItem-Margin)
[![CocoaPods](http://img.shields.io/cocoapods/v/UINavigationItem+Margin.svg?style=flat)](http://cocoapods.org/?q=name%3AUINavigationItem%2BMargin%20author%3Adevxoul)

Margin for UINavigationItem.


Setting Margins
---------------

Just set `leftMargin` and `rightMargin` of your UINavigationItem.

```objc
navigationItem.leftMargin = 0;
navigationItem.rightMargin = 0;
```

![zero](https://cloud.githubusercontent.com/assets/931655/5898748/e1d333a0-a595-11e4-85a3-9a492d1d38fc.png)

Wow, margin has disappeared.

Even you can do this:

```objc
navigationItem.leftMargin = 50;
navigationItem.rightMargin = 20;
```

![ugly](https://cloud.githubusercontent.com/assets/931655/6410361/12d1c69e-beb2-11e4-9cf6-7f7d9469ef09.png)

Looks ugly but works.


System Margins
--------------

Want to restore margins? Use `[UINavigationItem systemMargin]`.

```objc
navigationItem.leftMargin = [UINavigationItem systemMargin]; // 16 on iOS 7+
navigationItem.rightMargin = [UINavigationItem systemMargin];
```

![system](https://cloud.githubusercontent.com/assets/931655/6410333/d42763d6-beb1-11e4-845e-34002d336034.png)


Installation
------------

I recommend you to use [CocoaPods](http://cocoapods.org).

**Podfile**

```ruby
pod 'UINavigationItem+Margin'
```


License
-------

**UINavigationItem+Margin** is under MIT license. See the LICENSE file for more info.
