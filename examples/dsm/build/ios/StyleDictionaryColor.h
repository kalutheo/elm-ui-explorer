
//
// StyleDictionaryColor.h
//
// Do not edit directly
// Generated on Fri, 01 Mar 2019 08:29:14 GMT
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
