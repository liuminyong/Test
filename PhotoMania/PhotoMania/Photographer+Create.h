//
//  Photographer+Create.h
//  PhotoMania
//
//  Created by liuminyong on 15/6/22.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;
@end
