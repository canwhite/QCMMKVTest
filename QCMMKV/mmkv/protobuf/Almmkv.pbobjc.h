// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ALMMKV.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class ALKVPair;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - AlmmkvRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface AlmmkvRoot : GPBRootObject
@end

#pragma mark - ALKVPair

typedef GPB_ENUM(ALKVPair_FieldNumber) {
  ALKVPair_FieldNumber_Name = 1,
  ALKVPair_FieldNumber_ObjcType = 2,
  ALKVPair_FieldNumber_BoolVal = 3,
  ALKVPair_FieldNumber_Sint32Val = 4,
  ALKVPair_FieldNumber_StrVal = 5,
  ALKVPair_FieldNumber_FloatVal = 6,
  ALKVPair_FieldNumber_BinaryVal = 7,
  ALKVPair_FieldNumber_DoubleVal = 8,
  ALKVPair_FieldNumber_Sint64Val = 9,
};

typedef GPB_ENUM(ALKVPair_Value_OneOfCase) {
  ALKVPair_Value_OneOfCase_GPBUnsetOneOfCase = 0,
  ALKVPair_Value_OneOfCase_BoolVal = 3,
  ALKVPair_Value_OneOfCase_Sint32Val = 4,
  ALKVPair_Value_OneOfCase_StrVal = 5,
  ALKVPair_Value_OneOfCase_FloatVal = 6,
  ALKVPair_Value_OneOfCase_BinaryVal = 7,
  ALKVPair_Value_OneOfCase_DoubleVal = 8,
  ALKVPair_Value_OneOfCase_Sint64Val = 9,
};

@interface ALKVPair : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *objcType;

@property(nonatomic, readonly) ALKVPair_Value_OneOfCase valueOneOfCase;

@property(nonatomic, readwrite) BOOL boolVal;

@property(nonatomic, readwrite) int32_t sint32Val;

@property(nonatomic, readwrite, copy, null_resettable) NSString *strVal;

@property(nonatomic, readwrite) float floatVal;

@property(nonatomic, readwrite, copy, null_resettable) NSData *binaryVal;

@property(nonatomic, readwrite) double doubleVal;

@property(nonatomic, readwrite) int64_t sint64Val;

@end

/**
 * Clears whatever value was set for the oneof 'value'.
 **/
void ALKVPair_ClearValueOneOfCase(ALKVPair *message);

#pragma mark - ALKVList

typedef GPB_ENUM(ALKVList_FieldNumber) {
  ALKVList_FieldNumber_ItemArray = 1,
};

@interface ALKVList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ALKVPair*> *itemArray;
/** The number of items in @c itemArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger itemArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
