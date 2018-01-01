//
//  Created by 0xxd0 on 2016/12/27.
//  Copyright © 2016年 0xxd0. All rights reserved.
//

#include "Extension"
#include <objc/objc.h>
#include <objc/message.h>
#include <pthread.h>
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

namespace CocoaSwift::Protocol {

struct Extension {
#   define CONSTRUCTOR_PRIORITY 100
    static pthread_mutex_t key;
    static size_t count;
    static size_t capacity;
    static Extension *extensions;
    
    ::Protocol *protocol;
    ::Class associated_class;
    
public:
    inline void load() {
        load(protocol, associated_class);
    }
    
    inline void initialize(::Class cls) {
        initialize(protocol, associated_class, cls);
    }
    
private:
    static inline bool load(::Protocol *protocol, ::Class associated_class) {
        pthread_mutex_lock(&key);
        defer {
            pthread_mutex_unlock(&key);
        };
        if (count >= SIZE_MAX) {
            return false;
        }
        if (count >= capacity) {
            size_t new_capacity = capacity == 0 ? 1 : capacity << 1;
            if (new_capacity < capacity) {
                new_capacity = SIZE_MAX;
            }
            if (let ptr = (Extension *)realloc(extensions, sizeof(*extensions) * new_capacity)) {
                capacity = new_capacity;
                extensions = ptr;
            } else {
                return false;
            }
        }
        assert(count < capacity);
        extensions[count] = (Extension) {
            .protocol = protocol,
            .associated_class = associated_class,
        };
        ++count;
        return true;
    }
    
    static inline void initialize(::Protocol *protocol, ::Class associated_class, ::Class cls) {
        let is_meta = class_isMetaClass(cls);
        
        if (var count = (unsigned int)0; let methods = class_copyMethodList(associated_class, &count)) {
            defer {
                free(methods);
            };
            for (var i = 0; i < count; ++i) {
                let method = methods[i];
                let sel = method_getName(method);
                if (sel == sel_getUid("initialize") || sel == sel_getUid("load")) {
                    continue;
                }
                if (class_getInstanceMethod(cls, sel)) {
                    continue;
                }
                let imp = method_getImplementation(method);
                let types = method_getTypeEncoding(method);
                if (!class_addMethod(cls, sel, imp, types)) {
                    fprintf(stderr, "ERROR: Could not add instance method -%s from protocol %s on class %s\n",
                            sel_getName(sel), protocol_getName(protocol), class_getName(cls));
                }
            }
        }
        if (!is_meta) {
            return ({
                initialize(protocol, object_getClass((id)associated_class), object_getClass((id)cls));
                ((::Class(*)(::Class, SEL))objc_msgSend)(associated_class, sel_getUid("class"));;
            });
        }
    }
    
    __attribute__((constructor(CONSTRUCTOR_PRIORITY))) static void construct(void) {
        pthread_mutex_lock(&key);
        defer {
            pthread_mutex_unlock(&key);
        };
        defer {
            free(extensions);
            count = 0;
            capacity = 0;
        };
        var cls_count = (unsigned)0;
        let cls_list = objc_copyClassList(&cls_count);
        defer {
            free(cls_list);
        };
        for (var ext_i = 0; ext_i < count; ++ext_i) {
            var ext = extensions[ext_i];
            for (var cls_i = 0; cls_i < cls_count; ++cls_i) {
                if (let cls = cls_list[cls_i]; class_conformsToProtocol(cls, ext.protocol)) {
                    ext.initialize(cls);
                }
            }
        }
    }
};

var Extension::key = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
var Extension::count = (size_t)0;
var Extension::capacity = (size_t)0;
var Extension::extensions = (Extension *)NULL;
    
}

using namespace CocoaSwift::Protocol;

void protocol_load_extention(Protocol *p, Class cls) {
    var ext = (Extension) {
        .protocol = p,
        .associated_class = cls,
    };
    ext.load();
}
