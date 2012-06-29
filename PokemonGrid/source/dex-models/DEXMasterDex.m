//
//  DEXMasterDex.m
//  Dex
//
//  Created by Michael Zornek on 7/16/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import "DEXMasterDex.h"
#import "DEXPokemon.h"
#import "DEXType.h"

static DEXMasterDex *sharedMasterDex;

@implementation DEXMasterDex

- (id)init
{
	if (self = [super init]) {
		allPokemon = [[NSMutableDictionary alloc] init];
		[self loadPokemonFromCSV];
	}
	return self;
}

- (void)dealloc
{
	 
}

- (void)loadPokemonFromCSV
{
	NSArray *babyDexNumbers = [NSArray arrayWithObjects:@"172", @"173", @"174", @"175", @"236", @"238", @"239", @"240", @"298", @"360", @"406", @"433", @"438", @"439", @"440", @"446", @"447", @"458", nil];
	
	// import pokemon data from string file
	NSString *path = [[NSBundle mainBundle] pathForResource:@"pokemon_data" ofType:@"csv"];
	NSError *error = nil;
	NSString *pokemonData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (error) {
		[NSException exceptionWithName:@"NoPokemonData" reason:@"Could not load pokemon data from the csv file." userInfo:nil];
	}
	NSArray *pokemonDataArray = [pokemonData componentsSeparatedByString:@"\n"];
	for (NSString *row in pokemonDataArray) {
		if ([row length] > 0) {
			NSArray *columns = [row componentsSeparatedByString:@","];
			DEXPokemon *newPokemon = [[DEXPokemon alloc] init];
			[newPokemon setNationalDexNumber:[[columns objectAtIndex:0] integerValue]];
			if ([[columns objectAtIndex:1] integerValue] > 0) [newPokemon setKantoDexNumber:[[columns objectAtIndex:1] integerValue]];
			if ([[columns objectAtIndex:2] integerValue] > 0) [newPokemon setJohtoDexNumber:[[columns objectAtIndex:2] integerValue]];
			if ([[columns objectAtIndex:3] integerValue] > 0) [newPokemon setJohtoRemakeDexNumber:[[columns objectAtIndex:3] integerValue]];
			if ([[columns objectAtIndex:4] integerValue] > 0) [newPokemon setHoennDexNumber:[[columns objectAtIndex:4] integerValue]];
			if ([[columns objectAtIndex:5] integerValue] > 0) [newPokemon setSinnohDexNumber:[[columns objectAtIndex:5] integerValue]];
			if ([[columns objectAtIndex:6] integerValue] > 0) [newPokemon setIsshuDexNumber:[[columns objectAtIndex:6] integerValue]];
			
			// SPECIAL CASE: Victini who has isshuDexNumber of 000
			if ([newPokemon nationalDexNumber] == 494) {
				[newPokemon setIsshuDexNumber:0];
			}
			
			[newPokemon setName:[columns objectAtIndex:7]];
			DEXType *typeOne = [DEXType singltonWithType:[[columns objectAtIndex:8] capitalizedString]];
			[newPokemon setTypeOne:typeOne];
			// not all pokemon will have a second type
			if (![[[columns objectAtIndex:9] capitalizedString] isEqualToString:@"-"]) {
				DEXType *typeTwo = [DEXType singltonWithType:[[columns objectAtIndex:9] capitalizedString]];
				[newPokemon setTypeTwo:typeTwo];
			}
			[newPokemon setHitPoints:[[columns objectAtIndex:10] integerValue]];
			[newPokemon setAttack:[[columns objectAtIndex:11] integerValue]];
			[newPokemon setDefense:[[columns objectAtIndex:12] integerValue]];
			[newPokemon setSpecialAttack:[[columns objectAtIndex:13] integerValue]];
			[newPokemon setSpecialDefense:[[columns objectAtIndex:14] integerValue]];
			[newPokemon setSpeed:[[columns objectAtIndex:15] integerValue]];
			
			if ([babyDexNumbers containsObject:[NSString stringWithFormat:@"%i", [newPokemon nationalDexNumber]]]) {
				[newPokemon setIsBaby:YES];
			}
			
			//NSLog(@"New Pokemon: %@", newPokemon);
			[allPokemon setObject:newPokemon forKey:[NSNumber numberWithInt:[newPokemon nationalDexNumber]]];
            newPokemon = nil;
			// National,Kanto,Gold/Silver/Crystal,HG/SS,Hoenn,Sinnoh,Name,Type One,Type Two,Hit Points,Attack,Defense,Special Attack,Special Defense,Speed
		}
	}
	NSLog(@"Pokemon loaded: %i", [allPokemon count]);
	[self loadPokemonEvolutionInfoFromCSV];
	[self loadPokemonEvolutionDescriptionsFromCSV];
	[self loadPokemonGen5Names];
}

- (void)loadPokemonEvolutionInfoFromCSV
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"pokemon_evolution_chains" ofType:@"csv"];
	NSError *error = nil;
	NSString *pokemonData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (error) {
		[NSException exceptionWithName:@"NoPokemonData" reason:@"Could not load pokemon evolution chain data from the csv file." userInfo:nil];
	}
	NSArray *pokemonDataArray = [pokemonData componentsSeparatedByString:@"\n"];
	for (NSString *row in pokemonDataArray) {
		if ([row length] > 0) {
			NSArray *columns = [row componentsSeparatedByString:@","];
			DEXPokemon *p = [self pokemonWithNationalDexNumber:[[columns objectAtIndex:0] integerValue]];
			if (p) {
				[p setEvolutionChainID:[[columns objectAtIndex:1] integerValue]];
				//NSLog(@"Giving %@ an evolution chain id of %i", [p name], [p evolutionChainID]); 
			}
			
		}
	}
}

- (void)loadPokemonGen5Names
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"rumored_name_list" ofType:@"txt"];
	NSError *error = nil;
	NSString *pokemonData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (error) {
		[NSException exceptionWithName:@"NoPokemonData" reason:@"Could not load pokemon gen 5 names from the txt file." userInfo:nil];
	}
	NSArray *pokemonDataArray = [pokemonData componentsSeparatedByString:@"\n"];
	for (NSString *row in pokemonDataArray) {
		if ([row length] > 0) {
			NSArray *columns = [row componentsSeparatedByString:@" "];
			DEXPokemon *p = [self pokemonWithNationalDexNumber:[[columns objectAtIndex:0] integerValue]];
			if (p) {
				[p setName:[columns objectAtIndex:1]];
				//NSLog(@"Giving %d an name of %@", [p nationalDexNumber], [p name]); 
			}
			
		}
	}
}

- (void)loadPokemonEvolutionDescriptionsFromCSV
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"pokemon_evolution_descriptions" ofType:@"csv"];
	NSError *error = nil;
	NSString *pokemonData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (error) {
		[NSException exceptionWithName:@"NoPokemonData" reason:@"Could not load pokemon evolution description data from the csv file." userInfo:nil];
	}
	NSArray *pokemonDataArray = [pokemonData componentsSeparatedByString:@"\n"];
	for (NSString *row in pokemonDataArray) {
		if ([row length] > 0) {
			NSArray *columns = [row componentsSeparatedByString:@","];
			DEXPokemon *p = [self pokemonWithNationalDexNumber:[[columns objectAtIndex:0] integerValue]];
			if (p) {
				[p setEvolutionDescription:[columns objectAtIndex:1]];
				//NSLog(@"Giving %@ an evolution description of %@", [p name], [p evolutionDescription]); 
			}
			
		}
	}
}

- (NSArray *)pokemonWhoHaveNonNegativeDexNumberFor:(NSString *)dexName
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (DEXPokemon *pokemon in [allPokemon allValues]) {
		if ([[pokemon valueForKey:dexName] integerValue] >= 0) {
			[result addObject:pokemon];
		}
	}
	return result;
}

- (NSArray *)nationalDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"nationalDexNumber"];
}

- (NSArray *)kantoDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"kantoDexNumber"];
}

- (NSArray *)johtoDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"johtoDexNumber"];
}

- (NSArray *)johtoRemakeDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"johtoRemakeDexNumber"];
}

- (NSArray *)hoennDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"hoennDexNumber"];
}

- (NSArray *)sinnohDex
{
	// Special case D/P only have 1-151 dex, the extras were only added in Platinum.
	NSArray *platinumDex = [self pokemonWhoHaveNonNegativeDexNumberFor:@"sinnohDexNumber"];
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (DEXPokemon *pokemon in platinumDex) {
		if ([pokemon sinnohDexNumber] <= 151) {
			[result addObject:pokemon];
		}
	}
	return result;
}

- (NSArray *)sinnohExtendedDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"sinnohDexNumber"];
}

- (NSArray *)isshuDex
{
	return [self pokemonWhoHaveNonNegativeDexNumberFor:@"isshuDexNumber"];
}

- (DEXPokemon *)pokemonWithNationalDexNumber:(NSInteger)dexNumber
{
	return [allPokemon objectForKey:[NSNumber numberWithInteger:dexNumber]];
}

#pragma mark -
#pragma mark Singleton Stuff

+ (DEXMasterDex *)sharedMasterDex
{
	if (!sharedMasterDex) {
		sharedMasterDex = [[DEXMasterDex alloc] init];
	}
	return sharedMasterDex;
}

+ (id)allocWithZone:(NSZone *)zone
{
	if (!sharedMasterDex) {
		sharedMasterDex = [super allocWithZone:zone];
		return sharedMasterDex;
	} else {
		return nil;
	}
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

@end
