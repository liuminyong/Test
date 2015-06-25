//
//  PhotographersCDTVC.m
//  PhotoMania
//
//  Created by liuminyong on 15/6/22.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "PhotographersCDTVC.h"
#import "Photographer.h"
#import "PhotoDatabaseAvailability.h"
#import "PhotosByGrapahersCDTVCViewController.h"

@implementation PhotographersCDTVC

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:PhotoDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.mangedObjectContext=note.userInfo[PhotoDatabaseAvailabilityContext];
    }];
}

-(void)setMangedObjectContext:(NSManagedObjectContext *)mangedObjectContext
{
    _mangedObjectContext=mangedObjectContext;
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)]];
    
    request.fetchLimit=100;
    
    
    self.fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:mangedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Photographer cell"];
    
    Photographer *grapher=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text=grapher.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"count %lu",(unsigned long)[grapher.photos count]];
    return cell;
}

-(void) prepareViewController:(id)vc forsegue:(NSString *)segueIdentifier
                fromIndexPath:(NSIndexPath *)indexPath
{
    Photographer *grapher=[self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[PhotosByGrapahersCDTVCViewController class]]) {
        PhotosByGrapahersCDTVCViewController *pbg=(PhotosByGrapahersCDTVCViewController *)vc;
        pbg.photographer=grapher;
        NSLog(@"%@",grapher.name);
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=nil;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath=[self.tableView indexPathForCell:sender];
    }
    
    [self prepareViewController:segue.destinationViewController forsegue:segue.identifier fromIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detailVC=[self.splitViewController.viewControllers lastObject];
    if ([detailVC isKindOfClass:[UINavigationController class]]) {
        detailVC=[((UINavigationController *)detailVC).viewControllers firstObject];
        
        [self prepareViewController:detailVC forsegue:nil fromIndexPath:indexPath];
    }
}

@end
