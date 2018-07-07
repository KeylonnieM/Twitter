//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TTTAttributedLabel.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *tweetFeed;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tweetFeed = [[NSArray alloc]init];
    [self fetchTweets];

    
    //Initializing a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    
}

-(void) fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweetFeed = tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
            NSString *text = tweet.text;
            NSLog(@"%@", text);
            }
            /*for (Tweet *tweet in tweets) {
             NSString *text = tweet.text;
             NSLog(@"I have gotten here");
             }*/
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
        // Tell the refreshControl to stop spinning
     [refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    cell.tweet = self.tweetFeed[indexPath.row];
    
    //cell.attributedLabel.delegate = self;
    //cell.attributedLabel.userInteractionEnabled = YES;
    //cell.attributedLabel.text = someText;
    //[self highlightMentionsInLabel:cell.attributedLabel]
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetFeed.count;
}

- (void)didTweet:(Tweet *)tweet{
    [self fetchTweets];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //checking if app has already made a request to the server
    if(!self.isMoreDataLoading){
        self.isMoreDataLoading = true;
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.scrollView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.scrollView.bounds.size.height;
    
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.scrollView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];
        }}
}

-(void)loadMoreData {
    [self fetchTweets];
    self.isMoreDataLoading = false;
} 

- (IBAction)logoutButton:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
   
}

- (void)prepareForSegue: (UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"viewTweetCloser"]){
        UITableViewCell *tappedTweet = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedTweet];
        TweetViewController *tweetViewController = [segue destinationViewController];
        tweetViewController.tweet = self.tweetFeed[indexPath.row];
    }
    else{
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}
}
/*
- (void)prepareSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}
 */
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
