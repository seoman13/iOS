//
//  main.m
//  TestingPOSIX
//
//  Created by iOS-School-1 on 18.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pthread.h"

@import Darwin.os.lock;

#define SUCCESS 0

//  parallel array
static NSArray<NSNumber *> *collection;
static const NSUInteger maxThreadCount = 3;

pthread_mutex_t condVarMutex;
pthread_cond_t condVar;

typedef struct Task {
    CFTypeRef collection;
    NSUInteger threadID;
    bool finished;
    NSUInteger sum;
} Task;

void* threadEnumerateArray(void *);
bool checkCondition(Task **);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        collection = @[@(1), @(2), @(3), @(4), @(5), @(6),@(7), @(8), @(9), @(10), @(11), @(12), @(13), @(14), @(15)];
        Task *allThreadArgs[maxThreadCount];
        pthread_mutex_init(&condVarMutex, NULL);
        pthread_cond_init(&condVar, NULL);
        
        NSUInteger addition = collection.count%maxThreadCount;
        NSTimeInterval startTime;
        NSTimeInterval endTime;
        
        //Fork
        for (NSUInteger i = 0; i<maxThreadCount; ++i) {
            NSUInteger length = collection.count/maxThreadCount;
            NSUInteger step = collection.count/ maxThreadCount;
            
            if (addition!=0 && i==(maxThreadCount - 1)) {
                length = length + addition;
            }
            
            NSRange subarrayRange = NSMakeRange(i*step, length);
            pthread_t thread;
            Task *args = malloc(sizeof(Task));
            args->threadID = i;
            args->collection = (void *)CFBridgingRetain([collection subarrayWithRange:subarrayRange]);
            args->finished = false;
            allThreadArgs[i] = args;
            pthread_create(&thread, NULL, threadEnumerateArray, args);
        }
        
        pthread_mutex_lock(&condVarMutex);
        
        while (!checkCondition(allThreadArgs)) {
            // Condvar waiting
            pthread_cond_wait(&condVar, &condVarMutex);
            
        }
        
        // Join
        NSUInteger result = 0;
        for (NSUInteger i = 0; i < maxThreadCount;++i) {
            Task* args = allThreadArgs[i];
            result = result + args->sum;
            
        }
        NSLog(@"Fork-join result %lu", result);
        
        for (NSUInteger i = 0; i < maxThreadCount; ++i) {
            Task* args = allThreadArgs[i];
            free(args);
            args = NULL;
        }
        
        pthread_mutex_unlock(&condVarMutex);
        
        pthread_mutex_destroy(&condVarMutex);
        pthread_cond_destroy(&condVar);
        
//        NSLock *lock = [NSLock new];
        // GCD Block of code
        __block NSUInteger gcdResult = 0;
        __block NSUInteger iterations = 0;
//        dispatch_semaphore_t sincSem = dispatch_semaphore_create(0);
        startTime = [NSDate new].timeIntervalSince1970;
//        dispatch_semaphore_t sem = dispatch_semaphore_create([collection count]);
        dispatch_apply([collection count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//            os_unfair_lock_lock(&lock);
            gcdResult = gcdResult + collection[index].integerValue;
            ++iterations;
//            os_unfair_lock_unlock(&lock);
//            dispatch_semaphore_signal(sincSem);
//            dispatch_semaphore_signal(sem);
        });
        
//        dispatch_semaphore_wait(sincSem, DISPATCH_TIME_FOREVER);
        NSLog(@"GCD result %lu", gcdResult);
        NSLog(@"Right Count %lu", [collection count]);
        NSLog(@"Iterations %lu", iterations);
        endTime = [NSDate new].timeIntervalSince1970;
        NSLog(@"Time elapsed: %f", endTime - startTime);
    }
    
    return 0;
}

bool checkCondition(Task **threadArguments) {
    bool result = true;
    for (NSUInteger i = 0; i < maxThreadCount; ++i) {
        result = result & threadArguments[i]->finished;
    }
    return result;
}

void* threadEnumerateArray(void *args) {
    Task *arguments = (Task *)args;
    NSArray<NSNumber *> *array = (NSArray<NSNumber *> *)CFBridgingRelease(arguments->collection);
    NSUInteger sum = 0;
    
    for (NSNumber *number in array) {
        sum = sum + number.integerValue;
        //NSLog(@"Thread: %lu number: %@", arguments->threadID, number);
    }
    
    pthread_mutex_lock(&condVarMutex);
    arguments->finished = true;
    arguments->sum = sum;
    pthread_cond_signal(&condVar);
    
    pthread_mutex_unlock(&condVarMutex);
    return SUCCESS;
}
