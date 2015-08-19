//
//  PluginManager.m
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 19/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import "PluginManager.h"
#import "FileGeneratorProtocol.h"

static NSString *ext = @"filegenplug";

@implementation PluginManager

- (BOOL)checkPluginValidity:(Class)pluginClass {
    if([pluginClass conformsToProtocol:@protocol(FileGeneratorProtocol)])
    {
        if([pluginClass instancesRespondToSelector:@selector(getFileType)] && [pluginClass instancesRespondToSelector:@selector(generateFileAtPath:forText:)])
        {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)findPlugins

{
    NSMutableArray *instances;
    NSMutableArray *bundlePaths;
    NSEnumerator *pathEnum;
    NSString *currPath;
    NSBundle *currBundle;
    Class currPrincipalClass;
    id currInstance;
    
    bundlePaths = [NSMutableArray array];
    if(!instances)
    {
        instances = [[NSMutableArray alloc] init];
    }
    
    [bundlePaths addObjectsFromArray:[self allBundles]];
    
    pathEnum = [bundlePaths objectEnumerator];
    while(currPath = [pathEnum nextObject])
    {
        currBundle = [NSBundle bundleWithPath:currPath];
        if(currBundle)
        {
            currPrincipalClass = [currBundle principalClass];
            if(currPrincipalClass && [self checkPluginValidity:currPrincipalClass])  // Validation
            {
                currInstance = [[currPrincipalClass alloc] init];
                if(currInstance)
                {
                    [instances addObject:currInstance];
                }
            }
        }
    }
    return instances;
}


- (NSMutableArray *)allBundles {
    NSMutableArray *allBundles = [NSMutableArray array];
    NSDirectoryEnumerator *bundleEnum = [[NSFileManager defaultManager] enumeratorAtPath:[[NSBundle mainBundle] builtInPlugInsPath]];
    NSString *currBundlePath;
    if(bundleEnum)
    {
        while(currBundlePath = [bundleEnum nextObject])
        {
            if([[currBundlePath pathExtension] isEqualToString:ext])
            {
                [allBundles addObject:[[[NSBundle mainBundle] builtInPlugInsPath] stringByAppendingPathComponent:currBundlePath]];
            }
        }
    }

    return allBundles;
}

@end
