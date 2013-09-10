//
//  TJHelper.h
//  Fellytone
//
//  Created by Ryhor Burakou on 10/9/13.
//  Copyright (c) 2013 Elinext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (TurboJpeg)

/**
 * Create a UIImage from an NSData using Turbo-JPEG library
 *
 * @param data the JPEG data, desired to be decompressed
 *
 * @return an autoreleased instance of UIImage, if successfull, nil otherwise
 */

+(UIImage*)imageUsingTurboJpegWithData:(NSData *)data;
@end