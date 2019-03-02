
//
// StyleDictionaryColor.h
//
// Do not edit directly
// Generated on Sat, 02 Mar 2019 22:59:36 GMT
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, StyleDictionaryColorName) {
ColorBrandPrimary,
ColorBrandPrimaryVariant,
ColorBrandSecondary,
ColorBrandSecondaryVariant,
ColorBrandAlternative,
ColorBrandAlternativeVariant,
ColorNeutralBlack,
ColorNeutralGreyDarkest,
ColorNeutralGreyDarker,
ColorNeutralGreyDark,
ColorNeutralGrey,
ColorNeutralGreyLight,
ColorNeutralGreyLighter,
ColorNeutralGreyLightest,
ColorNeutralWhite
};

@interface StyleDictionaryColor : NSObject
+ (NSArray *)values;
+ (UIColor *)color:(StyleDictionaryColorName)color;
@end
