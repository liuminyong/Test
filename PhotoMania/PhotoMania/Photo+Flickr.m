//
//  Photo+Flickr.m
//  PhotoMania
//
//  Created by liuminyong on 15/6/17.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"

@implementation Photo (Flickr)

+(Photo *)photowithFlickrInfo:(NSDictionary *)photoDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo=nil;
    NSString *unique=photoDictionary[FLICKR_PHOTO_ID];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate=[NSPredicate predicateWithFormat:@"unique = %@",unique];
    
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    
    if (!matches ||[matches count]>1||error) {
        
    }else if([matches count])
    {
        photo=[matches firstObject];
    }else
    {
        photo=[NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                            inManagedObjectContext:context];
        
        photo.unique=unique;
        photo.title=[photoDictionary valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.subtitle=[photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL=[[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
   
        NSString *photographerName=[photoDictionary valueForKeyPath:FLICKR_PHOTO_OWNER];
        
        photo.whoTook=[Photographer photographerWithName:photographerName inManagedObjectContext:context];
    }
    return photo;
}

+(void)loadPhotosFromFlickrArray:(NSArray *)photos
         intoManagedObjetContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *photo in photos) {
        [self photowithFlickrInfo:photo inManagedObjectContext:context];
    }
}

@end
