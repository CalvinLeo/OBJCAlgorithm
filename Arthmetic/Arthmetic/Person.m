//
//  Person.m
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "Person.h"


@implementation Person

+ (instancetype)modelWithName:(NSString *)name birthDay:(NSString *)birthday {
    Person *model = [[Person alloc] init];
    model.name = name;
    model.birthDay = birthday;
    return model;
}

@end
