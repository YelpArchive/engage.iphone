//
//  RootViewController.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];
    config.applicationNavigationController = self.navigationController;

    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Sign-In or Sharing?";

    self.navigationItem.titleView = titleLabel;
    self.title = @"Start";
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView                         { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  { return 2; }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 70; }

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)] autorelease];
    view.backgroundColor = JANRAIN_BLUE_20;

    UILabel *headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 56)] autorelease];
    headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.numberOfLines = 2;
    headerLabel.text = @"Welcome to the Janrain Engage for iOS Test Harness app.";

    UIImageView *headerDivider = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"divider.png"]] autorelease];
    headerDivider.frame = CGRectMake(0, 56, 320, 14);

    [view addSubview:headerLabel];
    [view addSubview:headerDivider];

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	if (indexPath.row == 0)
        cell.textLabel.text = @"Test Sign-In";
    else
        cell.textLabel.text = @"Test Sharing";

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.row == 0)
        config.signInOrSharing = CDSignIn;
    else
        config.signInOrSharing = CDSharing;

    TestTypesViewController *level1ViewController = [[TestTypesViewController alloc]
                                                     initWithNibName:@"TestTypesViewController"
                                                     bundle:nil];

	[self.navigationController pushViewController:level1ViewController animated:YES];
	[level1ViewController release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
@end

