#import "OpenAppleMapPlugin.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation OpenAppleMapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"open_apple_map"
            binaryMessenger:[registrar messenger]];
  OpenAppleMapPlugin* instance = [[OpenAppleMapPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"openMap" isEqualToString:call.method]) {
    [self openMap:call result: result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)openMap:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* argsMap = call.arguments;
    NSString* lat = argsMap[@"lat"];
    NSString* log = argsMap[@"log"];
    NSString* addressName = argsMap[@"addressName"];

    double latitude = [lat doubleValue];
    double longitude = [log doubleValue];

    CLLocationCoordinate2D customLoc2D = CLLocationCoordinate2DMake(latitude, longitude);
    MKPlacemark * placeMark = [[MKPlacemark alloc] initWithCoordinate:customLoc2D addressDictionary:nil];

    MKMapItem * currentItem = [MKMapItem mapItemForCurrentLocation];
//    MKMapItem * item = [[MKMapItem alloc]initWithPlacemark:placeMark];
    MKMapItem *toLocationItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:customLoc2D addressDictionary:@{}]];
    toLocationItem.name = addressName;
    
    [MKMapItem openMapsWithItems:@[currentItem, toLocationItem]
                      launchOptions:@{MKLaunchOptionsDirectionsModeKey:
                       MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];

//    NSDictionary * dict = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsMapTypeKey:
//    @(MKMapTypeStandard),MKLaunchOptionsShowsTrafficKey:@(YES)};
//
//    [MKMapItem openMapsWithItems:@[currentItem,item] launchOptions:dict];
}

@end
