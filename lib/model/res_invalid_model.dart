class ResInvalidBaseModel {
  ResInvalidBaseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  final int? statusCode;
  final String? status;
  final String? message;
  final Map? data;

  factory ResInvalidBaseModel.fromJson(Map<String, dynamic> json) => ResInvalidBaseModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": data,
      };
}
