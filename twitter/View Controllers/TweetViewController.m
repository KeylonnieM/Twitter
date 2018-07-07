//
//  TweetViewController.m
//  twitter
//
//  Created by Keylonnie Miller on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "AppDelegate.h"
#import "TTTAttributedLabel.h"
#import "DateTools.h"
#import "ReplyViewController.h"

@interface TweetViewController () <ReplyViewControllerDelegate>

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpViewer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViewer {
    self.tweetLabel.text = self.tweet.text;
    self.tweeterNameLabel.text = self.tweet.user.name;
    self.dateLabel.text = self.tweet.createdAtString;
    
    self.tweeterUsername.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenName];
    
    //Calling the profile picture
    [self.tweeterImage setImageWithURL:self.tweet.user.profileImage];
    
    NSString *retweetCountS = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.retweetCountLabel.text = retweetCountS;
    self.retweetButton.selected = self.tweet.retweeted;
    
    NSString *favoriteCountS = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.favoriteCountLabel.text = favoriteCountS;
    self.favoriteButton.selected = self.tweet.favorited;
    
}

//- (IBAction)followingButton:(UIButton *)sender {
//}

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
        [self setUpViewer];
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
        [self setUpViewer];
    }
}

- (IBAction)favoriteButton:(id)sender {
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
        [self setUpViewer];
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
        [self setUpViewer];
    }
}

- (void)didReply:(Tweet *)tweet{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)prepareSegue:(UIStoryboardSegue *)segue sender:(id *)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ReplyViewController *replyController = (ReplyViewController*)navigationController.topViewController;
    replyController.delegate = self;
    replyController.tweet = self.tweet;
}
@end
