#import <UIKit/UIKit.h>

@class DEXType;

@interface NSMutableArray (DEXAdditions)

- (NSInteger)indexOfMatchingType:(DEXType *)theType;

@end
