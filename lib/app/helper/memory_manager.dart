import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class MemoryManager {
  static final Map<String, List<StreamSubscription>> _subscriptions = {};
  static final Map<String, List<Timer>> _timers = {};
  static final Map<String, List<StreamController>> _controllers = {};
  
  /// Register a subscription for automatic disposal
  static void registerSubscription(String key, StreamSubscription subscription) {
    _subscriptions.putIfAbsent(key, () => []).add(subscription);
  }
  
  /// Register a timer for automatic disposal
  static void registerTimer(String key, Timer timer) {
    _timers.putIfAbsent(key, () => []).add(timer);
  }
  
  /// Register a controller for automatic disposal
  static void registerController(String key, StreamController controller) {
    _controllers.putIfAbsent(key, () => []).add(controller);
  }
  
  /// Dispose all resources for a specific key
  static void disposeResources(String key) {
    // Dispose subscriptions
    final subscriptions = _subscriptions.remove(key);
    if (subscriptions != null) {
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    }
    
    // Dispose timers
    final timers = _timers.remove(key);
    if (timers != null) {
      for (final timer in timers) {
        timer.cancel();
      }
    }
    
    // Dispose controllers
    final controllers = _controllers.remove(key);
    if (controllers != null) {
      for (final controller in controllers) {
        controller.close();
      }
    }
    
    if (kDebugMode) {
      developer.log('Disposed resources for: \$key', name: 'MemoryManager');
    }
  }
  
  /// Dispose all resources
  static void disposeAllResources() {
    for (final key in _subscriptions.keys.toList()) {
      disposeResources(key);
    }
    
    if (kDebugMode) {
      developer.log('Disposed all resources', name: 'MemoryManager');
    }
  }
  
  /// Get resource count for a key
  static Map<String, int> getResourceCounts() {
    return {
      'subscriptions': _subscriptions.values.fold(0, (sum, list) => sum + list.length),
      'timers': _timers.values.fold(0, (sum, list) => sum + list.length),
      'controllers': _controllers.values.fold(0, (sum, list) => sum + list.length),
    };
  }
}

class ResourceDisposer {
  final String _key;
  final List<StreamSubscription> _subscriptions = [];
  final List<Timer> _timers = [];
  final List<StreamController> _controllers = [];
  
  ResourceDisposer(this._key);
  
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
    MemoryManager.registerSubscription(_key, subscription);
  }
  
  void addTimer(Timer timer) {
    _timers.add(timer);
    MemoryManager.registerTimer(_key, timer);
  }
  
  void addController(StreamController controller) {
    _controllers.add(controller);
    MemoryManager.registerController(_key, controller);
  }
  
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    
    for (final timer in _timers) {
      timer.cancel();
    }
    
    for (final controller in _controllers) {
      controller.close();
    }
    
    _subscriptions.clear();
    _timers.clear();
    _controllers.clear();
  }
}

mixin ResourceDisposalMixin {
  final ResourceDisposer _disposer = ResourceDisposer(runtimeType.toString());
  
  void addSubscription(StreamSubscription subscription) {
    _disposer.addSubscription(subscription);
  }
  
  void addTimer(Timer timer) {
    _disposer.addTimer(timer);
  }
  
  void addController(StreamController controller) {
    _disposer.addController(controller);
  }
  
  void disposeResources() {
    _disposer.dispose();
  }
}
