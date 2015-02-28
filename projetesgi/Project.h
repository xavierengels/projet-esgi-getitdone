//
//  Project.h
//  projetesgi
//
//  Created by xavier engels on 28/02/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * identifierP;
@property (nonatomic, retain) NSString * nameP;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Todo *)value;
- (void)removeRelationshipObject:(Todo *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
