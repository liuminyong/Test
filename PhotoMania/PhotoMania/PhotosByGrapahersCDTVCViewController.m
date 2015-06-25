//
//  PhotosByGrapahersCDTVCViewController.m
//  PhotoMania
//
//  Created by liuminyong on 15/6/24.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "PhotosByGrapahersCDTVCViewController.h"


@implementation PhotosByGrapahersCDTVCViewController

-(void)setPhotographer:(Photographer *)photographer
{
    _photographer=photographer;
    
    self.title=photographer.name;
    [self setUpFetchedResultsController];
}

-(void)setUpFetchedResultsController
{
    NSManagedObjectContext *context=self.photographer.managedObjectContext;
    
    if (context) {
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.predicate=[NSPredicate predicateWithFormat:@"whoTook = %@",self.photographer];
        request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedStandardCompare:)]];
        
        self.fetchedResultsController=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    }else
    {
        self.fetchedResultsController=nil;
    }
}

@end
