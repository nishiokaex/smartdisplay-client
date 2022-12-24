class ViewerState {
  final String deviceId;
  final bool isLoading;
  final bool hasError;

  ViewerState({
    this.deviceId = "",
    this.isLoading = false,
    this.hasError = false,
  });

  static fromMap(Map<String, dynamic> map) {
    return ViewerState(
      deviceId: map['deviceId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
    };
  }
}
