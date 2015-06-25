//
//  Photo+Flickr.h
//  PhotoMania
//
//  Created by liuminyong on 15/6/17.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+(Photo *)photowithFlickrInfo:(NSDictionary *)photoDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context;
+(void)loadPhotosFromFlickrArray:(NSArray *)photos
         intoManagedObjetContext:(NSManagedObjectContext *)context;
@end
