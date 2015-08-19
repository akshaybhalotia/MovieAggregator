//
//  PDFFileGenerator.m
//  MovieInfoGenerator
//
//  Created by Optimus - 113 on 18/08/15.
//  Copyright (c) 2015 iOSRookie. All rights reserved.
//

#import "PDFFileGenerator.h"

@implementation PDFFileGenerator

-(NSString *)getFileType {
    return @"pdf";
}

-(void)generateFileAtPath:(NSString *)path forText:(NSString *)text {
    NSURL *fileURL = [NSURL fileURLWithPathComponents:[NSArray arrayWithObjects:path, nil]];
    @autoreleasepool {
        // Create PDF context
        CFURLRef cfFilePath = (__bridge CFURLRef)fileURL;
        CGContextRef aCgPDFContextRef = [self createPDFContext:CGRectMake(0, 0, 1500, 612) path:cfFilePath];
        CGContextBeginPage(aCgPDFContextRef,nil);
        
        // Drawing commands
        CGContextSelectFont (aCgPDFContextRef, "Helvetica", 24, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode (aCgPDFContextRef, kCGTextFill);
        CGContextSetRGBFillColor (aCgPDFContextRef, 0, 0, 0, 1);
        const char *text1 = [text UTF8String];
        CGContextShowTextAtPoint (aCgPDFContextRef, 50, 500, text1, strlen(text1));
        
        // Clean up
        CGContextEndPage(aCgPDFContextRef);
        CGContextRelease (aCgPDFContextRef);
    }
    
    NSLog(@"Congratulations! Find your file at : %@", path);
}

-(CGContextRef) createPDFContext:(CGRect)aCgRectinMediaBox path:(CFURLRef) aCfurlRefPDF
{
    if (aCfurlRefPDF != NULL) {
        return CGPDFContextCreateWithURL (aCfurlRefPDF, &aCgRectinMediaBox, NULL);
    }
    return NULL;
}

@end
