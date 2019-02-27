
//
// StyleDictionaryColor.m
//
// Do not edit directly
// Generated on Wed, 27 Feb 2019 13:02:38 GMT
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
[UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.00f]
    ];
  });

  return colorArray;
}

@end
