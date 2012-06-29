//
//  DEXMasterDex.h
//  Dex
//
//  Created by Michael Zornek on 7/16/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DEXPokemon;

@interface DEXMasterDex : NSObject {
	NSMutableDictionary *allPokemon;
}

- (void)loadPokemonFromCSV;
- (void)loadPokemonEvolutionInfoFromCSV;
- (void)loadPokemonGen5Names;
- (void)loadPokemonEvolutionDescriptionsFromCSV;

- (NSArray *)pokemonWhoHaveNonNegativeDexNumberFor:(NSString *)dexName;
- (NSArray *)nationalDex;
- (NSArray *)kantoDex;
- (NSArray *)johtoDex;
- (NSArray *)johtoRemakeDex;
- (NSArray *)hoennDex;
- (NSArray *)sinnohDex;
- (NSArray *)sinnohExtendedDex;
- (NSArray *)isshuDex;

- (DEXPokemon *)pokemonWithNationalDexNumber:(NSInteger)dexNumber;

#pragma mark -
#pragma mark Singleton Stuff

+ (DEXMasterDex *)sharedMasterDex;

@end
