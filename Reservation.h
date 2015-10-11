//
//  Reservation.h
//  TestTableViewCellUI
//
//  Created by Monte's Pro 13" on 10/11/15.
//  Copyright © 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservation : NSObject

@property NSString *name;
@property NSNumber *phone;
@property NSNumber *partySize;
@property NSString *restuarantURL;
@property NSData *deviceToken;
@property NSNumber *totalAmount;
@property BOOL approved;

@end
