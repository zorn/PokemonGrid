//
//  MainViewController.h
//  PokemonGrid
//
//  Created by Michael Zornek on 6/29/12.
//  Copyright (c) 2012 Clickable Bliss. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
