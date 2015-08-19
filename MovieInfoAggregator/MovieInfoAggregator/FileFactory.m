//
//  FileFactory.m
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import "FileFactory.h"
#import "MovieInfo.h"
#import <AppKit/AppKit.h>
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>
#import "TxtFileGenerator.h"
#import "PDFFileGenerator.h"

static NSString *const VALUE_NOT_PROVIDED = @"Value not provided";

@interface FileFactory ()

@end

@implementation FileFactory

-(void)start {
    NSLog(@"Welcome!");
    
    MovieInfo *newMovie = [MovieInfo new];
    
    char *movName = NULL;
    char *movRuntime = NULL;
    char *movLang = NULL;
    char *movActor = NULL;
    char *movGenre = NULL;
    size_t len = 0;
    
    NSLog(@"Please input the following information about the movie:");
    NSLog(@"Movie Name");
    getline(&movName, &len, stdin);
    NSLog(@"Movie Run Time");
    getline(&movRuntime, &len, stdin);
    NSLog(@"Movie Language");
    getline(&movLang, &len, stdin);
    NSLog(@"Lead Actor in Movie");
    getline(&movActor, &len, stdin);
    NSLog(@"Genre of Movie");
    getline(&movGenre, &len, stdin);

    if (movName) {
        newMovie.movieName = [[[NSString stringWithUTF8String:movName] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    }
    else {
        newMovie.movieName = VALUE_NOT_PROVIDED;
    }
    if (movRuntime) {
        newMovie.movieRuntime = [[[NSString stringWithUTF8String:movRuntime] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    }
    else {
        newMovie.movieRuntime = VALUE_NOT_PROVIDED;
    }
    if (movLang) {
        newMovie.movieLang = [[[NSString stringWithUTF8String:movLang] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    }
    else {
        newMovie.movieLang = VALUE_NOT_PROVIDED;
    }
    if (movActor) {
        newMovie.leadActor = [[[NSString stringWithUTF8String:movActor] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    }
    else {
        newMovie.leadActor = VALUE_NOT_PROVIDED;
    }
    if (movGenre) {
        newMovie.genre = [[[NSString stringWithUTF8String:movGenre] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    }
    else {
        newMovie.genre = VALUE_NOT_PROVIDED;
    }
    
    [self askToGenerateFileForObject:newMovie];
}

- (void)askToGenerateFileForObject:(MovieInfo *)movieObject {
    self.fileGenerators = [NSMutableArray arrayWithCapacity:2];
    [self.fileGenerators addObject:[[TxtFileGenerator alloc] init]];
    [self.fileGenerators addObject:[[PDFFileGenerator alloc] init]];
    
    NSLog(@"Thank You! We've stored your inputs. Please choose a file format now:");
    
    int i =1;
    for (id <FileGeneratorProtocol> fileGen in self.fileGenerators) {
        NSLog(@"%d. %@", i, [fileGen getFileType]);
        i++;
    }
    
    int choice;
    scanf("%d", &choice);
    if (choice <= [self.fileGenerators count]) {
        self.fileDelegate = [self.fileGenerators objectAtIndex:(choice - 1)];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[movieObject JSONFromObject] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *newFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"MovieInfo.%@", [self.fileDelegate getFileType]]];
        
        [self.fileDelegate generateFileAtPath:newFile forText:jsonString];
    }
    else {
        NSLog(@"Wrong Input - cannot be processed further.");
    }
}

@end
