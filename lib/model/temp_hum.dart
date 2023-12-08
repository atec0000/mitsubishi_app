class MyJsonResponse {
  final int temp;
  final int hum;

  MyJsonResponse(this.temp, this.hum);

  factory MyJsonResponse.fromJson(Map<String, dynamic> json) {
    final int temp = int.parse(json['temp']);
    final int hum = int.parse(json['hum']);
    return MyJsonResponse(temp, hum);
  }
}
