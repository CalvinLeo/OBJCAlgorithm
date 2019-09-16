//
//  Person.h
//  Arthmetic
//
//  Created by Calvin's Macbook Pro on 2019/9/16.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *birthDay;
@property (nonatomic, copy) NSString *name;

+ (instancetype)modelWithName:(NSString *)name birthDay:(NSString *)birthday;

@end

NS_ASSUME_NONNULL_END
