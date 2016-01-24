//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *basketView;
@property (nonatomic) IBOutlet UIImageView *petImageView;
@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    self.petImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    UIPanGestureRecognizer *p = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
    [self.petImageView addGestureRecognizer:p];
}

- (void)panned:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint vel = [sender velocityInView:self.petImageView];
        CGPoint newVel =CGPointMake(fabs(vel.x), fabs(vel.y));
        NSLog(@"%@", NSStringFromCGPoint(newVel));
        if (vel.x>500 || vel.y>500) {
            self.petImageView.image=[UIImage imageNamed:@"grumpy.png"];}
        }



}
@end
