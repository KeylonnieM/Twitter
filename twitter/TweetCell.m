//
//  TweetCell.m
//  twitter
//
//  Created by Keylonnie Miller on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.nameLabel.text = self.tweet.user.name;
    self.tweetLabel.text = self.tweet.text;
    self.dateLabel.text = self.tweet.createdAtString;
    self.usernameLabel.text = self.tweet.user.screenName;
    
    NSString *retweetCountS = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.retweetCountLabel.text = retweetCountS;
    
    NSString *favoriteCountS = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.favoriteCountLabel.text = favoriteCountS;
    //self.userImageView.image = self.tweet.user.profileImage;
    
    
}
@end
