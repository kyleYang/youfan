//
//  Weak.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#ifndef youfan_Weak_h
#define youfan_Weak_h

#undef weak_delegate
#undef __weak_delegate

#if __has_feature(objc_arc_weak) && \
(!(defined __MAC_OS_X_VERSION_MIN_REQUIRED) || \
__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_8)
#define weak_delegate weak
#define __weak_delegate __weak
#else
#define weak_delegate unsafe_unretained
#define __weak_delegate __unsafe_unretained
#endif


#endif
