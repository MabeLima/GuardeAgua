import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';


class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  LatLng defaultPosition = const LatLng(-8.063133040007154, -34.87113973976963);
  Position? _currentPosition;
  bool _isTracking = false;
  List<LatLng> _pathToCalculate = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  double _walkDistance = 0;


  @override
  void initState() {
    super.initState();
    _setCurrentPosition();
  }
  @override
  void dispose() {
    // Cancela a subscrição do stream ao destruir o widget
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _setCurrentPosition()  async{
        _currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
      ),
    );
    print(_currentPosition!.latitude.toString());
    if (mounted){
        setState(() {} );
    }
  }


  void _toggleTracking() async {
    if (_isTracking) {
      _positionStreamSubscription?.cancel();
      if (mounted) {
        setState(() {
          _pathToCalculate = [];
          _walkDistance = 0;
          _isTracking = false;
        });
      }
      print('Rastreamento parado');
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Permissão de localização negada');
          return;
        }
      } else if (permission == LocationPermission.deniedForever) {
        print('Permissão negada permanentemente');
        return;
      }

      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );

      _positionStreamSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
            _pathToCalculate.add(
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
            calculateDistanceWalk();
          });
        }
      });

      if (mounted) {
        setState(() {
          _isTracking = true;
        });
      }
      print('Rastreamento iniciado');
    }
  }

  void _calculateArea() {
    if (_pathToCalculate.length < 3) {
      print("Não há pontos suficientes para calcular a área.");
      return;
    }
    int indice = _pathToCalculate.length;
    if (_pathToCalculate[indice - 1] != _pathToCalculate[0]) {
      _pathToCalculate.add(_pathToCalculate[0]);
    }
    double area = _calculatePolygonArea(_pathToCalculate);
    print("Área do polígono: ${area.toStringAsFixed(2)} m²");
  }

  double _calculatePolygonArea(List<LatLng> points) {
    double area = 0.0;
    int n = points.length;

    for (int i = 0; i < n; i++) {
      double x1 = points[i].longitude;
      double y1 = points[i].latitude;

      double x2 = points[(i + 1) % n].longitude;
      double y2 = points[(i + 1) % n].latitude;

      area += (x1 * y2) - (x2 * y1);
    }

    return (area.abs() / 2.0);
  }

  void calculateDistanceWalk() {
    int indice = _pathToCalculate.length;
    if (indice < 2) {
      print('Pontos insuficientes');
    } else {
      _walkDistance += Geolocator.distanceBetween(
        _pathToCalculate[indice - 2].latitude,
        _pathToCalculate[indice - 2].longitude,
        _pathToCalculate[indice - 1].latitude,
        _pathToCalculate[indice - 1].longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng _initialPosition  = ModalRoute.of(context)!.settings.arguments as LatLng;
    
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _initialPosition,
              initialZoom: 19,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      width: 10,
                      height: 10,
                      child: const Icon(
                        Icons.person_2_sharp,
                        color: Color.fromRGBO(6, 93, 124, 1),
                      ),
                    ),
                  ],
                ),
              if (_pathToCalculate.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _pathToCalculate,
                      color: Colors.blue,
                      strokeWidth: 10,
                    ),
                  ],
                ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  const SizedBox(width: 30),
                  _isTracking? Container(
                          height: 50,
                          width: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              'Total de metros: $_walkDistance',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(_isTracking
                              ? Icons.stop
                              : Icons.chevron_left),
                        ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 15,
            child: Container(
              height: 64,
              width: 386,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(6, 93, 124, 1),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () => _toggleTracking(),
                child: _isTracking
                    ? const Text(
                        "Finalizar",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Ir para o caminhamento",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}