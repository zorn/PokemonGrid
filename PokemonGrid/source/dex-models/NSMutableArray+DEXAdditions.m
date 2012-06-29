#import "NSMutableArray+DEXAdditions.h"
#import "DEXType.h"

@implementation NSMutableArray (DEXAdditions)

// NEW METHOD TO REPLACE PREVIOUS BLOCK USAGE FOR ATTACK TABLE:
//index = [result indexOfObjectPassingTest:
//		 ^(id obj, NSUInteger idx, BOOL *stop) {
//			 return [[[obj objectForKey:@"type"] name] isEqualToString:[type name]];
//		 }];
// USED ON A MUTABLE ARRAY CONTAINING MUTABLE DICTIONARIES
- (NSInteger)indexOfMatchingType:(DEXType *)theType
{
	for (NSMutableDictionary *d in self) {
		if ([[[d objectForKey:@"type"] name] isEqualToString:[theType name]]) {
			return [self indexOfObject:d];
		}
	}
	return NSNotFound;
}

@end
