import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String title = '';
  String price = '';
  String location = '';
  String imageUrl = '';

  final picker = ImagePicker();
  XFile? imageFile;
  Position? currentPosition;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = pickedFile;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTap(LatLng position) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: position,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Judul Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),

            SizedBox(height: 16.0),

            // Harga Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Harga',
              ),
              onChanged: (value) {
                setState(() {
                  price = value;
                });
              },
            ),

            SizedBox(height: 16.0),

            // Lokasi Map
            Container(
              height: 200,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                onTap: _onMapTap,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentPosition?.latitude ?? 0,
                    currentPosition?.longitude ?? 0,
                  ),
                  zoom: 15.0,
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // Image Input
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Ambil Gambar dari Kamera'),
            ),

            SizedBox(height: 16.0),

            // Display Selected Image
            if (imageFile != null)
              Image.file(
                File(imageFile!.path),
                height: 200,
                width: 200,
              ),

            SizedBox(height: 16.0),

            // Tambah Data Button
            ElevatedButton(
              onPressed: () {
                // Perform data validation and submission
                // ...
              },
              child: Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }
}
