//
//  FileFactory.h
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileGeneratorProtocol.h"

@interface FileFactory : NSObject

@property id <FileGeneratorProtocol> fileDelegate;

- (void)start;

@end
