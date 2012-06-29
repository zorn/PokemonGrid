//
//  DEXPokemon.h
//  Dex
//
//  Created by Michael Zornek on 7/13/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DEXType;

@interface DEXPokemon : NSObject {
	NSString *name;
	DEXType *typeOne;
	DEXType *typeTwo;
	
	NSInteger nationalDexNumber;
	NSInteger kantoDexNumber;
	NSInteger johtoDexNumber;
	NSInteger johtoRemakeDexNumber;
	NSInteger hoennDexNumber;
	NSInteger sinnohDexNumber;
	NSInteger isshuDexNumber;
	
	NSInteger evolutionChainID;
	NSString *evolutionDescription;
	
	NSUInteger hitPoints;
	NSUInteger attack;
	NSUInteger defense;
	NSUInteger specialAttack;
	NSUInteger specialDefense;
	NSUInteger speed;
	
	BOOL isBaby;
	
	NSMutableDictionary *_defensiveTable;
	NSMutableArray *_evolutionFamily;
}

@property (readwrite, copy) NSString *name;
@property (readwrite, retain) DEXType *typeOne;
@property (readwrite, retain) DEXType *typeTwo;
@property (readwrite, assign) NSInteger nationalDexNumber;
@property (readwrite, assign) NSInteger kantoDexNumber;
@property (readwrite, assign) NSInteger johtoDexNumber;
@property (readwrite, assign) NSInteger johtoRemakeDexNumber;
@property (readwrite, assign) NSInteger hoennDexNumber;
@property (readwrite, assign) NSInteger sinnohDexNumber;
@property (readwrite, assign) NSInteger isshuDexNumber;

@property (readwrite, assign) NSInteger evolutionChainID;
@property (readwrite, copy) NSString *evolutionDescription;

@property (readwrite, assign) NSUInteger hitPoints;
@property (readwrite, assign) NSUInteger attack;
@property (readwrite, assign) NSUInteger defense;
@property (readwrite, assign) NSUInteger specialAttack;
@property (readwrite, assign) NSUInteger specialDefense;
@property (readwrite, assign) NSUInteger speed;

@property (readwrite, assign) BOOL isBaby;

- (UIImage *)icon;
- (UIImage *)sprite;

- (NSDictionary *)defensiveTable;
- (NSArray *)defensivelyWeakToRateTable;
- (NSArray *)defensivelyStrongToRateTable;
- (NSArray *)defensivelyNoEffectToRateTable;

- (NSString *)urlStringForMarrilandGen5;
- (NSString *)urlStringForMarrilandGen4;

- (NSArray *)evolutionFamily;

@end
