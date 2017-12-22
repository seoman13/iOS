//
//  ViewController.m
//  TestingCoreAnimation
//
//  Created by Admin on 09.12.17.
//  Copyright © 2017 crest. All rights reserved.
//

#import "ViewController.h"
#import "MySwitchTableViewCell.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource, MySwitchCellDelegate>

@property (nonatomic, strong) NSArray <NSString *> *stringArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *navBarLabel;

@end


@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tabBarItem.title = @"Test Table Row Animation";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect tableFrame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44);
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [self.tableView registerClass:[MySwitchTableViewCell class] forCellReuseIdentifier:[MySwitchTableViewCell reuseIdentifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self fillStringArrayWithSomething];
}

- (void)fillStringArrayWithSomething {
    self.stringArray = @[@"First Try", @"Sec", @"TTT", @"4to4", @"f", @"x", @"sieben"];
}

- (void)switchValueChanged:(UISwitch *)sender fromCell:(MySwitchTableViewCell *)cell {
    if (sender.on && [self.stringArray.lastObject isEqualToString:cell.textView.text]) {
        NSArray <NSIndexPath *> *indxArr = [self addCellToListAfterCell:cell];
        [self.tableView insertRowsAtIndexPaths:indxArr withRowAnimation:UITableViewRowAnimationFade];
    } else if (sender.on) {
        NSArray <NSIndexPath *> *indxArr = [self removeCellsAfterCell:cell butForOne:YES];
        [self.tableView deleteRowsAtIndexPaths:indxArr withRowAnimation:UITableViewRowAnimationFade];
    } else if (!sender.on) {
        NSArray <NSIndexPath *> *indxArr = [self removeCellsAfterCell:cell butForOne:NO];
        [self.tableView deleteRowsAtIndexPaths:indxArr withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSArray <NSIndexPath *> *)removeCellsAfterCell:(MySwitchTableViewCell *)cell butForOne:(BOOL)leaveOne {
    NSUInteger diff = leaveOne ? 1 : 0;
    
    NSMutableArray *copyCells = [self.stringArray mutableCopy];
    NSUInteger indexOfSwitchedCell = [copyCells indexOfObject:cell.textView.text];
    
    NSUInteger indexFromWhichToRemoveElements = MIN(copyCells.count, indexOfSwitchedCell + 1 + diff);
    NSUInteger rangeToRemove = MAX(0, copyCells.count - indexFromWhichToRemoveElements);
    
    NSRange rangeToDelete = NSMakeRange(indexFromWhichToRemoveElements, rangeToRemove);
    [copyCells removeObjectsInRange:rangeToDelete];
    self.stringArray = [copyCells copy];
    
    NSMutableArray <NSIndexPath *> *pathsArray = [NSMutableArray new];
    for (NSUInteger i = indexFromWhichToRemoveElements; i < indexFromWhichToRemoveElements + rangeToRemove; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [pathsArray addObject:indexPath];
    }
    return pathsArray;
}

- (NSArray <NSIndexPath *> *)addCellToListAfterCell:(MySwitchTableViewCell *)tappedCell {
    NSMutableArray *copyCells = [self.stringArray mutableCopy];
    NSUInteger indexOfSwitchedCell = [copyCells indexOfObject:tappedCell.textView.text];
    [copyCells addObject:[NSString stringWithFormat:@"ADDED CELL After No %li", indexOfSwitchedCell]];
    self.stringArray = [copyCells copy];
    return @[[NSIndexPath indexPathForRow:indexOfSwitchedCell + 1 inSection:0]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stringArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MySwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MySwitchTableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.textView.text = self.stringArray[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MySwitchTableViewCell cellDefaultHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
