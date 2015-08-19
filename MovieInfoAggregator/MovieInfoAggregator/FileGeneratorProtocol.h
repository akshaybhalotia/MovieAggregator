//
//  FileGeneratorProtocol.h
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileGeneratorProtocol <NSObject>

- (NSString *)getFileType;
- (void)generateFileAtPath:(NSString *)path forText:(NSString *)text;

@end
