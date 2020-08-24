#import <notify.h>
#import <Social/Social.h>
#import <prefs.h>
#import <objc/runtime.h>
#import <spawn.h>


#define AZFBUNDLE    [NSString stringWithString:[[NSBundle mainBundle] bundleIdentifier]]
#define azfLibrary_Bundleid(bundleIdString) [AZFBUNDLE isEqualToString:bundleIdString]
NSString *InstagramIcon = @"/Library/PreferenceBundles/iResters.bundle/instagram.png";
NSString *BusuuIcon    = @"/Library/PreferenceBundles/iResters.bundle/Busuu@2x.png";




@interface UIColor ()
+ (id)labelColor;
@end

// thanks for julioverne
// this file setting by julioverne;
// https://github.com/julioverne

#define PLIST_PATH_Settings "/var/mobile/Library/Preferences/co.azozzalfiras.irester.plist"

@interface NSAppListController : PSListController {
UILabel* _label;
UILabel* underLabel;
}
@end
@interface InstagramViewController : PSListController {
UILabel* _label;
UILabel* underLabel;
}
@end
@interface BusuuViewController : PSListController {
UILabel* _label;
UILabel* underLabel;
}
@end


@implementation NSAppListController


- (id)specifiers {
if (!_specifiers) {
NSMutableArray* specifiers = [NSMutableArray array];
PSSpecifier* spec;


spec = [PSSpecifier preferenceSpecifierNamed:@"Instagram"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSLinkCell
edit:Nil];

// this get from info.plist
/*
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fb-messenger-share-api://</string>
</array>

*/
if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb-messenger-share-api://"]]) {

// if app installed will show settings app
spec->action = @selector(Instagram);

} else {

// if app not install will open URL for install
spec->action = @selector(InstagramInstall);

}
[spec setProperty:[NSNumber numberWithBool:TRUE] forKey:@"hasIcon"];
[spec setProperty:[UIImage imageWithContentsOfFile:InstagramIcon] forKey:@"iconImage"];
[specifiers addObject:spec];

spec = [PSSpecifier preferenceSpecifierNamed:@"Busuu"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSLinkCell
edit:Nil];
if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Busuu://"]]) {
spec->action = @selector(Busuu);
} else {
spec->action = @selector(BusuuInstall);
}
[spec setProperty:[NSNumber numberWithBool:TRUE] forKey:@"hasIcon"];
[spec setProperty:[UIImage imageWithContentsOfFile:BusuuIcon] forKey:@"iconImage"];
[specifiers addObject:spec];

spec = [PSSpecifier emptyGroupSpecifier];
[specifiers addObject:spec];

[specifiers addObject:spec];
spec = [PSSpecifier emptyGroupSpecifier];
[spec setProperty:[NSString stringWithFormat:@"%@ © 2020 Azozz ALFiras ", self.title] forKey:@"footerText"];
[specifiers addObject:spec];
_specifiers = [specifiers copy];
}
return _specifiers;
}



-(void)Instagram{

InstagramViewController *Instagram = [[InstagramViewController alloc] init];
[self.navigationController pushViewController:Instagram animated:YES];

}
-(void)InstagramInstall{

UIApplication *app = [UIApplication sharedApplication];
[app openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/instagram/id389801252"]];
}


-(void)Busuu{

BusuuViewController *Busuu = [[BusuuViewController alloc] init];
[self.navigationController pushViewController:Busuu animated:YES];

}
-(void)BusuuInstall{

UIApplication *app = [UIApplication sharedApplication];
[app openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/busuu-fast-language-learning/id379968583"]];
}




- (void)twitter{
UIApplication *app = [UIApplication sharedApplication];
if ([app canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=AzozzALFiras"]]) {
[app openURL:[NSURL URLWithString:@"twitter://user?screen_name=AzozzALFiras"]];
} else if ([app canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/AzozzALFiras"]]) {
[app openURL:[NSURL URLWithString:@"tweetbot:///user_profile/AzozzALFiras"]];
} else {
[app openURL:[NSURL URLWithString:@"https://mobile.twitter.com/AzozzALFiras"]];
}
}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier
{
@autoreleasepool {
NSMutableDictionary *CydiaEnablePrefsCheck = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:[NSMutableDictionary dictionary];
[CydiaEnablePrefsCheck setObject:value forKey:[specifier identifier]];
[CydiaEnablePrefsCheck writeToFile:@PLIST_PATH_Settings atomically:YES];
notify_post("co.azozzalfiras.nsapp/Settings");


}
}
- (id)readPreferenceValue:(PSSpecifier*)specifier
{
@autoreleasepool {
NSDictionary *CydiaEnablePrefsCheck = [[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings];
return CydiaEnablePrefsCheck[[specifier identifier]]?:[[specifier properties] objectForKey:@"default"];
}
}


- (void) loadView
{
[super loadView];
self.title = @"NSApp";
[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:0.09 green:0.99 blue:0.99 alpha:1.0];

}
- (void)increaseAlpha
{
[UIView animateWithDuration:0.5 animations:^{
_label.alpha = 1;
}completion:^(BOOL finished) {
[UIView animateWithDuration:0.5 animations:^{
underLabel.alpha = 1;
}completion:nil];
}];
}
@end

@implementation InstagramViewController

- (id)specifiers {
if (!_specifiers) {

NSMutableArray* specifiers = [NSMutableArray array];
PSSpecifier* spec;

spec = [PSSpecifier preferenceSpecifierNamed:@"Disable Ads"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSSwitchCell
edit:Nil];
[spec setProperty:@"DisableAds" forKey:@"key"];
[spec setProperty:@NO forKey:@"default"];
[spec setProperty:@YES forKey:@"ExitIG"];
[specifiers addObject:spec];
spec = [PSSpecifier preferenceSpecifierNamed:@"Save Media"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSSwitchCell
edit:Nil];
[spec setProperty:@"SaveMedia" forKey:@"key"];
[spec setProperty:@NO forKey:@"default"];
[spec setProperty:@YES forKey:@"ExitIG"];
[specifiers addObject:spec];

spec = [PSSpecifier emptyGroupSpecifier];
[specifiers addObject:spec];

[specifiers addObject:spec];
spec = [PSSpecifier emptyGroupSpecifier];
[spec setProperty:[NSString stringWithFormat:@"%@ © 2020 Azozz ALFiras ", self.title] forKey:@"footerText"];
[specifiers addObject:spec];
_specifiers = [specifiers copy];
}
return _specifiers;
}



- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier{
@autoreleasepool {
NSMutableDictionary *CydiaEnablePrefsCheck = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:[NSMutableDictionary dictionary];
[CydiaEnablePrefsCheck setObject:value forKey:[specifier identifier]];
[CydiaEnablePrefsCheck writeToFile:@PLIST_PATH_Settings atomically:YES];
notify_post("co.azozzalfiras.irester/Settings");

if ([[specifier properties] objectForKey:@"ExitIG"]) {
[self ExitInstagram];
}

}
}

-(void)ExitInstagram{
  pid_t pid;
  const char* args[] = {"killall", "Instagram", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}
- (id)readPreferenceValue:(PSSpecifier*)specifier
{
@autoreleasepool {
NSDictionary *CydiaEnablePrefsCheck = [[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings];
return CydiaEnablePrefsCheck[[specifier identifier]]?:[[specifier properties] objectForKey:@"default"];
}
}

- (void) loadView
{
[super loadView];
self.title = @"Instagram";
[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:0.09 green:0.99 blue:0.99 alpha:1.0];

}

@end


@implementation BusuuViewController
- (id)specifiers {
if (!_specifiers) {

NSMutableArray* specifiers = [NSMutableArray array];
PSSpecifier* spec;

spec = [PSSpecifier preferenceSpecifierNamed:@"Disable Ads"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSSwitchCell
edit:Nil];
[spec setProperty:@"DisableAds" forKey:@"key"];
[spec setProperty:@NO forKey:@"default"];
[spec setProperty:@YES forKey:@"ExitIG"];
[specifiers addObject:spec];
spec = [PSSpecifier preferenceSpecifierNamed:@"Save Media"
target:self
set:@selector(setPreferenceValue:specifier:)
get:@selector(readPreferenceValue:)
detail:Nil
cell:PSSwitchCell
edit:Nil];
[spec setProperty:@"SaveMedia" forKey:@"key"];
[spec setProperty:@NO forKey:@"default"];
[spec setProperty:@YES forKey:@"ExitBusuu"];
[specifiers addObject:spec];

spec = [PSSpecifier emptyGroupSpecifier];
[specifiers addObject:spec];

[specifiers addObject:spec];
spec = [PSSpecifier emptyGroupSpecifier];
[spec setProperty:[NSString stringWithFormat:@"%@ © 2020 Azozz ALFiras ", self.title] forKey:@"footerText"];
[specifiers addObject:spec];
_specifiers = [specifiers copy];
}
return _specifiers;
}





- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier{
@autoreleasepool {
NSMutableDictionary *CydiaEnablePrefsCheck = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:[NSMutableDictionary dictionary];
[CydiaEnablePrefsCheck setObject:value forKey:[specifier identifier]];
[CydiaEnablePrefsCheck writeToFile:@PLIST_PATH_Settings atomically:YES];
notify_post("co.azozzalfiras.irester/Settings");

if ([[specifier properties] objectForKey:@"ExitBusuu"]) {
[self ExitBusuu];
}

}
}

-(void)ExitBusuu{
  pid_t pid;
  const char* args[] = {"killall", "Busuu", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}
- (id)readPreferenceValue:(PSSpecifier*)specifier
{
@autoreleasepool {
NSDictionary *CydiaEnablePrefsCheck = [[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings];
return CydiaEnablePrefsCheck[[specifier identifier]]?:[[specifier properties] objectForKey:@"default"];
}
}

- (void) loadView
{
[super loadView];
self.title = @"Busuu";
[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [UIColor colorWithRed:0.09 green:0.99 blue:0.99 alpha:1.0];

}

@end
