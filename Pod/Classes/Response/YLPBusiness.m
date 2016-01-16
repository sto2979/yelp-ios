//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPGiftCertificate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusiness

- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        _claimed = [businessDict[@"is_claimed"] boolValue];
        _closed = [businessDict[@"is_closed"] boolValue];
        
        _ratingImgURL = [[NSURL alloc] initWithString:businessDict[@"rating_img_url"]];
        _ratingImgURLSmall = [[NSURL alloc] initWithString:businessDict[@"rating_img_url_small"]];
        _ratingImgURLLarge = [[NSURL alloc] initWithString:businessDict[@"rating_img_url_large"]];
        _mobileURL = [[NSURL alloc] initWithString:businessDict[@"mobile_url"]];
        _URL = [[NSURL alloc] initWithString:businessDict[@"url"]];
        
        _snippetImageURL = businessDict[@"snippet_image_url"] ? [[NSURL alloc] initWithString:businessDict[@"snippet_image_url"]] : nil;
        _imageURL = businessDict[@"image_url"] ? [[NSURL alloc] initWithString:businessDict[@"image_url"]] : nil;
        _reservationURL = businessDict[@"reservation_url"] ? [[NSURL alloc] initWithString:businessDict[@"reservation_url"]] : nil;
        _eat24URL = businessDict[@"eat24_url"] ? [[NSURL alloc] initWithString:businessDict[@"eat24_url"]] : nil;
        
        _rating = [businessDict[@"rating"] doubleValue];
       
        _reviewCount = [businessDict[@"review_count"] integerValue];
        
        _snippetText = businessDict[@"snippet_text"];
        _menuProvider = businessDict[@"menu_provider"];
        _displayPhone = businessDict[@"display_phone"];
        _name = businessDict[@"name"];
        _phone = businessDict[@"phone"];
        _identifier = businessDict[@"id"];
        
        _menuDateUpdated = [NSDate dateWithTimeIntervalSince1970:[businessDict[@"menu_date_updated"] doubleValue]];
        
        [self setCategories:businessDict[@"categories"]];
        [self setReviews:businessDict[@"reviews"]];
        [self setGiftCertificates:businessDict[@"gift_certificates"]];
        [self setDeals:businessDict[@"deals"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"]];
    }
    return self;
}

- (void)setCategories:(NSArray *)categories {
    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
    for (id category in categories) {
        [mutableCategories addObject:[[YLPCategory alloc] initWithName:category[0] alias:category[1]]];
    }
    _categories = [[NSArray alloc] initWithArray:mutableCategories];
}

- (void)setReviews:(NSArray *)reviews {
    NSMutableArray *mutableReviews = [[NSMutableArray alloc] init];
    
    for (id review in reviews) {
        [mutableReviews addObject:[[YLPReview alloc] initWithDictionary:review]];
    }
    
    _reviews = [[NSArray alloc] initWithArray:mutableReviews];
}

- (void)setGiftCertificates:(NSArray *)giftCertificates {
    NSMutableArray *mutableGiftCertificates = [[NSMutableArray alloc] init];
    
    for (id gc in giftCertificates) {
        [mutableGiftCertificates addObject:[[YLPGiftCertificate alloc] initWithDictionary:gc]];
    }
    _giftCertificates = [NSArray arrayWithArray:mutableGiftCertificates];
}

- (void)setDeals:(NSArray *)deals {
    NSMutableArray *mutableDeals = [[NSMutableArray alloc] init];
    
    for (id deal in deals) {
        [mutableDeals addObject:[[YLPDeal alloc] initWithDictionary:deal]];
    }
    
    _deals = [[NSArray alloc] initWithArray:mutableDeals];
}

@end
