#import "CordovaPermissions.h"

@implementation CordovaPermissions

- (BOOL)isNotificationServicesEnabled {
    
    BOOL isEnabled = NO;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){
        
        UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (!notificationSettings || (notificationSettings.types == UIUserNotificationTypeNone)) {
            isEnabled = NO;
        } else {
            isEnabled = YES;
        }
        
    } else {
        
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (types & UIRemoteNotificationTypeAlert) {
            isEnabled = YES;
        } else{
            isEnabled = NO;
        }
        
    }
    
    return isEnabled;
}

- (void)get:(CDVInvokedUrlCommand*)command {
    
    
    BOOL push=NO;
    BOOL location=NO;
    
    CDVPluginResult* pluginResult;
    
    @ try {
        
        if ([self isNotificationServicesEnabled]) {
            
        } else {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        
        
        NSMutableDictionary* returnInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        
        [returnInfo setObject:[NSNumber numberWithBool:push] forKey:@"notification"];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary : returnInfo];
        
    } @catch (NSException * e) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[e reason]];
        
    } @finally {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
