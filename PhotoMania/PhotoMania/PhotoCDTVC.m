//
//  PhotoCDTVC.m
//  PhotoMania
//
//  Created by liuminyong on 15/6/24.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "PhotoCDTVC.h"
#import "Photo.h"
#import "ImageViewController.h"

@implementation PhotoCDTVC

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Photo cell"];
    
    Photo *photo=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text=photo.title;
    cell.detailTextLabel.text=photo.subtitle;
    return cell;
}

-(void) prepareViewController:(id)vc forsegue:(NSString *)segueIdentifier
                fromIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo=[self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([vc isKindOfClass:[ImageViewController class]]) {
        ImageViewController *image=(ImageViewController *)vc;
        image.imageURL=[NSURL URLWithString:photo.imageURL];
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
