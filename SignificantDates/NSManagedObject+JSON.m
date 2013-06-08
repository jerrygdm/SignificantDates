//
//  NSManagedObject+JSON.m
//  SignificantDates
//
//  Created by Gianmaria Dal Maistro on 08/06/13.
//
//

#import "NSManagedObject+JSON.h"

@implementation NSManagedObject (JSON)

- (NSDictionary *)JSONToCreateObjectOnServer
{
    @throw [NSException exceptionWithName:@"JSONStringToCreateObjectOnServer Not Overridden" reason:@"Must override JSONStringToCreateObjectOnServer on NSManagedObject class" userInfo:nil];
    return nil;
}

@end
