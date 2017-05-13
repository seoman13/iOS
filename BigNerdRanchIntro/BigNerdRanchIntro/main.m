//
//  main.m
//  BigNerdRanchIntro
//
//  Created by Admin on 12.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *date = [[NSDate alloc] init];
        NSDate *tomorrow = [date dateByAddingTimeInterval:24.0 * 60.0 * 60.0];
        NSDate *yesterday = [date dateByAddingTimeInterval:-24.0 * 60.0 * 60.0];
        
        NSArray *arr = [NSArray arrayWithObjects:date, tomorrow, yesterday, nil];
        
        NSLog(@"There are %lu elements", [arr count]);
        NSLog(@"First element is %@", [arr objectAtIndex:2]);
        
        int x = 5;
        NSString *str1 = [NSString stringWithFormat:@"The value of x is %d", x];
        NSMutableString *str2 = @"This is mutable string";
        
        NSLog(@"%@", [[NSHost currentHost] localizedName]);
        NSLog(@"%d", [str1 hasSuffix:@"The"]);
        NSLog(@"%@", str1);
        
        NSArray *names = @[@"John", @"Maria", @"Alice", @"Crowley", @"Natalie", @"Sam", @"Frodo", @"Gandalf", @"Sauron", @"Saruman", @"John"];
        
        NSSortDescriptor *ds = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        
//        [names sortedArrayUsingDescriptors:ds];
        
        for(NSString *name in names){
            NSLog(@"%@", name);
        }
        
        NSSet *se = [NSSet setWithArray:names];
        for(NSString *name in se){
            NSLog(@"%@", name);
        }
        
        NSLocale *here = [NSLocale currentLocale];
        NSString *currency = [here objectForKey:NSLocaleCurrencyCode];
        NSLog(@"Money is %@", currency);
        
    }
    sleep(100);
    return 0;
}
