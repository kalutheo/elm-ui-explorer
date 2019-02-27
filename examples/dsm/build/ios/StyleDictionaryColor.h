
//
// StyleDictionaryColor.h
//
// Do not edit directly
// Generated on Wed, 27 Feb 2019 13:02:38 GMT
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, StyleDictionaryColorName) {
ColorBrandPrimary,
ColorBrandPrimaryVariant,
ColorBrandSecondary,
ColorBrandSecondaryVariant,
ColorBrandAlternative,
ColorBrandAlternativeVariant
};

@interface StyleDictionaryColor : NSObject
+ (NSArray *)values;
+ (UIColor *)color:(StyleDictionaryColorName)color;
@end
