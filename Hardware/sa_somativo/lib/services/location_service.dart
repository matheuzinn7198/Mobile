// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Coordenadas do escritório (ex: centro de São Paulo)
  static const double officeLat = -22.9068;
  static const double officeLng = -43.1729;

  Future<bool> isWithinOfficeRadius() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desativado.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.whileInUse && 
        permission != LocationPermission.always) {
      throw Exception('Permissão de localização negada.');
    }

    Position position = await Geolocator.getCurrentPosition();
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      officeLat,
      officeLng,
    );

    return distance <= 100; // 100 metros
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}