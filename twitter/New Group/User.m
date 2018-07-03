//
//  User.m
//  twitter
//
//  Created by Keylonnie Miller on 7/1/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImage = dictionary[@"profile_image_url"];
        // Initialize any other properties
    }
    //NSLog(@"User.m successful as self returned");
    return self;
}

@end
