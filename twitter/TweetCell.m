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
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"
#import "TTTAttributedLabel.h"


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
    self.usernameLabel.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenName];
    
    //Calling the profile picture
    [self.userImageView setImageWithURL:self.tweet.user.profileImage];
    
    NSString *retweetCountS = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.retweetCountLabel.text = retweetCountS;
    self.retweetButton.selected = self.tweet.retweeted;
    
    NSString *favoriteCountS = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.favoriteCountLabel.text = favoriteCountS;
    self.favoriteButton.selected = self.tweet.favorited;
    
}

- (IBAction)retweetButton:(UIButton *)sender {
    if (self.tweet.retweeted != YES){
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    [[APIManager shared] retweetCreate:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
    [self refreshData];
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] retweetDestroy:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        [self refreshData];
    }
}

- (IBAction)favoriteButton:(UIButton *)sender {
    if (self.tweet.favorited != YES){
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    //NSString *reCount = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
        //NSLog(@"%@", reCount);
    [[APIManager shared] favoriteCreate:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    [self refreshData];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        //NSString *reCount = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
        //NSLog(@"%@", reCount);
        [[APIManager shared] favoriteDestroy:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        [self refreshData];
    }
}


-(void) refreshData {
    // Here the retweet objects will be updated
    self.nameLabel.text = self.tweet.user.name;
    self.tweetLabel.text = self.tweet.text;
    
    self.dateLabel.text = self.tweet.createdAtString;
    self.usernameLabel.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenName];
    
    NSString *retweetCountS = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.retweetCountLabel.text = retweetCountS;
    self.retweetButton.selected = self.tweet.retweeted;
    
    NSString *favoriteCountS = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.favoriteCountLabel.text = favoriteCountS;
    self.favoriteButton.selected = self.tweet.favorited;
}
@end
