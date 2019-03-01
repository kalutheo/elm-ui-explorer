
//
// StyleDictionaryColor.m
//
// Do not edit directly
// Generated on Fri, 01 Mar 2019 08:29:14 GMT
//

#import "StyleDictionaryColor.h"


@implementation StyleDictionaryColor

+ (UIColor *)color:(StyleDictionaryColorName)colorEnum{
  return [[self values] objectAtIndex:colorEnum];
}

+ (NSArray *)values {
  static NSArray* colorArray;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    colorArray = @[
[UIColor colorWithRed:0.30f green:0.34f blue:0.38f alpha:1.00f],
[UIColor colorWithRed:0.84f green:0.81f blue:0.70f alpha:1.00f],
[UIColor colorWithRed:0.58f green:0.66f blue:0.67f alpha:1.00f],
[UIColor colorWithRed:0.65f green:0.62f blue:0.55f alpha:1.00f],
[UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:0.13f green:0.16f blue:0.18f alpha:1.00f],
[UIColor colorWithRed:0.24f green:0.28f blue:0.32f alpha:1.00f],
[UIColor colorWithRed:0.38f green:0.44f blue:0.48f alpha:1.00f],
[UIColor colorWithRed:0.53f green:0.58f blue:0.63f alpha:1.00f],
[UIColor colorWithRed:0.72f green:0.76f blue:0.80f alpha:1.00f],
[UIColor colorWithRed:0.85f green:0.88f blue:0.91f alpha:1.00f],
[UIColor colorWithRed:0.95f green:0.96f blue:0.97f alpha:1.00f],
[UIColor colorWithRed:0.97f green:0.98f blue:0.99f alpha:1.00f],
[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]
    ];
  });

  return colorArray;
}

@end
