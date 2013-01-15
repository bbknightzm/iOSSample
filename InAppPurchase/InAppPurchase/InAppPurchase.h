//
//  InAppPurchase.h
//  InAppPurchase
//
//  Created by 敏 郑 on 12/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Class
#import <StoreKit/StoreKit.h>
#import <Foundation/Foundation.h>

@interface gceiOSInAppPurchase : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
@private
    NSString*   m_ProductIdentifier;
    SKProduct*  m_Product;
    SKProductsRequest*  m_ProductRequest;
    bool        m_IsPurchased;
}

+ (bool) CanPay;

- (void) SetProductIdentifier:(const char*)productID len:(int)len;

//- (void) SetProductIdentifier:(const char*)productID;

- (bool) IsPurchased;

- (void) RequestItemInfo;

- (void) FinishPayment:(SKPaymentTransaction *)transaction succeed:(bool)succeed;

- (void) Clear;

// protocol form : SKProductsRequestDelegate
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;

// protocol form : SKPaymentTransactionObserver
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;

- (void) paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions;

- (void) paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error;

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue;

@end



