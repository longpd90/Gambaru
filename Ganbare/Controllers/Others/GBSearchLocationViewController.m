//
//  GBSearchLocationViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/22/15.
//  Copyright © 2015 Phung Long. All rights reserved.
//

#import "GBSearchLocationViewController.h"
#import "GBLocationSerVice.h"
#define SearchRadius 10000
@interface GBSearchLocationViewController ()
@property (assign, nonatomic) float lat;
@property (assign, nonatomic) float lng;
@property (strong, nonatomic) NSString *textSearch;

@end

@implementation GBSearchLocationViewController

- (void)viewDidLoad {
    [[GBLocationSerVice sharedLocation] updateLocation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateLocation:) name:GBLocationChangedNotification object:nil];
    [super viewDidLoad];


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GBLocationChangedNotification object:nil];
}


- (void)setGanbare:(GBGanbareEntity *)ganbare {
    _ganbare = ganbare;
}

#pragma mark - location

- (void)getData {
    [super getData];
    // Create and initialize a search request object.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = _textSearch;
    request.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(21.016787, 105.777137), SearchRadius, SearchRadius);
    
    // Create and initialize a search object.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    // Start the search and display the results as annotations on the map.
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    {
        for (MKMapItem *item in response.mapItems) {
            [self.items addObject:item.placemark];
        }
        [self refreshView];
    }];
}

- (void)didUpdateLocation:(NSNotification *)notification {
    _lat = [[GBLocationSerVice sharedLocation] latitude];
    _lng = [[GBLocationSerVice sharedLocation] longitude];
    [[GBLocationSerVice sharedLocation] stopUpdatingLocation];

    NSLog(@"lat :%f", [[GBLocationSerVice sharedLocation] latitude]);
}


#pragma mark - action

- (IBAction)cancelButtonClicked:(id)sender {
    [self goBack:sender];
}

- (IBAction)textfieldDidChange:(id)sender {
    UITextField *textField = (UITextField *)sender;
    _textSearch = textField.text;
    [self refetchData];
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBPlaceTableViewCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    MKPlacemark *placeMark = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text =  placeMark.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKPlacemark *placeMark = [self.items objectAtIndex:indexPath.row];
    _ganbare.ganbareLocation = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",placeMark.coordinate.latitude],[NSString stringWithFormat:@"%f",placeMark.coordinate.longitude], nil];
    _ganbare.ganbaruLocationName = placeMark.name;
    [self goBack:nil];
}

#pragma mark - text field delegate


@end
