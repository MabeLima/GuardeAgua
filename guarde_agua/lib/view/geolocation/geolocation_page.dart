import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:math' as Math;


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
  List<LatLng> _pointsArea = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  double _walkDistance = 0;
  double area = 0;


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
    if (mounted){
        setState(() {} );
    }
  }


  void _toggleTracking() async {
    if (_isTracking) {
      _positionStreamSubscription?.cancel();
      if (mounted) {
        setState(() {
          _pointsArea = _pathToCalculate;
          _calculateArea(_pointsArea);
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
        distanceFilter: 3,
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

  void _calculateArea(List<LatLng> points) {
    if (points.length < 3) {
      print("Não há pontos suficientes para calcular a área.");
      return;
    }

    // Não modificar a lista original de pontos
    List<LatLng> pointsWithClosure = List.from(points)..add(points[0]);

    area = calculatePolygonArea(pointsWithClosure);
    print("O valor da área é: ${area.toInt()} m²");
    setState(() {});
    print("Área do polígono: ${area.toStringAsFixed(2)} m²");
  }

  // Novo método para cálculo da área
  static double calculatePolygonArea(List<LatLng> coordinates) {
    double area = 0;

    if (coordinates.length > 2) {
      for (var i = 0; i < coordinates.length - 1; i++) {
        var p1 = coordinates[i];
        var p2 = coordinates[i + 1];
        area += convertToRadian(p2.longitude - p1.longitude) * 
                (2 + Math.sin(convertToRadian(p1.latitude)) + Math.sin(convertToRadian(p2.latitude)));
      }

      area = area.abs() * 6378137 * 6378137 / 2;;
    }

    // Convertendo metros quadrados para acres
    return area;
  }

  static double convertToRadian(double input) {
    return input * Math.pi / 180;
  }

  void calculateDistanceWalk() {
    int indice = _pathToCalculate.length-1;
    if (indice < 2) {
      print('Pontos insuficientes');
    } else {
      _walkDistance += Geolocator.distanceBetween(
        _pathToCalculate[indice - 1].latitude,
        _pathToCalculate[indice - 1].longitude,
        _pathToCalculate[indice].latitude,
        _pathToCalculate[indice].longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng _initialPosition  = LatLng(-8.017632703575888, -34.94476066699429);
   
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
                        Icons.add_location_outlined,
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
              if(_pointsArea.isNotEmpty)
               PolygonLayer(
                polygons: [
                 Polygon(
                  points: _pointsArea,
                  color: Colors.blue.withOpacity(0.5),
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
                              'Total de metros: ' + _walkDistance.toInt().toString() + "m",
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
            left: 0,
            right: 0,
          child: Center(
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
),
      Column(
            children: [
              SizedBox(height: 150),
              Row(
                children: [
                  const SizedBox(width: 30),
                     Container(
                          height: 50,
                          width: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              'área total: ' + area.toInt().toString() + "m²",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}