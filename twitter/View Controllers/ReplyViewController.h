//
//  ReplyViewController.h
//  twitter
//
//  Created by Keylonnie Miller on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetViewController.h"


@protocol ReplyViewControllerDelegate

- (void)didReply:(Tweet *)tweet;

@end

@interface ReplyViewController : UIViewController

@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;
@property (nonatomic, strong) Tweet *tweet;

@end
