import 'package:flutter_test/flutter_test.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/runnable.dart';
import 'package:worker_manager/task.dart';

void main() async {
  test('adding stress test', () async {
    // await Executor(isolatePoolSize: 4).warmUp();
    final list = [];
    final tasks = List.generate(10, (i) {
      return Task2(runnable: Runnable(arg1: Counter(), arg2: 10, fun2: Counter.fun21));
    });
    tasks.forEach((task) {
      Executor()
          .addTask(
        task: task,
      )
          .then((data) {
        list.add(data);
      }).catchError((error, stack) {});
//      task.cancel();
    });
    await Future.delayed(Duration(seconds: 5), () {
      expect(list.length, 10);
    });
  });

//  test('scoped test', () async {
//    final list = [];
//    final tasks = List.generate(10, (i) {
//      return Task<int>(function: fib, bundle: 30, timeout: Duration(seconds: 1));
//    });
//    Executor().addScopedTask<int>(tasks: tasks).listen((data) {
//      list.addAll(data);
//    });
//    await Future.delayed(Duration(seconds: 10), () {
//      expect(list.length, 10);
//    });
//  });
}

class Counter {
  int fib(int n) {
    if (n < 2) {
      return n;
    }
    return fib(n - 2) + fib(n - 1);
  }

  static int fun21(Counter counter, int arg) => counter.fib(arg);
}
