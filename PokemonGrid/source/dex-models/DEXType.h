//
//  DEXType.h
//  Dex
//
//  Created by Michael Zornek on 7/13/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEXType : NSObject {
	NSString *name;
}

@property (readwrite, copy) NSString *name;

+ (NSArray *)allTypes;

+ (DEXType *)normalType;
+ (DEXType *)fireType;
+ (DEXType *)waterType;
+ (DEXType *)electricType;
+ (DEXType *)grassType;
+ (DEXType *)iceType;
+ (DEXType *)fightingType;
+ (DEXType *)poisonType;
+ (DEXType *)groundType;
+ (DEXType *)flyingType;
+ (DEXType *)psychicType;
+ (DEXType *)bugType;
+ (DEXType *)rockType;
+ (DEXType *)ghostType;
+ (DEXType *)dragonType;
+ (DEXType *)darkType;
+ (DEXType *)steelType;

+ (DEXType *)singltonWithType:(NSString *)typeName;

- (NSArray *)movesAreSuperEffectiveAgainst;
- (NSArray *)movesAreNotVeryEffectiveAgainst;
- (NSArray *)movesHaveNoEffectiveAgainst;
- (NSArray *)defensivelyWeakTo;
- (NSArray *)defensivelyStrongTo;
- (NSArray *)defensivelyNoEffectTo;

- (UIColor *)color;

- (NSArray *)movesAreSuperEffectiveAgainstRateTable;
- (NSArray *)movesAreNotVeryEffectiveAgainstRateTable;
- (NSArray *)movesHaveNoEffectiveAgainstRateTable;

- (NSArray *)defensivelyWeakToRateTable;
- (NSArray *)defensivelyStrongToRateTable;
- (NSArray *)defensivelyNoEffectToRateTable;

@end
