//
//  MovieInfo.m
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (NSDictionary *)JSONFromObject {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.movieName, @"1. Movie Name:", self.movieRuntime, @"2. Movie Run Time:", self.movieLang, @"3. Movie Language:", self.leadActor, @"4. Lead Actor:", self.genre, @"5. Genre of Movie:",  nil];
}

@end
