/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2011, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
     contributors may be used to endorse or promote products derived from this
     software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "SignInCustomInterfaceViewController.h"

@implementation SignInCustomInterfaceViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    cellTitles = [[NSArray alloc] initWithObjects:
                    @"Background Color", @"Use a custom background color", @"ss",
                    @"Background Image", @"Use a custom background image", @"ss",
                    @"Providers Table Title View", @"Use a custom view for the title above the providers table",  @"sl",
                    @"Providers Table Title String", @"Use a custom string for the title above the providers table", @"sl",
                    @"Providers Table Header View", @"Use a custom view over the providers table", @"ss",
                    @"Providers Table Footer View", @"Use a custom view below the providers table", @"ss",
                    @"Providers Table Section Header View", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Footer View", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Header Title String", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Footer Title String", @"Use a custom view over the list of providers section of the table", @"ll", nil];

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

    cellSwitchStates = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 3)];

    for (NSUInteger i = 0; i < ([cellTitles count] / 3); i++)
        [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (config.iPad)
        return YES;

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

typedef enum
{
    CIAuthenticationBackgroundColor = 0,
    CIAuthenticationBackgroundImageView,
    CIProviderTableTitleView,
    CIProviderTableTitleString,
    CIProviderTableHeaderView,
    CIProviderTableFooterView,
    CIProviderTableSectionHeaderView,
    CIProviderTableSectionFooterView,
    CIProviderTableSectionHeaderTitleString,
    CIProviderTableSectionFooterTitleString,
} CellIndex;

#define CELL_TAG_OFFSET 100

- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetCustomInterface];

    for (NSUInteger i = 0; i < [cellSwitchStates count]; i++)
    {
        BOOL switchState = [((NSNumber*)[cellSwitchStates objectAtIndex:i]) boolValue];

        switch ((CellIndex)i)
        {
            case CIAuthenticationBackgroundColor:
                if (switchState == YES) [config setAuthenticationBackgroundColor:YES];
                else  [config setAuthenticationBackgroundColor:NO];
                break;
            case CIAuthenticationBackgroundImageView:
                if (switchState == YES) [config setAuthenticationBackgroundImageView:YES];
                else  [config setAuthenticationBackgroundImageView:NO];
                break;
            case CIProviderTableTitleView:
                if (switchState == YES) [config setProviderTableTitleView:YES];
                else  [config setProviderTableTitleView:NO];
                break;
            case CIProviderTableTitleString:
                if (switchState == YES) [config setProviderTableTitleString:YES];
                else  [config setProviderTableTitleString:NO];
                break;
            case CIProviderTableHeaderView:
                if (switchState == YES) [config setProviderTableHeaderView:YES];
                else  [config setProviderTableHeaderView:NO];
                break;
            case CIProviderTableFooterView:
                if (switchState == YES) [config setProviderTableFooterView:YES];
                else  [config setProviderTableFooterView:NO];
                break;
            case CIProviderTableSectionHeaderView:
                if (switchState == YES) [config setProviderTableSectionHeaderView:YES];
                else  [config setProviderTableSectionHeaderView:NO];
                break;
            case CIProviderTableSectionFooterView:
                if (switchState == YES) [config setProviderTableSectionFooterView:YES];
                else  [config setProviderTableSectionFooterView:NO];
                break;
            case CIProviderTableSectionHeaderTitleString:
                if (switchState == YES) [config setProviderTableSectionHeaderTitleString:YES];
                else  [config setProviderTableSectionHeaderTitleString:NO];
                break;
            case CIProviderTableSectionFooterTitleString:
                if (switchState == YES) [config setProviderTableSectionFooterTitleString:YES];
                else  [config setProviderTableSectionFooterTitleString:NO];
                break;
            default:
                break;
        }
    }

    StartTestViewController *startTestViewController =
            [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];

    [self.navigationController pushViewController:startTestViewController animated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellTitles count] / 3;
}

- (void)setPreviewForCell:(TestConfigurationTableViewCell*)cell atIndex:(CellIndex)cellIndex
{
    UIButton *cellPreviewButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 24)] autorelease];

    [cellPreviewButton setBackgroundImage:[UIImage imageNamed:@"enabledLightGray"] forState:UIControlStateNormal];
    [cellPreviewButton setEnabled:NO];
    [cellPreviewButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [cellPreviewButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cellPreviewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    switch (cellIndex)
    {
        case CIAuthenticationBackgroundColor:
            [cellPreviewButton setImage:[UIImage imageNamed:@"enabledCyan"] forState:UIControlStateNormal];
            break;
        case CIAuthenticationBackgroundImageView:
            [cellPreviewButton setImage:[UIImage imageNamed:@"enabledWeave"] forState:UIControlStateNormal];
            break;
        case CIProviderTableTitleView:
            [cellPreviewButton setTitle:@"Custom Title View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor magentaColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableTitleString:
            [cellPreviewButton setTitle:@"Custom Title String" forState:UIControlStateNormal];
            break;
        case CIProviderTableHeaderView:
            [cellPreviewButton setTitle:@"Custom Table Header View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor yellowColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            [cellPreviewButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            break;
        case CIProviderTableFooterView:
            [cellPreviewButton setTitle:@"Custom Table Footer View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor greenColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            [cellPreviewButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            break;
        case CIProviderTableSectionHeaderView:
            [cellPreviewButton setTitle:@"Custom Section Header View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor purpleColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableSectionFooterView:
            [cellPreviewButton setTitle:@"Custom Section Footer View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor blueColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableSectionHeaderTitleString:
            [cellPreviewButton setTitle:@"Custom Section Header String" forState:UIControlStateNormal];
            break;
        case CIProviderTableSectionFooterTitleString:
            [cellPreviewButton setTitle:@"Custom Section Footer String" forState:UIControlStateNormal];
            break;
        default:
            break;
    }

    [cell.cellPreview addSubview:cellPreviewButton];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (config.iPad)
        return 110;

    NSString *cellSize = [cellTitles objectAtIndex:((indexPath.row * 3) + 2)];

    if ([cellSize isEqualToString:@"ss"])
        return 110;
    else if ([cellSize isEqualToString:@"ls"])
        return 112;
    else if ([cellSize isEqualToString:@"sl"])
        return 128;
    else if ([cellSize isEqualToString:@"ll"])
        return 130;
    else /* Won't ever happen */
        return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 /* Every third string in our array tells us how big the titles and subtitles strings are (s = short, l = long) */
    NSString *cellSize = [cellTitles objectAtIndex:((indexPath.row * 3) + 2)];
    TCTableViewCellStyle style;

    if (config.iPad)
        style = TCTableViewCellStyleSwitch;
    else if ([cellSize isEqualToString:@"ss"])
        style = TCTableViewCellStyleSwitch;
    else if ([cellSize isEqualToString:@"ls"])
        style = TCTableViewCellStyleSwitchWithLongTitle;
    else if ([cellSize isEqualToString:@"sl"])
        style = TCTableViewCellStyleSwitchWithLongSubtitle;
    else if ([cellSize isEqualToString:@"ll"])
        style = TCTableViewCellStyleSwitchWithLongTitleAndSubtitle;
    else /* Won't ever happen */
        style = TCTableViewCellStyleSwitch;

    TestConfigurationTableViewCell *cell =
        (TestConfigurationTableViewCell*)
                [tableView dequeueReusableCellWithIdentifier:
                        [NSString stringWithFormat:@"cell_%d", indexPath.row]];

    if (cell == nil)
    {
        cell = [[[TestConfigurationTableViewCell alloc]
                 initTestConfigurationTableViewCellWithStyle:style
                                             reuseIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]]
                autorelease];

        [self setPreviewForCell:cell atIndex:(CellIndex)indexPath.row];

        cell.delegate = self;
    }

    cell.cellTitle.text    = [cellTitles objectAtIndex:(indexPath.row * 3)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 3) + 1)];



    cell.tag = CELL_TAG_OFFSET + indexPath.row;

    return cell;
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    if (cellIndex < [cellSwitchStates count])
        [cellSwitchStates replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithBool:cellSwitch.on]];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc
{
    [cellTitles release];
    [cellSwitchStates release];

    [super dealloc];
}


@end

