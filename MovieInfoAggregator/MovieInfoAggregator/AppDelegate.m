//
//  AppDelegate.m
//  MovieInfoAggregator
//
//  Created by Optimus - 113 on 19/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import "AppDelegate.h"
#import "FileFactory.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    FileFactory *myFileGen = [FileFactory new];
    [myFileGen start];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
