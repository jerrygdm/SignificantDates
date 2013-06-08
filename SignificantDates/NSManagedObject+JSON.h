//
//  NSManagedObject+JSON.h
//  SignificantDates
//
//  Created by Gianmaria Dal Maistro on 08/06/13.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (JSON)

- (NSDictionary *)JSONToCreateObjectOnServer;
- (NSString *)dateStringForAPIUsingDate:(NSDate *)date;

@end
