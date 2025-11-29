class RequestService {
  final String id;
  final String subcategory;
  final String priority;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String address;
  final double latitude;
  final double longitude;
  final String description;
  final String status;
  final String paymentStatus;
  final String requestId;

  RequestService({
    required this.id,
    required this.subcategory,
    required this.priority,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.status,
    required this.paymentStatus,
    required this.requestId,
  });

  factory RequestService.fromJson(Map<String, dynamic> json) {
    return RequestService(
      id: json["_id"] ?? "",
      subcategory: json["subcategory"] ?? "",
      priority: json["priority"] ?? "",
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      startTime: json["startTime"] ?? "",
      endTime: json["endTime"] ?? "",
      address: json["address"] ?? "",
      latitude: (json["latitude"] ?? 0).toDouble(),
      longitude: (json["longitude"] ?? 0).toDouble(),
      description: json["description"] ?? "",
      status: json["status"] ?? "",
      paymentStatus: json["paymentStatus"] ?? "",
      requestId: json["requestId"] ?? "",
    );
  }
}
