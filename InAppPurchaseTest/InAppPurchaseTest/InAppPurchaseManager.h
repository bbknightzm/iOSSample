//
//  InAppPurchaseManager.h
//  InAppPurchase
//
//  Created by bb on 12/23/12.
//
//

#ifndef __InAppPurchase__InAppPurchaseManager__
#define __InAppPurchase__InAppPurchaseManager__

#include "InAppPurchase.h"

extern "C"
{
    gceiOSInAppPurchase*    m_InAppPurchaseManager = nil;
    
    gceiOSInAppPurchase* InstanceInAppPurchase()
    {
        if (m_InAppPurchaseManager == nil) {
            m_InAppPurchaseManager = [[gceiOSInAppPurchase alloc] init];
        }
        return m_InAppPurchaseManager;
    }
    
    bool CanPay()
    {
        return [gceiOSInAppPurchase CanPay];
    }
    
    void BuyProduct(const char* productIdentifer, int len)
    {
        [InstanceInAppPurchase() SetProductIdentifier:productIdentifer len:len];
        [InstanceInAppPurchase() RequestItemInfo];
    }
    
/*    void BuyProduct(const char* productIdentifer)
    {
        NSLog(@"BuyProduct");
        [InstanceInAppPurchase() SetProductIdentifier:productIdentifer];
        [InstanceInAppPurchase() RequestItemInfo];
    }
*/

    bool IsPurchased()
    {
        return [InstanceInAppPurchase() IsPurchased];
    }
    
    void Clear()
    {
        [InstanceInAppPurchase() Clear];
    }
}



#endif /* defined(__InAppPurchase__InAppPurchaseManager__) */
