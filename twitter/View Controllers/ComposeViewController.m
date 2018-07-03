//
//  ComposeViewController.m
//  twitter
//
//  Created by Keylonnie Miller on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "User.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeText;
@property (strong,nonatomic) NSMutableArray *composedTweetFeed;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewController:(id)sender {
[self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetComposedText:(id)sender {
    NSString *text = self.composeText.text;
    [[APIManager shared] postStatusWithText:(NSString *)text completion:(^(Tweet *tweet, NSError *error) {
    })];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didTweet:(Tweet *)tweet{
    
}

-(void)didTapPost {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
