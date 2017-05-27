//
//  main.m
//  Multithreading
//
//  Created by Alexey Ulenkov on 18.05.17.
//  Copyright © 2017 Alexey Ulenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>

@import Darwin.os.lock;
#import "SummThread.h"

#define SUCCESS 0

// Параллельный обход массива и подсчет суммы

static NSArray<NSNumber *> *collection;
static NSUInteger maxThreadCount;

pthread_mutex_t condVarMutex;
pthread_cond_t condVar;

os_unfair_lock lock;

// Task struct
typedef struct Task {
    NSRange range; // Рейнж части исходной коллекции которую будем обрабатывать
    NSUInteger threadID;
    bool finished; // Признак окончания таска (используется для возврата значения)
    NSUInteger sum; // Сумма элментов возвращаемой части коллекции (используется для возврата значения)
} Task;

void* threadEnumerateArray(void *);
bool checkCondition(Task **);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Получаем количество активных процессоров, столько потоков и будем создавать
        maxThreadCount = [[NSProcessInfo processInfo] activeProcessorCount];
        
        // Создаем коллекцию для обработки
        NSArray *templateCollection = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(14),@(15)];
        NSUInteger multiplier = 1000000;
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:templateCollection.count*multiplier];
        for (NSUInteger i=0; i<=multiplier; ++i) {
            [tmp addObjectsFromArray:templateCollection];
        }
        collection = [tmp copy];
        
        Task* allThreadArgs[maxThreadCount]; // Массив структур
        pthread_mutex_init(&condVarMutex, NULL);
        pthread_cond_init(&condVar, NULL);
        
        NSTimeInterval startTime; // Измерение производительности
        NSTimeInterval endTime;
        
        startTime = [NSDate new].timeIntervalSince1970;
        
        // Рассчитываем рейнжи для частей массива и запускаем обработку
        NSUInteger addition = collection.count%maxThreadCount;
        // Fork
        for (NSUInteger i=0; i<maxThreadCount; ++i) {
            
            NSUInteger length = collection.count/maxThreadCount;
            NSUInteger step = collection.count/maxThreadCount;
            
            if ( addition!=0 && i==(maxThreadCount-1) ) {
                length = length+addition;
            }
            
            NSRange subarrayRange = NSMakeRange(i*step, length);
            pthread_t thread;
            
            // Создаем и заполняем структуру Task, через которую будут переданы аргументы в поток
            Task *args = malloc(sizeof(Task));
            args->threadID = i;
            args->range = subarrayRange;
            args->finished = false;
            allThreadArgs[i] = args;
            // Запуск потока
            pthread_create(&thread, NULL, threadEnumerateArray, args);
        }
        
        // Реализация шаблона "Ожидание на условной переменной"
        pthread_mutex_lock(&condVarMutex);
        while (!checkCondition(allThreadArgs))
        {
            // Condvar waiting
            pthread_cond_wait(&condVar, &condVarMutex);
            
        }
        pthread_mutex_unlock(&condVarMutex);
        
        // Рассчет результата
        NSUInteger result = 0;
        for (NSUInteger i=0; i<maxThreadCount; ++i) {
            Task* args = allThreadArgs[i];
            result = result + args->sum;
        }
        NSLog(@"Fork-join result %lu", result);
        
        // Очистка памяти
        for (NSUInteger i=0; i<maxThreadCount; ++i) {
            Task* args = allThreadArgs[i];
            free(args);
            args = NULL;
        }
        
        pthread_mutex_destroy(&condVarMutex);
        pthread_cond_destroy(&condVar);
        endTime = [NSDate new].timeIntervalSince1970;
        NSLog(@"Fork-join measured time %f", endTime-startTime);
        
        // Тот же результат на GCD
        __block NSUInteger gcdResult = 0;
        
        startTime = [NSDate new].timeIntervalSince1970;
        NSLock *lock = [NSLock new];
        NSUInteger parallelTasksCount = [[NSProcessInfo processInfo] activeProcessorCount];
        
        // Делим коллекцию на части (по активным процессорам) и запускаем обработку
        dispatch_apply(parallelTasksCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            // Тот же самый код, что и выше для рассчета рейнджей
            NSUInteger addition = collection.count%maxThreadCount;
            
            NSUInteger length = collection.count/maxThreadCount;
            NSUInteger step = collection.count/maxThreadCount;
            
            if ( addition!=0 && index==(maxThreadCount-1) ) {
                length = length+addition;
            }
            
            NSRange range = NSMakeRange(index*step, length);
            
            NSUInteger sum = 0;
            for (NSUInteger i=range.location; i<(range.location+range.length);++i) {
                sum = sum + collection[i].integerValue;
                // NSLog(@"Thread: %lu number: %@", arguments->threadID, number);
            }
            
            // В общую сумму пишем синхронно
            [lock lock];
            gcdResult = gcdResult + sum;
            [lock unlock];
        });
        endTime = [NSDate new].timeIntervalSince1970;
        NSLog(@"GCD result %lu", gcdResult);
        NSLog(@"GCD measured time %f", endTime-startTime);
        
        // Для сравнения однопоточный вариант
        startTime = [NSDate new].timeIntervalSince1970;
        NSUInteger forResult = 0;
        for (NSNumber *number in collection) {
            forResult = forResult + number.integerValue;
        }
        endTime = [NSDate new].timeIntervalSince1970;
        
        NSLog(@"For-in result %lu", forResult);
        NSLog(@"For-in measured time %f", endTime-startTime);
        
        // Вариант с NSThread
        startTime = [NSDate new].timeIntervalSince1970;
        NSUInteger nsThreadResult = 0;
        NSUInteger coresNumber = [[NSProcessInfo processInfo] activeProcessorCount];
        NSLock *threadLock = [NSLock new];
        
        for (NSUInteger i = 0; i < maxThreadCount; i++) {
            SummThread *thr = [SummThread new];
            thr.collection = collection;
            thr.maxThreadCount = maxThreadCount;
            thr.index = i;
            [thr start];
            
            [threadLock lock];
            nsThreadResult += 
        }
        
        endTime = [NSDate new].timeIntervalSince1970;
        
        NSLog(@"NSThread result %lu", forResult);
        NSLog(@"NSThread measured time %f", endTime-startTime);
        
        
    }
    return 0;
}

void summingArray(NSUInteger index) {
    NSUInteger addition = collection.count%maxThreadCount;
    
    NSUInteger length = collection.count/maxThreadCount;
    NSUInteger step = collection.count/maxThreadCount;
    
    if ( addition!=0 && index==(maxThreadCount-1) ) {
        length = length+addition;
    }
    
    NSRange range = NSMakeRange(index*step, length);
    
    NSUInteger sum = 0;
    for (NSUInteger i=range.location; i<(range.location+range.length);++i) {
        sum = sum + collection[i].integerValue;
        // NSLog(@"Thread: %lu number: %@", arguments->threadID, number);
    }
    
    // В общую сумму пишем синхронно
    [lock lock];
    gcdResult = gcdResult + sum;
    [lock unlock];
}


bool checkCondition(Task **threadArguments) {
    bool result = true;
    for (NSUInteger i=0; i<maxThreadCount; ++i) {
        result = result & threadArguments[i]->finished;
    }
    return result;
}

void* threadEnumerateArray(void *args) {
    
    Task *arguments = (Task *)args;
    NSRange range = arguments->range;
    NSUInteger sum = 0;
    
    for (NSUInteger i=range.location; i<(range.location+range.length);++i) {
        sum = sum + collection[i].integerValue;
        // NSLog(@"Thread: %lu number: %@", arguments->threadID, number);
    }
    arguments->finished = true;
    arguments->sum = sum;
    
    // Реализация шаблона "Ожидание на условной переменной"
    pthread_mutex_lock(&condVarMutex);
    pthread_cond_signal(&condVar);
    pthread_mutex_unlock(&condVarMutex);
    return SUCCESS;
}

// GCD Block of code
//       __block NSUInteger gcdResult = 0;
//      __block NSUInteger iterations = 0;
//        dispatch_semaphore_t sincSem = dispatch_semaphore_create(0);
//        dispatch_semaphore_t sem = dispatch_semaphore_create([collection count]);
//        dispatch_apply([collection count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//            os_unfair_lock_lock(&lock);
//            os_unfair_lock_unlock(&lock);
//            dispatch_semaphore_signal(sincSem);
//            dispatch_semaphore_signal(sem);
//        dispatch_semaphore_wait(sincSem, DISPATCH_TIME_FOREVER);
