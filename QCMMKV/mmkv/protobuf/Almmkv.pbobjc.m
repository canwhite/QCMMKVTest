// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ALMMKV.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import "Almmkv.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - AlmmkvRoot

@implementation AlmmkvRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - AlmmkvRoot_FileDescriptor

static GPBFileDescriptor *AlmmkvRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - ALKVPair

@implementation ALKVPair

@dynamic valueOneOfCase;
@dynamic name;
@dynamic objcType;
@dynamic boolVal;
@dynamic sint32Val;
@dynamic strVal;
@dynamic floatVal;
@dynamic binaryVal;
@dynamic doubleVal;
@dynamic sint64Val;

typedef struct ALKVPair__storage_ {
  uint32_t _has_storage_[2];
  int32_t sint32Val;
  float floatVal;
  __unsafe_unretained NSString *name;
  __unsafe_unretained NSString *objcType;
  __unsafe_unretained NSString *strVal;
  __unsafe_unretained NSData *binaryVal;
  double doubleVal;
  int64_t sint64Val;
} ALKVPair__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "objcType",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_ObjcType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, objcType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "boolVal",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_BoolVal,
        .hasIndex = -1,
        .offset = 2,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "sint32Val",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_Sint32Val,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, sint32Val),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeSInt32,
      },
      {
        .name = "strVal",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_StrVal,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, strVal),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "floatVal",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_FloatVal,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, floatVal),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "binaryVal",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_BinaryVal,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, binaryVal),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBytes,
      },
      {
        .name = "doubleVal",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_DoubleVal,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, doubleVal),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "sint64Val",
        .dataTypeSpecific.className = NULL,
        .number = ALKVPair_FieldNumber_Sint64Val,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(ALKVPair__storage_, sint64Val),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeSInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ALKVPair class]
                                     rootClass:[AlmmkvRoot class]
                                          file:AlmmkvRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ALKVPair__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    static const char *oneofs[] = {
      "value",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\010\002\010\000\003\007\000\004\t\000\005\006\000\006\010\000\007\t\000\010\t\000\t\t\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void ALKVPair_ClearValueOneOfCase(ALKVPair *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - ALKVList

@implementation ALKVList

@dynamic itemArray, itemArray_Count;

typedef struct ALKVList__storage_ {
  uint32_t _has_storage_[1];
 __unsafe_unretained NSMutableArray *itemArray;
} ALKVList__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "itemArray",
        .dataTypeSpecific.className = GPBStringifySymbol(ALKVPair),
        .number = ALKVList_FieldNumber_ItemArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(ALKVList__storage_, itemArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ALKVList class]
                                     rootClass:[AlmmkvRoot class]
                                          file:AlmmkvRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ALKVList__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)