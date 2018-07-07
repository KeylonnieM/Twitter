//
//  TweetViewController.h
//  twitter
//
//  Created by Keylonnie Miller on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIImageView *tweeterImage;
@property (weak, nonatomic) IBOutlet UILabel *tweeterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweeterUsername;
@property (weak, nonatomic) IBOutlet UIButton *followingButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
