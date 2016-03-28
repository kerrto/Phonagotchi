//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *basketImage;
@property (strong, nonatomic) IBOutlet UIImageView *appleImage;
- (IBAction)basketPinch:(UIPinchGestureRecognizer *)sender;
- (IBAction)moveApple:(UIPanGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *throwApple;

@property (strong, nonatomic) IBOutlet UIImageView *feedCat;

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
    self.basketImage.userInteractionEnabled=YES;
    self.appleImage.userInteractionEnabled=YES;
    
    
    [self.view addSubview:self.petImageView];
   
    //PetImageViewConstraints+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
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
    
    //Petting Cat Gesture Recognizer+++++++++++++++++++++++++++++++++++++++++++++++++++
    
    UIPanGestureRecognizer *p = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panned:)];
    
    [self.petImageView addGestureRecognizer:p];
    
    UIPinchGestureRecognizer *basketPinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(basketPinch:)];
    
    [self.basketImage addGestureRecognizer:basketPinch];
    [self.view bringSubviewToFront:self.appleImage];
    
    UIPanGestureRecognizer *moveApple=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveApple:)];
    [self.appleImage addGestureRecognizer:moveApple];


}




 //Pinching Apple Gesture Recognizer+++++++++++++++++++++++++++++++++++++++++++++++++++



- (void)basketPinch:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateBegan)
    {
      self.appleImage.transform = CGAffineTransformIdentity;        self.appleImage.image=[UIImage imageNamed:@"apple.png"];
}
}

- (void)moveApple:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint netTranslation;
        CGPoint translation=
        [(UIPanGestureRecognizer *)sender translationInView:self.appleImage];
        
        sender.view.transform=CGAffineTransformMakeTranslation (
        netTranslation.x +translation.x,
        netTranslation.y +translation.y);
        

        
        if (sender.state ==UIGestureRecognizerStateEnded)
        {
            netTranslation.x += translation.x;
            netTranslation.y +=translation.y;
        }
        
            if (CGRectIntersectsRect(self.appleImage.frame, self.feedCat.frame)) {
                
            self.petImageView.image=[UIImage imageNamed:@"default.png"];
            self.appleImage.transform = CGAffineTransformIdentity;
            self.appleImage.image=nil;
            }
        if (CGRectIntersectsRect(self.appleImage.frame, self.throwApple.frame)) {
            
            self.petImageView.image=[UIImage imageNamed:@"grumpy.png"];
              CGRect newFrame = self.appleImage.frame;
            newFrame.origin.y += 550;
            [UIView animateWithDuration:1.0
                             animations:^{
                                 self.appleImage.frame = newFrame;
                             }];

        }
        }
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
//comment1
@end
