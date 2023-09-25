
#import "SRKVOController.h"

@interface SRKVOEntry : NSObject
@property (nonatomic, weak)   NSObject *observer;
@property (nonatomic, copy) NSString *keyPath;

@end

@implementation SRKVOEntry

@end

@interface SRKVOController ()
@property (nonatomic, weak) NSObject *target;
@property (nonatomic, strong) NSMutableArray *observerArray;

@end

@implementation SRKVOController

- (instancetype)initWithTarget:(NSObject *)target {
    self = [super init];
    if (self) {
        _target = target;
        _observerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)safelyAddObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context {
    if (_target == nil) return;
    
    NSInteger indexEntry = [self indexEntryOfObserver:observer forKeyPath:keyPath];
    if (indexEntry != NSNotFound) {
        // duplicated register
    } else {
        @try {
            [_target addObserver:observer
                     forKeyPath:keyPath
                        options:options
                        context:context];
            
            SRKVOEntry *entry = [[SRKVOEntry alloc] init];
            entry.observer = observer;
            entry.keyPath  = keyPath;
            [_observerArray addObject:entry];
        } @catch (NSException *e) {
        }
    }
}

- (void)safelyRemoveObserver:(NSObject *)observer
                  forKeyPath:(NSString *)keyPath {
    if (_target == nil) return;
    
    NSInteger indexEntry = [self indexEntryOfObserver:observer forKeyPath:keyPath];
    if (indexEntry == NSNotFound) {
        // duplicated register
    } else {
        [_observerArray removeObjectAtIndex:indexEntry];
        @try {
            [_target removeObserver:observer
                            forKeyPath:keyPath];
        } @catch (NSException *e) {
        }
    }
}

- (void)safelyRemoveAllObservers {
    if (_target == nil) return;
    [_observerArray enumerateObjectsUsingBlock:^(SRKVOEntry *entry, NSUInteger idx, BOOL *stop) {
        if (entry == nil) return;
        NSObject *observer = entry.observer;
        if (observer == nil) return;
        @try {
            [_target removeObserver:observer
                        forKeyPath:entry.keyPath];
        } @catch (NSException *e) {
        }
    }];
    
    [_observerArray removeAllObjects];
}

- (NSInteger)indexEntryOfObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    __block NSInteger foundIndex = NSNotFound;
    [_observerArray enumerateObjectsUsingBlock:^(SRKVOEntry *entry, NSUInteger idx, BOOL *stop) {
        if (entry.observer == observer &&
            [entry.keyPath isEqualToString:keyPath]) {
            foundIndex = idx;
            *stop = YES;
        }
    }];
    return foundIndex;
}

@end
