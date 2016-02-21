//
//  GBLocationSerVice.h
//  Ganbare
//
//  Created by Phung Long on 9/23/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define GBLocationChangedNotification			@"GBLocationChangedNotification"
#define GBLocationReceiveDidFailNotification	@"GBLocationReceiveDidFailNotification"

@interface GBLocationSerVice : NSObject<CLLocationManagerDelegate>

@property(nonatomic,retain) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationAccuracy accuracy;
@property (nonatomic, readonly) CLLocationCoordinate2D	coordinates;

+ (id)sharedLocation;
- (id)init;
- (void)stopUpdatingLocation;
- (void) updateLocation;
- (NSString *)latitudeStringValue;
- (NSString *)longitudeStringValue;
- (double)latitude;
- (double)longitude;
- (void)updateHeading;
- (void)stopUpdatingHeading;

@end
