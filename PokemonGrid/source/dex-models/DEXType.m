//
//  DEXType.m
//  Dex
//
//  Created by Michael Zornek on 7/13/10.
//  Copyright 2010 Clickable Bliss. All rights reserved.
//

#import "DEXType.h"
#import "NSMutableArray+DEXAdditions.h"


@implementation DEXType

static NSMutableDictionary *standardTypes;
static NSArray *_DEXTypeAllowedTypes = nil;

- (id)init
{
	if (self = [super init]) {
		
	}
	return self;
}

- (void)dealloc
{
	 
}

@synthesize name;

+ (NSArray *)allTypes
{
	return [NSArray arrayWithObjects:[DEXType normalType],
			[DEXType fireType],
			[DEXType waterType],
			[DEXType electricType],
			[DEXType grassType],
			[DEXType iceType],
			[DEXType fightingType],
			[DEXType poisonType],
			[DEXType groundType],
			[DEXType flyingType],
			[DEXType psychicType],
			[DEXType bugType],
			[DEXType rockType],
			[DEXType ghostType],
			[DEXType dragonType],
			[DEXType darkType],
			[DEXType steelType],
			nil];
}

+ (DEXType *)normalType
{
	return [DEXType singltonWithType:@"Normal"];
}

+ (DEXType *)fireType
{
	return [DEXType singltonWithType:@"Fire"];
}

+ (DEXType *)waterType
{
	return [DEXType singltonWithType:@"Water"];
}

+ (DEXType *)electricType
{
	return [DEXType singltonWithType:@"Electric"];
}

+ (DEXType *)grassType
{
	return [DEXType singltonWithType:@"Grass"];
}

+ (DEXType *)iceType
{
	return [DEXType singltonWithType:@"Ice"];
}

+ (DEXType *)fightingType
{
	return [DEXType singltonWithType:@"Fighting"];
}

+ (DEXType *)poisonType
{
	return [DEXType singltonWithType:@"Poison"];
}

+ (DEXType *)groundType
{
	return [DEXType singltonWithType:@"Ground"];
}

+ (DEXType *)flyingType
{
	return [DEXType singltonWithType:@"Flying"];
}

+ (DEXType *)psychicType
{
	return [DEXType singltonWithType:@"Psychic"];
}

+ (DEXType *)bugType
{
	return [DEXType singltonWithType:@"Bug"];
}

+ (DEXType *)rockType
{
	return [DEXType singltonWithType:@"Rock"];
}

+ (DEXType *)ghostType
{
	return [DEXType singltonWithType:@"Ghost"];
}

+ (DEXType *)dragonType
{
	return [DEXType singltonWithType:@"Dragon"];
}


+ (DEXType *)darkType
{
	return [DEXType singltonWithType:@"Dark"];
}


+ (DEXType *)steelType
{
	return [DEXType singltonWithType:@"Steel"];
}


+ (DEXType *)singltonWithType:(NSString *)typeName
{
	if (!_DEXTypeAllowedTypes) {
		_DEXTypeAllowedTypes = [NSArray arrayWithObjects:@"Normal",@"Fire",@"Water",@"Electric",@"Grass",@"Ice",@"Fighting",@"Poison",@"Ground",@"Flying",@"Psychic",@"Bug",@"Rock",@"Ghost",@"Dragon",@"Dark",@"Steel", nil];
	}
	
	if ([_DEXTypeAllowedTypes containsObject:typeName]) {
		// Make the top level collection when needed
		if (!standardTypes) {
			standardTypes = [[NSMutableDictionary alloc] init];
		}
		// Only make a new object when it is not in the collection
		DEXType *foundType = [standardTypes objectForKey:typeName]; 
		if (foundType == nil) {
			//NSLog(@"Making new type with name: %@", typeName);
			DEXType *newType = [[DEXType alloc] init];
			[newType setName:typeName];
			[standardTypes setObject:newType forKey:typeName];
			return newType;
		} else {
			return foundType;
		}
	}
	NSLog(@"Can not create a type of %@", typeName);
	return nil;
}

- (NSArray *)movesAreSuperEffectiveAgainst
{
	if ([self.name isEqualToString:@"Normal"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Fire"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType iceType], [DEXType bugType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Water"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType groundType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Electric"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType flyingType], nil];
	} else if ([self.name isEqualToString:@"Grass"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType groundType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Ice"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType groundType], [DEXType flyingType], [DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return [NSArray arrayWithObjects:[DEXType normalType], [DEXType iceType], [DEXType rockType], [DEXType darkType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Poison"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], nil];
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType electricType], [DEXType poisonType], [DEXType rockType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType fightingType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], [DEXType poisonType], nil];
	} else if ([self.name isEqualToString:@"Bug"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType psychicType], [DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Rock"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType iceType], [DEXType flyingType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType psychicType], [DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return [NSArray arrayWithObjects:[DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Dark"]) {
		return [NSArray arrayWithObjects:[DEXType psychicType], [DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Steel"]) {
		return [NSArray arrayWithObjects:[DEXType iceType], [DEXType rockType], nil];
	}
	return nil;
}

- (NSArray *)movesAreNotVeryEffectiveAgainst
{
	if ([self.name isEqualToString:@"Normal"]) {
		return [NSArray arrayWithObjects:[DEXType rockType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Fire"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType waterType], [DEXType rockType], [DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Water"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType grassType], [DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Electric"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], [DEXType grassType], [DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Grass"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType grassType], [DEXType poisonType], [DEXType flyingType], [DEXType bugType], [DEXType dragonType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Ice"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType waterType], [DEXType iceType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return [NSArray arrayWithObjects:[DEXType poisonType], [DEXType flyingType], [DEXType psychicType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Poison"]) {
		return [NSArray arrayWithObjects:[DEXType poisonType], [DEXType groundType], [DEXType rockType], [DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], [DEXType rockType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return [NSArray arrayWithObjects:[DEXType psychicType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Bug"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType fightingType], [DEXType poisonType], [DEXType flyingType], [DEXType ghostType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Rock"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], [DEXType groundType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType darkType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return [NSArray arrayWithObjects:[DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Dark"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], [DEXType darkType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Steel"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType waterType], [DEXType electricType], [DEXType steelType], nil];
	}
	return nil;
}

- (NSArray *)movesHaveNoEffectiveAgainst
{
	if ([self.name isEqualToString:@"Normal"]) {
		return [NSArray arrayWithObjects:[DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Fire"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Water"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Electric"]) {
		return [NSArray arrayWithObjects:[DEXType groundType], nil];
	} else if ([self.name isEqualToString:@"Grass"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Ice"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return [NSArray arrayWithObjects:[DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Poison"]) {
		return [NSArray arrayWithObjects:[DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType flyingType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return [NSArray arrayWithObjects:[DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Bug"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Rock"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType normalType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Dark"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Steel"]) {
		return nil;
	}
	return nil;
}

- (NSArray *)defensivelyWeakTo
{
	if ([self.name isEqualToString:@"Normal"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], nil];
	} else if ([self.name isEqualToString:@"Fire"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType groundType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Water"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], [DEXType grassType], nil];
	} else if ([self.name isEqualToString:@"Electric"]) {
		return [NSArray arrayWithObjects:[DEXType groundType], nil];
	} else if ([self.name isEqualToString:@"Grass"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType iceType], [DEXType poisonType], [DEXType flyingType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Ice"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType fightingType], [DEXType rockType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return [NSArray arrayWithObjects:[DEXType flyingType], [DEXType psychicType], nil];
	} else if ([self.name isEqualToString:@"Poison"]) {
		return [NSArray arrayWithObjects:[DEXType groundType], [DEXType psychicType], nil];
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType grassType], [DEXType iceType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], [DEXType iceType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return [NSArray arrayWithObjects:[DEXType bugType], [DEXType ghostType], [DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Bug"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType flyingType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Rock"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType grassType], [DEXType fightingType], [DEXType groundType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType ghostType], [DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return [NSArray arrayWithObjects:[DEXType iceType], [DEXType dragonType], nil];
	} else if ([self.name isEqualToString:@"Dark"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Steel"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType fightingType], [DEXType groundType], nil];
	}
	return nil;
}

- (NSArray *)defensivelyStrongTo
{
	if ([self.name isEqualToString:@"Normal"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Fire"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType grassType], [DEXType iceType], [DEXType bugType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Water"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType waterType], [DEXType iceType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Electric"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], [DEXType flyingType], [DEXType steelType], nil];
	} else if ([self.name isEqualToString:@"Grass"]) {
		return [NSArray arrayWithObjects:[DEXType waterType], [DEXType electricType], [DEXType grassType], [DEXType groundType], nil];
	} else if ([self.name isEqualToString:@"Ice"]) {
		return [NSArray arrayWithObjects:[DEXType iceType], nil];
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return [NSArray arrayWithObjects:[DEXType bugType], [DEXType rockType], [DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Poison"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType fightingType], [DEXType poisonType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType poisonType], [DEXType rockType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType fightingType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return [NSArray arrayWithObjects:[DEXType fightingType], [DEXType psychicType], nil];
	} else if ([self.name isEqualToString:@"Bug"]) {
		return [NSArray arrayWithObjects:[DEXType grassType], [DEXType fightingType], [DEXType groundType], nil];
	} else if ([self.name isEqualToString:@"Rock"]) {
		return [NSArray arrayWithObjects:[DEXType normalType], [DEXType fireType], [DEXType poisonType], [DEXType flyingType], nil];
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType poisonType], [DEXType bugType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return [NSArray arrayWithObjects:[DEXType fireType], [DEXType waterType], [DEXType electricType], [DEXType grassType], nil];
	} else if ([self.name isEqualToString:@"Dark"]) {
		return [NSArray arrayWithObjects:[DEXType ghostType], [DEXType darkType], nil];
	} else if ([self.name isEqualToString:@"Steel"]) {
		return [NSArray arrayWithObjects:[DEXType normalType], [DEXType grassType], [DEXType iceType], [DEXType flyingType], [DEXType psychicType], [DEXType bugType], [DEXType rockType], [DEXType ghostType], [DEXType dragonType], [DEXType darkType], [DEXType steelType], nil];
	}
	return nil;
}

- (NSArray *)defensivelyNoEffectTo
{
	if ([self.name isEqualToString:@"Normal"]) {
		return [NSArray arrayWithObjects:[DEXType ghostType], nil];
	} else if ([self.name isEqualToString:@"Fire"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Water"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Electric"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Grass"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Ice"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Poison"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Ground"]) {
		return [NSArray arrayWithObjects:[DEXType electricType], nil];
	} else if ([self.name isEqualToString:@"Flying"]) {
		return [NSArray arrayWithObjects:[DEXType groundType], nil];
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Bug"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Rock"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return [NSArray arrayWithObjects:[DEXType normalType], [DEXType fightingType], nil];
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return nil;
	} else if ([self.name isEqualToString:@"Dark"]) {
		return [NSArray arrayWithObjects:[DEXType psychicType], nil];
	} else if ([self.name isEqualToString:@"Steel"]) {
		return [NSArray arrayWithObjects:[DEXType poisonType], nil];
	}
	return nil;
}

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (UIColor *)color
{
	if ([self.name isEqualToString:@"Normal"]) {
		return UIColorFromRGB(0xa8a878);
	} else if ([self.name isEqualToString:@"Fire"]) {
		return UIColorFromRGB(0xf08030);
	} else if ([self.name isEqualToString:@"Water"]) {
		return UIColorFromRGB(0x6890f0);
	} else if ([self.name isEqualToString:@"Electric"]) {
		return UIColorFromRGB(0xf8d030);
	} else if ([self.name isEqualToString:@"Grass"]) {
		return UIColorFromRGB(0x78c850);
	} else if ([self.name isEqualToString:@"Ice"]) {
		return UIColorFromRGB(0x98d8d8);
	} else if ([self.name isEqualToString:@"Fighting"]) {
		return UIColorFromRGB(0xc03028);
	} else if ([self.name isEqualToString:@"Poison"]) {
		return UIColorFromRGB(0xa040a0);
	} else if ([self.name isEqualToString:@"Ground"]) {
		return UIColorFromRGB(0xe0c068);
	} else if ([self.name isEqualToString:@"Flying"]) {
		return UIColorFromRGB(0xa890f0);
	} else if ([self.name isEqualToString:@"Psychic"]) {
		return UIColorFromRGB(0xf85888);
	} else if ([self.name isEqualToString:@"Bug"]) {
		return UIColorFromRGB(0xa8b820);
	} else if ([self.name isEqualToString:@"Rock"]) {
		return UIColorFromRGB(0xb8a038);
	} else if ([self.name isEqualToString:@"Ghost"]) {
		return UIColorFromRGB(0x705898);
	} else if ([self.name isEqualToString:@"Dragon"]) {
		return UIColorFromRGB(0x7038f8);
	} else if ([self.name isEqualToString:@"Dark"]) {
		return UIColorFromRGB(0x705848);
	} else if ([self.name isEqualToString:@"Steel"]) {
		return UIColorFromRGB(0xb8b8d0);
	} else {
		return nil;
	}
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ %@", [self name], [super description]];
}

- (NSArray *)attackTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	DEXType *type;
	NSUInteger index;
	// Add a mutable dictionary entry for each type
	for (type in [DEXType allTypes]) {
		[result addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
						   [NSDecimalNumber decimalNumberWithString:@"1.0"], @"rate", 
						   type, @"type", 
						   nil]];
	}
	
	for (type in [self movesAreSuperEffectiveAgainst]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[[d objectForKey:@"rate"] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
	}
	
	for (type in [self movesAreNotVeryEffectiveAgainst]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[[d objectForKey:@"rate"] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
	}
	
	for (type in [self movesHaveNoEffectiveAgainst]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[NSDecimalNumber zero] forKey:@"rate"];
	}
	
	return [NSArray arrayWithArray:result];
}

- (NSArray *)movesAreSuperEffectiveAgainstRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [self attackTable]) {
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

- (NSArray *)movesAreNotVeryEffectiveAgainstRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [self attackTable]) {
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

- (NSArray *)movesHaveNoEffectiveAgainstRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [self attackTable]) {
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

- (NSArray *)defenseTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	DEXType *type;
	NSUInteger index;
	// Add a mutable dictionary entry for each type
	for (type in [DEXType allTypes]) {
		[result addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
						   [NSDecimalNumber decimalNumberWithString:@"1.0"], @"rate", 
						   type, @"type", 
						   nil]];
	}
	
	for (type in [self defensivelyWeakTo]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[[d objectForKey:@"rate"] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
	}
	
	for (type in [self defensivelyStrongTo]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[[d objectForKey:@"rate"] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] forKey:@"rate"];
	}
	
	for (type in [self defensivelyNoEffectTo]) {		
		index = [result indexOfMatchingType:type];
		NSMutableDictionary *d = [result objectAtIndex:index];
		[d setObject:[NSDecimalNumber zero] forKey:@"rate"];
	}
	
	return [NSArray arrayWithArray:result];
}

- (NSArray *)defensivelyWeakToRateTable
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSMutableDictionary *d in [self defenseTable]) {
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
	for (NSMutableDictionary *d in [self defenseTable]) {
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
	for (NSMutableDictionary *d in [self defenseTable]) {
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

@end
