// ignore_for_file: non_constant_identifier_names

class SensorData {
  double accel_x, accel_y, accel_z, gyro_x, gyro_y, gyro_z, xAngle, yAngle;

  SensorData({
    required this.accel_x,
    required this.accel_y,
    required this.accel_z,
    required this.gyro_x,
    required this.gyro_y,
    required this.gyro_z,
    required this.xAngle,
    required this.yAngle,
  });

  factory SensorData.fromRTDB(Map<String, dynamic> data) {
    return SensorData(
        accel_x: data['accel_x'] ?? 0.0,
        accel_y: data['accel_y'] ?? 0.0,
        accel_z: data['accel_z'] ?? 0.0,
        gyro_x: data['gyro_x'] ?? 0.0,
        gyro_y: data['gyro_y'] ?? 0.0,
        gyro_z: data['gyro_z'] ?? 0.0,
        xAngle: data['xAngle'] ?? 0.0,
        yAngle: data['yAngle'] ?? 0.0);
  }
  String fancyResults() {
    return 'accelX: ${accel_x.toStringAsFixed(2)}\n'
        'accelY: ${accel_y.toStringAsFixed(2)}\n'
        'accelZ: ${accel_z.toStringAsFixed(2)}\n'
        'gyroX: ${gyro_x.toStringAsFixed(2)}\n'
        'gyroY: ${gyro_y.toStringAsFixed(2)}\n'
        'gyroZ: ${gyro_z.toStringAsFixed(2)}\n'
        'xAngle: ${xAngle.toStringAsFixed(2)}\n'
        'yAngle: ${yAngle.toStringAsFixed(2)}\n';
  }
}
