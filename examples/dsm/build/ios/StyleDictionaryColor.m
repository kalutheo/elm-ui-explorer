
//
// StyleDictionaryColor.m
//
// Do not edit directly
// Generated on Mon, 25 Feb 2019 23:27:23 GMT
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
[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f],
[UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f],
[UIColor colorWithRed:0.07f green:0.07f blue:0.07f alpha:1.00f],
[UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:0.00f green:1.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:0.00f green:1.00f blue:0.00f alpha:1.00f],
[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]
    ];
  });

  return colorArray;
}

@end
