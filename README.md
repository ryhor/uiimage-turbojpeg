UIImage+TurboJPEG
=================


This is a simple category on UIImage that allows to load a JPEG from NSData using Turbo-JPEG library, instead of standard iOS imaging methods.

Usage is simple, like this:


NSData *jpegData = ...
UIImage *image = [UIImage imageUsingTurboJpegWithData:jpegData];


=================
Important credits

The library is from here:
https://github.com/dhoerl/PhotoScrollerNetwork

Some code & inspiration from:
https://github.com/dunkelstern/libturbojpeg-ios/tree/master/TurboAssetLoader


Thanks to everyone, and regards.
-ryhor
