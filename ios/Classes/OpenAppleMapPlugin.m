#import "FlutterPlugin.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation FlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"open_apple_map"
            binaryMessenger:[registrar messenger]];
  FlutterPlugin* instance = [[FlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if([@"openMap" isEqualToString:call.method]) {
    [self openMap:call result: result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}


- (void)openMap:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* argsMap = call.arguments;
    NSString* lat = argsMap[@"lat"];
    NSString* log = argsMap[@"log"];

    double latitude = [lat doubleValue];
    double longitude = [log doubleValue];

    CLLocationCoordinate2D customLoc2D = CLLocationCoordinate2DMake(latitude, longitude);
    MKPlacemark * placeMark = [[MKPlacemark alloc] initWithCoordinate:customLoc2D addressDictionary:nil];

    MKMapItem * currentItem = [MKMapItem mapItemForCurrentLocation];
    MKMapItem * item = [[MKMapItem alloc]initWithPlacemark:placeMark];

    NSDictionary * dict = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsMapTypeKey:
    @(MKMapTypeHybrid),MKLaunchOptionsShowsTrafficKey:@(YES)};

    [MKMapItem openMapsWithItems:@[currentItem,item] launchOptions:dict];
}

@end
