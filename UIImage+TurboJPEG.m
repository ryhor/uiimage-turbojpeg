//
//  UIImage+TurboJPEG.h
//  Fellytone
//
//  Created by Ryhor Burakou on 10/9/13.
//  Copyright (c) 2013 Elinext. All rights reserved.
//

#import "UIImage+TurboJPEG.h"
#import "turbojpeg.h"

@implementation UIImage(TurboJpeg)

+ (UIImage*) imageUsingTurboJpegWithData:(NSData*)data
{
    // decompress image (may be bigger than desired size)
    tjhandle handle = tjInitDecompress();

    uint8_t *buffer = malloc(data.length);
    [data getBytes:buffer length:data.length];
    
    //let's decompress header
    int width, height;
    tjDecompressHeader(handle, buffer, data.length, &width, &height);
    
    
    //invalid size
    if (width < 1 || height <1)
    {
        free(buffer);
        tjDestroy(handle);
        return nil;
    }
    
    
    CGSize imageSize = CGSizeMake(width, height);

    
    uint8_t *imageBuffer = malloc(imageSize.width * 4 * imageSize.height);
    int success = tjDecompress2(handle, buffer, data.length, imageBuffer, imageSize.width, imageSize.width * 4, imageSize.height, TJPF_BGRA, TJFLAG_FASTDCT);
    free(buffer);
    
    if (success < 0)
    {
        free(imageBuffer);
        tjDestroy(handle);
        return nil;
    }
    
    
    // Create CGImage from Buffer directly to avoid copy operation to context
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef rawImageDataProvider = CGDataProviderCreateWithData(nil, imageBuffer, imageSize.width * 4 * imageSize.height, MemoryPlaneReleaseDataCallback);
    CGImageRef image = CGImageCreate(imageSize.width, imageSize.height, 8, 8 * 4, imageSize.width * 4, colorspace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little, rawImageDataProvider, NULL, YES, kCGRenderingIntentDefault);
    CGDataProviderRelease(rawImageDataProvider);
    CGColorSpaceRelease(colorspace);
    
    
    // scaling and orientation correction
    CGImageRef result = image;
    UIImage *finalImage = [UIImage imageWithCGImage:result];
    CGImageRelease(image);
    return finalImage;
}


//memory cleanup
static void MemoryPlaneReleaseDataCallback (void *info, const void *data, size_t size) {
    free((void *)data);
}


@end




