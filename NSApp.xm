#import <UIKit/UIKit.h>
#import <substrate.h>
#include <stdio.h>
#include <stdlib.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#include <sys/sysctl.h>
#import <notify.h>

#define PLIST_PATH_Settings "/var/mobile/Library/Preferences/co.azozzalfiras.nsapp.plist"


static BOOL SaveMedia;



static void NSAppSettingsChanage(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	@autoreleasepool {
		NSDictionary *NSAppSettings = [[[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:@{} copy];

		SaveMedia = (BOOL)([NSAppSettings[@"SaveMedia"]?:@YES boolValue]);

	}
}



%hook hookNSApp
-(void)VoidNSAppA{
if(SaveMedia){
	// do something
return ;
} else {
	// if disable switch
return %orig;
}
}
%end


%hook AzozzALFiras
-(bool)BOOLNSApp{
if(SaveMedia){
return YES;
} else {
return %orig;
}
return %orig;
}
%end


%ctor
{
@autoreleasepool {
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, NSAppSettingsChanage, CFSTR("co.azozzalfiras.nsapp/SettingsChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
NSAppSettingsChanage(NULL, NULL, NULL, NULL, NULL);
}
}
