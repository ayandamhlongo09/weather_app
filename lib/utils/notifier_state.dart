enum LoadingStatus { busy, completed, failed, idle }

extension LoadingStatusExt on LoadingStatus {
  bool get isBusy => this == LoadingStatus.busy;

  bool get isIdle => this == LoadingStatus.idle;

  bool get isFailed => this == LoadingStatus.failed;

  bool get isCompleted => this == LoadingStatus.completed;
}