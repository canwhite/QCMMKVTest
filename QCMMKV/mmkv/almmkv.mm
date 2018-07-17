//
//  almmkv.m
//  mmkv
//
//  Created by Alex Lee on 2018/7/12.
//  Copyright © 2018 alexlee002. All rights reserved.
//

#import "almmkv.h"
#import "Almmkv.pbobjc.h"
#import "rwlock.hpp"
#import <sys/mman.h>
#import <sys/stat.h>

#ifndef ALMMKV_defer
#define ALMMKV_defer \
    __strong almmkv_cleanup_block_t almmkv_exit_block_ ## __LINE__ \
    __attribute__((cleanup(almmkv_cleanup_block), unused)) = ^

typedef void (^almmkv_cleanup_block_t)(void);
static __inline__ __attribute__((always_inline)) void almmkv_cleanup_block (__strong almmkv_cleanup_block_t *block) {
    (*block)();
}
#endif

static size_t kPageSize = 256 * 1024;
@implementation ALMMKV {
    int _fd;
    NSString *_path;
    void *_mmptr;
    size_t _mmsize;
    size_t _cursize;
    
    NSMutableDictionary<NSString *, ALKVPair *> *_dict;
    almmkv::RWLock _lock;
}

+ (instancetype)defaultMMKV {
#if TARGET_OS_IPHONE || TARGET_OS_IOS || TARGET_OS_WATCH || TARGET_OS_TV || TARGET_OS_SIMULATOR
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
#else
    NSString *path = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:[NSBundle mainBundle].bundleIdentifier];
#endif
    path = [path stringByAppendingPathComponent:@"default.mmkv"];
    return [self mmkvWithPath:path];
}

static NSMapTable<NSString *, ALMMKV *> *kInstances;
+ (instancetype)mmkvWithPath:(NSString *)path {
    static dispatch_semaphore_t kLocalLock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kInstances = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                           valueOptions:NSPointerFunctionsWeakMemory];
        kLocalLock = dispatch_semaphore_create(1);
    });
    
    path = path.stringByStandardizingPath;
    {
        dispatch_semaphore_wait(kLocalLock, DISPATCH_TIME_FOREVER);
        ALMMKV_defer {dispatch_semaphore_signal(kLocalLock);};
        
        ALMMKV *mmkv = [kInstances objectForKey:path];
        if (mmkv == nil) {
            mmkv = [[ALMMKV alloc] initWithFile:path];
            [kInstances setObject:mmkv forKey:path];
        }
        return mmkv;
    }
}

- (instancetype)init {
    [NSException raise:@"ALMMKVForbiddenException" format:@"Can initialize mmkv via -init"];
    return nil;
}

- (instancetype)initWithFile:(NSString *)path {
    self = [super init];
    if (self) {
        NSError *error = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent]
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error]) {
            NSAssert(NO, @"Create path error: %@", error);
            return nil;
        }
        
        _fd = open([path fileSystemRepresentation], O_RDWR | O_CREAT, 0666);
        if (_fd == 0) {
            NSAssert(NO, @"Can not open file: %@", path);
            return nil;
        }
        struct stat statInfo;
        if( fstat( _fd, &statInfo ) != 0 ) {
            [self cleanup];
            NSAssert(NO, @"Can not read file: %@", path);
            return nil;
        }
        
        _mmsize = ((statInfo.st_size / kPageSize) + 1) * kPageSize;
        ftruncate(_fd, _mmsize);
        _mmptr = mmap(NULL, _mmsize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, _fd, 0);
        if (_mmptr == MAP_FAILED) {
            [self cleanup];
            NSAssert(NO, @"mmap failed. error: %d", errno);
            return nil;
        }
        
        _path = [path copy];
        [self load];
    }
    return self;
}

- (void)dealloc {
    [self cleanup];
}

- (void)cleanup {
    if (_mmptr) {
        munmap(_mmptr, _cursize);
    }
    if (_fd) {
        ftruncate(_fd, _cursize);
        close(_fd);
    }
}

#pragma mark - primitive types
- (BOOL)boolForKey:(NSString *)key {
    ALKVPair *kv = [self _itemForKey:key];
    id val = [self _numberValue:kv];
    if (val == nil) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
            val = kv.strVal;
        }
    }
    return [val boolValue];
}

- (NSInteger)integerForKey:(NSString *)key {
    ALKVPair *kv = [self _itemForKey:key];
    id val = [self _numberValue:kv];
    if (val == nil) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
            val = kv.strVal;
        }
    }
    return [val integerValue];
}

- (float)floatForKey:(NSString *)key {
    ALKVPair *kv = [self _itemForKey:key];
    id val = [self _numberValue:kv];
    if (val == nil) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
            val = kv.strVal;
        }
    }
    return [val floatValue];
}

- (double)doubleForKey:(NSString *)key {
    ALKVPair *kv = [self _itemForKey:key];
    id val = [self _numberValue:kv];
    if (val == nil) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
            val = kv.strVal;
        }
    }
    return [val doubleValue];
}

#pragma mark - read: ObjC objects
- (id)objectOfClass:(Class)cls forKey:(NSString *)key {
    ALKVPair *kv = [self _itemForKey:key];
    
#ifndef CASE_CLASS
#define CASE_CLASS(cls, type) if (cls == type.class || [cls isSubclassOfClass:type.class])
#endif
    
    CASE_CLASS(cls, NSNumber) {
        return [self _numberValue:kv];
    }
    CASE_CLASS(cls, NSString) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
            return kv.strVal;
        }
        return [[self _numberValue:kv] stringValue];
    }
    CASE_CLASS(cls, NSData) {
        if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_BinaryVal) {
            return kv.binaryVal;
        }
        return nil;
    }
    CASE_CLASS(cls, NSDate) {
        Class octype = [self _objCType:kv];
        CASE_CLASS(octype, NSDate) {
            id val = [self _unarchiveValueForClass:NSDate.class fromItem:kv];
            if (val == nil) {
                val = [self _numberValue:kv];
                return val ? [NSDate dateWithTimeIntervalSince1970:[val doubleValue]] : nil;
            }
            return val;
        }
        return nil;
    }
    CASE_CLASS(cls, NSURL) {
        Class octype = [self _objCType:kv];
        CASE_CLASS(octype, NSURL) {
            id val = [self _unarchiveValueForClass:NSURL.class fromItem:kv];
            if (val == nil && kv.valueOneOfCase == ALKVPair_Value_OneOfCase_StrVal) {
                return [NSURL URLWithString:kv.strVal];
            }
            return val;
        }
        return nil;
    }
    
    return [self _unarchiveValueForClass:NSURL.class fromItem:kv];
}

#pragma mark - read: private
- (ALKVPair *)_itemForKey:(NSString *)key {
//    dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER);
//    ALMMKV_defer {
//        dispatch_semaphore_signal(self->_lock);
//    };
    
    self->_lock.lock_read();
    ALMMKV_defer { self->_lock.unlock_read(); };
    
    ALKVPair *kv = _dict[key];
    return kv;
}

- (Class)_objCType:(ALKVPair *)kv {
    if (kv.objcType) {
        return NSClassFromString(kv.objcType);
    }
    return nil;
}

- (NSNumber *)_numberValue:(ALKVPair *)kv{
    switch (kv.valueOneOfCase) {
        case ALKVPair_Value_OneOfCase_Sint32Val: return @(kv.sint32Val);
        case ALKVPair_Value_OneOfCase_Sint64Val: return @(kv.sint64Val);
        case ALKVPair_Value_OneOfCase_BoolVal:   return @(kv.boolVal);
        case ALKVPair_Value_OneOfCase_FloatVal:  return @(kv.floatVal);
        case ALKVPair_Value_OneOfCase_DoubleVal: return @(kv.doubleVal);
        case ALKVPair_Value_OneOfCase_BinaryVal:
            return [self _unarchiveValueForClass:NSNumber.class fromItem:kv];
        default: return nil;
    }
}

- (id)_unarchiveValueForClass:(Class)cls fromItem:(ALKVPair *)kv {
    if (kv.valueOneOfCase == ALKVPair_Value_OneOfCase_BinaryVal) {
        @try {
            id val = [NSKeyedUnarchiver unarchiveObjectWithData:kv.binaryVal];
            return [val isKindOfClass:cls] ? val : nil;
        } @catch (NSException *e) {
            return nil;
        }
    }
    return nil;
}

#pragma mark - set: primitive types
- (void)setBool:(BOOL)val forKey:(NSString *)key {
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.boolVal = val;
    kv.objcType = @"NSNumber";
    [self append:kv];
}

- (void)setInteger:(NSInteger)intval forKey:(NSString *)key {
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.objcType = @"NSNumber";
    if (intval > INT_MAX) {
        kv.sint64Val = (int64_t)intval;
    } else {
        kv.sint32Val = (int32_t)intval;
    }
    [self append:kv];
}

- (void)setFloat:(float)val forKey:(NSString *)key {
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.floatVal = val;
    kv.objcType = @"NSNumber";
    [self append:kv];
}

- (void)setDouble:(double)val forKey:(NSString *)key {
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.doubleVal = val;
    kv.objcType = @"NSNumber";
    [self append:kv];
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    if (obj == nil) {
        [self removeObjectForKey:key];
        return;
    }
    
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.objcType = NSStringFromClass([obj class]);
    
    if ([obj isKindOfClass:NSString.class]) {
        kv.strVal = (NSString *)obj;
    } else if ([obj isKindOfClass:NSNumber.class]) {
        kv.strVal = [(NSNumber *)obj stringValue];
    } else if ([obj isKindOfClass:NSData.class]) {
        kv.binaryVal = (NSData *)obj;
    } else if ([obj isKindOfClass:NSDate.class]) {
        kv.doubleVal = ((NSDate *)obj).timeIntervalSince1970;
    } else if ([obj isKindOfClass:NSURL.class]) {
        kv.strVal = [(NSURL *)obj absoluteString];
    } else {
        kv.binaryVal = [NSKeyedArchiver archivedDataWithRootObject:obj]; // should throw if exception.
    }
    
    [self append:kv];
}

- (void)removeObjectForKey:(NSString *)key {
    ALKVPair *kv = [ALKVPair message];
    kv.name = key;
    kv.objcType = @"NSNull";
    [self append:kv];
}

- (void)reset {
    [_dict removeAllObjects];
    
    munmap(_mmptr, _mmsize);
    _mmsize = kPageSize;
    ftruncate(_fd, _mmsize);
    _mmptr = mmap(NULL, _mmsize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, _fd, 0);
}

- (void)append:(ALKVPair *)item {
//    dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER);
//    ALMMKV_defer {
//         dispatch_semaphore_signal(self->_lock);
//    };
    
    self->_lock.lock_write();
    ALMMKV_defer { self->_lock.unlock_write(); };
    
    _dict[item.name] = item;
    
    NSMutableData *data = [NSMutableData data];
    [data appendBytes:"\n" length:1];
    [data appendData:item.delimitedData];
    
    if (data.length + _cursize >= _mmsize) {
        [self reallocWithExtraSize:data.length];
    }
    memcpy((char *)_mmptr + _cursize, data.bytes, data.length);
    _cursize += data.length;
}

- (void)load {
    _dict = [NSMutableDictionary dictionary];
    NSData *data = [NSData dataWithBytes:_mmptr length:_cursize];
    ALKVList *kvlist = [ALKVList parseFromData:data error:nil];
    for (ALKVPair *item in kvlist.itemArray) {
        if (item.name != nil) {
            _dict[item.name] = item;
        }
    }
}

- (void)reallocWithExtraSize:(size_t)size {
    ALKVList *kvlist = [ALKVList message];
    kvlist.itemArray = _dict.allValues.mutableCopy;
    NSData *data = kvlist.data;
    _cursize = data.length;
    
    size_t newTotalSize = _cursize + size;
    if (newTotalSize >= _mmsize) {
        munmap(_mmptr, _mmsize);
        _mmsize = ((newTotalSize / kPageSize) + 1) * kPageSize;
        ftruncate(_fd, _mmsize);
        _mmptr = mmap(NULL, _mmsize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, _fd, 0);
        memcpy(_mmptr, data.bytes, data.length);
    }
}

#if DEBUG
+ (void)dump {
    typeof(kInstances) tmp = kInstances;
    NSLog(@"instances: %@", tmp);
}
#endif
@end
