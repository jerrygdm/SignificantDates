//
//  SDAFParseAPIClient.m
//  SignificantDates
//
//  Created by Gianmaria Dal Maistro on 08/06/13.
//
//

#import "SDAFParseAPIClient.h"

#import "AFJSONRequestOperation.h"

static NSString * const kSDFParseAPIBaseURLString = @"https://api.parse.com/1/";
static NSString * const kSDFParseAPIApplicationId = @"PKsoHDckn4RZWRqxTPV9eM1QKSXVo5udz9Th07O6";
static NSString * const kSDFParseAPIKey = @"nmRUnLDwpshqnGSsvuM1leHW1EIAtKuZXkj6SEPe";

@implementation SDAFParseAPIClient

+ (SDAFParseAPIClient *)sharedClient
{
    static SDAFParseAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[SDAFParseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kSDFParseAPIBaseURLString]];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"X-Parse-Application-Id" value:kSDFParseAPIApplicationId];
        [self setDefaultHeader:@"X-Parse-REST-API-Key" value:kSDFParseAPIKey];
    }
    
    return self;
    
}

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters];
    return request;
}

- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate
{
    NSMutableURLRequest *request = nil;
    NSDictionary *parameters = nil;
    if (updatedDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        NSString *jsonString = [NSString
                                stringWithFormat:@"{\"updatedAt\":{\"$gte\":{\"__type\":\"Date\",\"iso\":\"%@\"}}}",
                                [dateFormatter stringFromDate:updatedDate]];
        
        parameters = [NSDictionary dictionaryWithObject:jsonString forKey:@"where"];
    }
    
    request = [self GETRequestForClass:className parameters:parameters];
    return request;
}

- (NSMutableURLRequest *)POSTRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"POST" path:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters];
    return request;
}

- (NSMutableURLRequest *)DELETERequestForClass:(NSString *)className forObjectWithId:(NSString *)objectId
{
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"DELETE" path:[NSString stringWithFormat:@"classes/%@/%@", className, objectId] parameters:nil];
    return request;
}

@end
