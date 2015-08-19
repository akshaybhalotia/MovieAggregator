//
//  MovieInfo.h
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject

@property NSString *movieName;
@property NSString *movieRuntime;
@property NSString *movieLang;
@property NSString *leadActor;
@property NSString *genre;

- (NSDictionary *)JSONFromObject;

@end
