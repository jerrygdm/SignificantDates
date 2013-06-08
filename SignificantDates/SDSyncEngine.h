//
//  SDSyncEngine.h
//  SignificantDates
//
//  Created by Gianmaria Dal Maistro on 08/06/13.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    SDObjectSynced = 0,
    SDObjectCreated,
    SDObjectDeleted,
} SDObjectSyncStatus;

@interface SDSyncEngine : NSObject

@property (atomic, readonly) BOOL syncInProgress;

+ (SDSyncEngine *)sharedEngine;

- (void)registerNSManagedObjectClassToSync:(Class)aClass;
- (void)startSync;

- (NSString *)dateStringForAPIUsingDate:(NSDate *)date;

@end
