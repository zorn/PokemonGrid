//
//  DEXPokemon.m
//  Dex
//
//  Created by Michael Zornek on 7/13/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import "DEXMasterDex.h"
#import "DEXPokemon.h"
#import "DEXType.h"
#import "NSMutableArray+DEXAdditions.h"

@implementation DEXPokemon

- (id)init
{
	if (self = [super init]) {
		nationalDexNumber = -1;
		kantoDexNumber = -1;
		johtoDexNumber = -1;
		johtoRemakeDexNumber = -1;
		hoennDexNumber = -1;
		sinnohDexNumber = -1;
		isshuDexNumber = -1;
		
		evolutionChainID = 0;
		
		isBaby = NO;
	}
	return self;
}

@synthesize name;
@synthesize typeOne;
@synthesize typeTwo;

@synthesize nationalDexNumber;
@synthesize kantoDexNumber;
@synthesize johtoDexNumber;
@synthesize johtoRemakeDexNumber;
@synthesize hoennDexNumber;
@synthesize sinnohDexNumber;
@synthesize isshuDexNumber;

@synthesize evolutionChainID;
@synthesize evolutionDescription;

@synthesize hitPoints;
@synthesize attack;
@synthesize defense;
@synthesize specialAttack;
@synthesize specialDefense;
@synthesize speed;

@synthesize isBaby;

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ %@ (%i)", [super description], [self name], [self nationalDexNumber]];
}

- (UIImage *)icon
{
	return [UIImage imageNamed:[NSString stringWithFormat:@"%i-icon.png", [self nationalDexNumber]]];
}

- (UIImage *)sprite
{
	return [UIImage imageNamed:[NSString stringWithFormat:@"%i-normal.png", [self nationalDexNumber]]];
}

- (NSDictionary *)defensiveTable
{
	if (!_defensiveTable) {
		_defensiveTable = [[NSMutableDictionary alloc] init];
		
		DEXType *type;
		// Add a mutable dictionary entry for each type
		NSMutableDictionary *typeInfo = nil;
		for (type in [DEXType allTypes]) {
			typeInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
						[NSDecimalNumber decimalNumberWithString:@"1.0"], @"rate", 
						type, @"type", 
						nil];
			[_defensiveTable setObject:typeInfo forKey:[type name]];
		}
		
		// for each typeOne def weakness, mutiply the rate by 2
		for (type in [[self typeOne] defensivelyWeakTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[[typeInfo objectForKey:@"rate"] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
		}
		
		// for each typeTwo def weakness, mutiply the rate by 2
		for (type in [[self typeTwo] defensivelyWeakTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[[typeInfo objectForKey:@"rate"] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
		}
		
		// for each typeOne def strength, divide the rate by 2
		for (type in [[self typeOne] defensivelyStrongTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[[typeInfo objectForKey:@"rate"] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
		}
		
		// for each typeTwo def strength, divide the rate by 2
		for (type in [[self typeTwo] defensivelyStrongTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[[typeInfo objectForKey:@"rate"] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
		}
		
		// for each typeOne def no effect, set to zero
		for (type in [[self typeOne] defensivelyNoEffectTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[NSDecimalNumber zero] forKey:@"rate"];
		}
		
		// for each typeTwo def no effect, set to zero
		for (type in [[self typeTwo] defensivelyNoEffectTo]) {		
			typeInfo = [_defensiveTable objectForKey:[type name]];
			[typeInfo setObject:[NSDecimalNumber zero] forKey:@"rate"];
		}
	}
	return _defensiveTable;
}

- (NSArray *)defensivelyWeakToRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [[self defensiveTable] allValues]) {
		// - (NSComparisonResult)compare:(NSNumber *)decimalNumber
		// NSOrderedAscending if the value of decimalNumber is greater than the receiver; 
		// NSOrderedSame if they’re equal;
		// NSOrderedDescending if the value of decimalNumber is less than the receiver.
		if ([[NSDecimalNumber one] compare:[d objectForKey:@"rate"]] == NSOrderedAscending) {
			[result addObject:d];
		}
	}
	return result;
}

- (NSArray *)defensivelyStrongToRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [[self defensiveTable] allValues]) {
		// - (NSComparisonResult)compare:(NSNumber *)decimalNumber
		// NSOrderedAscending if the value of decimalNumber is greater than the receiver; 
		// NSOrderedSame if they’re equal;
		// NSOrderedDescending if the value of decimalNumber is less than the receiver.
		if ([[NSDecimalNumber one] compare:[d objectForKey:@"rate"]] == NSOrderedDescending &&
			[[NSDecimalNumber zero] compare:[d objectForKey:@"rate"]] != NSOrderedSame) {
			[result addObject:d];
		}
	}
	return result;
}

- (NSArray *)defensivelyNoEffectToRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [[self defensiveTable] allValues]) {
		// - (NSComparisonResult)compare:(NSNumber *)decimalNumber
		// NSOrderedAscending if the value of decimalNumber is greater than the receiver; 
		// NSOrderedSame if they’re equal;
		// NSOrderedDescending if the value of decimalNumber is less than the receiver.
		if ([[NSDecimalNumber zero] compare:[d objectForKey:@"rate"]] == NSOrderedSame) {
			[result addObject:d];
		}
	}
	return result;
}

- (NSString *)urlStringForMarrilandGen5
{
//	NSString *n = [self name];
//	if (self.nationalDexNumber == 29) n = @"nidoranf";
//	if (self.nationalDexNumber == 32) n = @"nidoranm";
	return [NSString stringWithFormat:@"http://pokemon.marriland.com/black_white/pokedex/%i/", self.nationalDexNumber];
}

- (NSString *)urlStringForMarrilandGen4
{
//	NSString *n = [self name];
//	if (self.nationalDexNumber == 29) n = @"nidoranf";
//	if (self.nationalDexNumber == 32) n = @"nidoranm";
	return [NSString stringWithFormat:@"http://pokemon.marriland.com/hgss/pokedex/%i/", self.nationalDexNumber];
}

- (NSArray *)evolutionFamily
{
	// returns an ordered array containing all the members of this pokemon's evolution family
	// will return an array of 1 for pokemon that do not evolve
	if (!_evolutionFamily) {
		_evolutionFamily = [[NSMutableArray alloc] init];
		for (DEXPokemon *p in [[DEXMasterDex sharedMasterDex] nationalDex]) {
			if ([p evolutionChainID] == [self evolutionChainID]) {
				[_evolutionFamily addObject:p];
			}
		}
		
		// sort
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nationalDexNumber" ascending:YES];
		NSSortDescriptor *babySortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"isBaby" ascending:NO];
		[_evolutionFamily sortUsingDescriptors:[NSArray arrayWithObjects:babySortDescriptor,sortDescriptor, nil]];
	}
	return _evolutionFamily;
}

@end
