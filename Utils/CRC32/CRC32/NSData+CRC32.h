//
//  NSData+CRC32.h
//  CRC32
//
//  Created by deng on 2020/6/18.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC32)

- (int32_t)crc32;

@end

NS_ASSUME_NONNULL_END
