//
//  User.h
//  twitter
//
//  Created by Keylonnie Miller on 7/1/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"

@interface User : NSObject


// TODO: Add properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) UIImageView *profileImage;

// TODO: Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
