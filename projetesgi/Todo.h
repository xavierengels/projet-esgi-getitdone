//
//  Todo.h
//  projetesgi
//
//  Created by xavier engels on 05/03/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * dueDate;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pourcentage;
@property (nonatomic, retain) Project *relationship;

@end
