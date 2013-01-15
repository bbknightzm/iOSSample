//
//  InAppPurchase.m
//  InAppPurchase
//
//  Created by 敏 郑 on 12/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "InAppPurchase.h"

@implementation gceiOSInAppPurchase

- (id) init
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    return self;
}

+ (bool) CanPay
{
    NSLog(@"CanPay\n");
    return [SKPaymentQueue canMakePayments];
}

- (bool) IsPurchased
{
    return m_IsPurchased;
}

- (void) SetProductIdentifier:(const char*)productID len:(int)len
{
    if (m_ProductIdentifier != nil)
    {
        [m_ProductIdentifier release];
    }
    m_ProductIdentifier = [[NSString alloc] initWithBytes:productID length:len encoding:NSASCIIStringEncoding];
    if (m_ProductIdentifier == nil) {
        NSLog(@"ProductIdentifier is nil.");
    }
    m_IsPurchased = false;
}

/*
- (void) SetProductIdentifier:(const char*)productID
{
    if (m_ProductIdentifier != nil)
    {
        [m_ProductIdentifier release];
    }
    m_ProductIdentifier = [[NSString alloc] initWithUTF8String:productID];
    if (m_ProductIdentifier == nil) {
        NSLog(@"ProductIdentifier is nil.");
    }
    m_IsPurchased = false;
}
*/

// Get product information
- (void) RequestItemInfo
{
    NSLog(@"RequestItemInfo.\n");
    NSArray* product = [[NSArray alloc] initWithObjects:m_ProductIdentifier, nil];
    NSSet* identifier = [NSSet setWithArray:product];
    m_ProductRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:identifier];
    m_ProductRequest.delegate = self;
    [m_ProductRequest start];
    [product release];
}

- (void) FinishPayment:(SKPaymentTransaction *)transaction succeed:(bool)succeed
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    if (succeed)
    {
        m_IsPurchased = true;
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:nil];
    }
    else
    {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:nil];
    }
}

- (void) Clear
{
    if (m_ProductIdentifier != nil)
    {
        [m_ProductIdentifier release];
    }
    m_IsPurchased = false;
}

// Get production information response
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Products Request.");
    NSArray *myProduct = response.products;
    NSLog(@"-------------------------");
    if ([myProduct count] <= 0)
    {
        NSLog(@"Invalid Product ID : %@",response.invalidProductIdentifiers);    
        NSLog(@"Product Count : %d", [myProduct count]);
    }
    else
    {
        for(SKProduct *product in myProduct){    
            NSLog(@"product info");    
            NSLog(@"SKProduct description : %@", [product description]);       
            NSLog(@"Title : %@" , product.localizedTitle);    
            NSLog(@"LocalDescription : %@" , product.localizedDescription);    
            NSLog(@"Price : %@" , product.price);    
            NSLog(@"Product id: %@" , product.productIdentifier);     
        }
        m_Product = [myProduct objectAtIndex:0];
        
        SKPayment* payment = nil;
        if (m_Product != nil) {
            payment = [SKPayment paymentWithProduct:m_Product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kInAppPurchaseManagerProductsFetchedNotification" object:self userInfo:nil];
    }
    NSLog(@"-------------------------");
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSLog(@"updatedTransactions\n");
    for (SKPaymentTransaction* transaction in transactions)
    {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Purchased\n");
                [self FinishPayment:transaction succeed:true];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Failed\n");
                [self FinishPayment:transaction succeed:false];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing\n");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored\n");
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    NSLog(@"removedTransactions\n");
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restoreCompletedTransactionsFailedWithError\n");
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished\n");
}

@end

