
//
// StyleDictionaryColor.h
//
// Do not edit directly
// Generated on Tue, 26 Feb 2019 23:12:33 GMT
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
