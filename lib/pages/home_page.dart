import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:student_helper/services/auth_service.dart';
import 'package:student_helper/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
//AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE
class HomePage extends StatefulWidget {
  static String routename = "home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth_service _auth= new auth_service();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _state=0;
  bool _isLoading=false;
  bool _showButtons = true;
  Position? location;
  Set<Marker> _markers = Set<Marker>();
  late Future<Position> _getPosition;
  Set<Polyline> _routes = {};
  PolylinePoints _polylinePoints = PolylinePoints();
  GoogleMapController? _mapController;
  int range=40;
  late Future _getUsers;

  Future getAddress(double latitude,double longitude)async{
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    return "${placemarks[0].name}, ${placemarks[0].locality},${placemarks[0].administrativeArea} ,${placemarks[0].country}";
  }

  void _zoom(){
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(location!.latitude,location!.longitude),
        zoom: 16.5
    )));
  }


  void _drawRoute(LatLng destination) async {

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE",
      PointLatLng(location!.latitude, location!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      Polyline routePolyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.red,
        points: polylineCoordinates,
        width: 5,
      );

      setState(() {
        _routes.clear();
        _routes.add(routePolyline);
      });
    }
  }

  // Create the polyline



  Future<Position> getLocatiom()async{
    Set<Marker> markers=Set<Marker>();
    Position tempLocation = await Geolocator.getCurrentPosition();
    markers.add(Marker(
        markerId:const MarkerId('current'),
        position: LatLng(tempLocation!.latitude, tempLocation!.longitude),
        infoWindow: InfoWindow(
            title: 'You'
        )
      // icon: BitmapDescriptor.,
    ));
    setState((){
      location=tempLocation;
      _markers=markers;
      _isLoading=false;
    });
    _zoomOut();
    return tempLocation;
  }
  void _zoomOut(){
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(location!.latitude,location!.longitude),
        zoom: 16
    )));
    setState(() {
      _routes={};
      _showButtons=true;
    });
  }

  Future<void> fetchHostelLocations() async {
    Set<Marker> markers=Set<Marker>();
    final apiKey = 'AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+location!.latitude.toString()+','+location!.longitude.toString()+'&radius=$range&type=lodging&keyword=hostel&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    print(response);
    List hostels=[];
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        hostels=data["results"];
        for(var i=0;i<hostels.length;i++){
          Uint8List byteData = (await NetworkAssetBundle(Uri.parse("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).load("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).buffer.asUint8List();
          markers.add(
              Marker(
                  icon: BitmapDescriptor.fromBytes(byteData),
                  markerId:MarkerId(hostels[i]["place_id"]),
                  position: LatLng(hostels[i]["geometry"]["location"]["lat"], hostels[i]["geometry"]["location"]["lng"]),
                  infoWindow: InfoWindow(
                      title:hostels[i]["name"],
                      snippet: hostels[i]["vicinity"]
                  ),
                  onTap: (){
                    _drawRoute(LatLng(hostels[i]["geometry"]["location"]["lat"], hostels[i]["geometry"]["location"]["lng"]));
                  }
              )
          );
        }
        _zoom();
        setState(() {
          _markers=markers;
          _markers.add(Marker(
              markerId:const MarkerId('current'),
              position: LatLng(location!.latitude, location!.longitude),
              infoWindow: InfoWindow(
                  title: 'You'
              )
            // icon: BitmapDescriptor.,
          ));
          _isLoading=false;
        });
      }
      else{
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No result please increase the range")));
      }
    }
  }


  Future<void> fetchStationaryLocations()async{
    Set<Marker> markers=Set<Marker>();
    final apiKey = 'AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+location!.latitude.toString()+','+location!.longitude.toString()+'&radius=$range&type=store&keyword=store&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    print(response);
    List stationary=[];
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        stationary=data["results"];
        for(var i=0;i<stationary.length;i++){
          Uint8List byteData = (await NetworkAssetBundle(Uri.parse("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).load("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).buffer.asUint8List();
          markers.add(
              Marker(
                  icon: BitmapDescriptor.fromBytes(byteData),
                  markerId:MarkerId(stationary[i]["place_id"]),
                  position: LatLng(stationary[i]["geometry"]["location"]["lat"], stationary[i]["geometry"]["location"]["lng"]),
                  infoWindow: InfoWindow(
                      title: stationary[i]["name"],
                      snippet: stationary[i]["vicinity"]
                  ),
                  onTap: (){
                    _drawRoute(LatLng(stationary[i]["geometry"]["location"]["lat"], stationary[i]["geometry"]["location"]["lng"]));
                  }
              )
          );
        }
        _zoom();
        setState(() {
          _markers=markers;
          _markers.add(Marker(
              markerId:const MarkerId('current'),
              position: LatLng(location!.latitude, location!.longitude),
              infoWindow: InfoWindow(
                  title: 'You'
              )
            // icon: BitmapDescriptor.,
          ));
          _routes={};
          _isLoading=false;
        });
      }
      else{
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No result please increase the range")));
      }
    }
  }



  Future<void> fetchFoodLocations()async{
    Set<Marker> markers=Set<Marker>();
    final apiKey = 'AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+location!.latitude.toString()+','+location!.longitude.toString()+'&radius=$range&type=restaurant&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    print(response);
    List foods=[];
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        foods=data["results"];
        for(var i=0;i<foods.length;i++){
          Uint8List byteData = (await NetworkAssetBundle(Uri.parse("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).load("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).buffer.asUint8List();
          markers.add(
              Marker(
                  icon: BitmapDescriptor.fromBytes(byteData),
                  markerId:MarkerId(foods[i]["place_id"]),
                  position: LatLng(foods[i]["geometry"]["location"]["lat"], foods[i]["geometry"]["location"]["lng"]),
                  infoWindow: InfoWindow(
                      title:foods[i]["name"],
                      snippet: foods[i]["vicinity"]
                  ),
                  onTap: (){
                    _drawRoute(LatLng(foods[i]["geometry"]["location"]["lat"], foods[i]["geometry"]["location"]["lng"]));
                  }
              )
          );
        }
        _zoom();
        setState(() {
          _markers=markers;
          _markers.add(Marker(
              markerId:const MarkerId('current'),
              position: LatLng(location!.latitude, location!.longitude),
              infoWindow: InfoWindow(
                  title: 'You'
              )
            // icon: BitmapDescriptor.,
          ));
          _routes={};
          _isLoading=false;
        });
      }
      else{
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No result please increase the range")));
      }
    }
  }



  Future<void> fetchPharmacyLocations()async{
    Set<Marker> markers=Set<Marker>();
    final apiKey = 'AIzaSyB39wAtlZ6GeIALzXYQMk6UeSX2iNtOpPE';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+location!.latitude.toString()+','+location!.longitude.toString()+'&radius=$range&type=pharmacy&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    print(response);
    List pharmacys=[];
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data['status'] == 'OK') {

        pharmacys=data["results"];
        for(var i=0;i<pharmacys.length;i++){
          Uint8List byteData = (await NetworkAssetBundle(Uri.parse("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).load("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png")).buffer.asUint8List();
          markers.add(
              Marker(
                  icon: BitmapDescriptor.fromBytes(byteData),
                  markerId:MarkerId(pharmacys[i]["place_id"]),
                  position: LatLng(pharmacys[i]["geometry"]["location"]["lat"], pharmacys[i]["geometry"]["location"]["lng"]),
                  infoWindow: InfoWindow(
                      title: pharmacys[i]["name"],
                      snippet: pharmacys[i]["vicinity"]
                  ),
                  onTap: (){
                    _drawRoute(LatLng(pharmacys[i]["geometry"]["location"]["lat"], pharmacys[i]["geometry"]["location"]["lng"]));
                  }
              )
          );
        }
        _zoom();
        setState(() {
          _markers=markers;
          _markers.add(Marker(
              markerId:const MarkerId('current'),
              position: LatLng(location!.latitude, location!.longitude),
              infoWindow: InfoWindow(
                  title: 'You'
              )
            // icon: BitmapDescriptor.,
          ));
          _routes={};
          _isLoading=false;
        });
      }
      else{
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No result please increase the range")));
      }
    }
    print("here");
  }


  Future<Position> initLocation()async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print(serviceEnabled);
      if (!serviceEnabled) {
        loc.Location().requestPermission();
      }
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await getLocatiom();
  }


  @override
  void initState(){
    super.initState();
    _getPosition=initLocation();
    _getUsers=_auth.getUserInfo();
  }

  Widget _customizedButton(String value,int val,int selectedValue){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      width: 100,
      height: 30,
      decoration: BoxDecoration(
          color: _state==selectedValue?Color(0xffd0cfcf):Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ]
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            _state=selectedValue;
            range=val;

          });
        },
        child: Center(
          child: Text(value,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _getUsers,
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Container(
            width: width,
            height: height,
            child: Center(child: CircularProgressIndicator(color:Colors.blue)),
          );
        }
        if(snapshot.hasData){
          UserModel user = snapshot.data;
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Container(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.person_4_outlined,color: Colors.white,),
                            Text('${user.displayName}'),
                            Text('${user.email}'),
                            Text('${user.phoneNumber}')
                          ],
                        )
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.emergency_share_outlined,color: Colors.black,),
                    title: Text('Emergency'),
                    onTap: ()async{
                      String address = await getAddress(location!.latitude,location!.longitude) as String;
                      final Email email = Email(
                        body: 'user:${user.displayName}\n Location:${address}',
                        subject: 'Emergency',
                        recipients: ['tmslstudenthelper@gmail.com'],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout,color: Colors.black,),
                    title: Text('Logout'),
                    onTap: ()async{
                      await _auth.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logging Out....")));
                      Future.delayed(Duration(seconds: 2),(){
                        Navigator.pushNamed(context, "start");
                      });
                    },
                  ),

                ],
              )
            ),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu,),
                onPressed: (){
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: Text("Welcome ${user.displayName}"),
            ),
            body: SafeArea(
                child:FutureBuilder(
                  future: _getPosition,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        alignment: Alignment.center,
                        child:const CircularProgressIndicator(),
                      );
                    }
                    return  Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(target: LatLng(location!.latitude,location!.longitude),
                              zoom: 15
                          ),
                          mapType: MapType.normal,
                          compassEnabled: false,
                          markers: Set.from(_markers),
                          polylines:  _routes,
                          myLocationButtonEnabled: true,
                          onMapCreated: (GoogleMapController controller){
                            _mapController=controller;
                          },
                          onTap: (value){
                            setState(() {
                              _showButtons=!_showButtons;
                            });
                          },
                          onCameraMoveStarted: (){
                            setState(() {
                              _showButtons=false;
                            });
                          },
                        ),
                        AnimatedOpacity(
                            opacity: _showButtons?1.0:0.0,
                            duration: Duration(milliseconds: 200),
                            child:Visibility(
                              visible: _showButtons,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        _customizedButton("50 m",50,1),

                                        _customizedButton("100 m",100,2),

                                        _customizedButton("500 m",500,3),

                                        _customizedButton("3 km",3000,4),

                                        _customizedButton("5 km",5000,5)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                        AnimatedOpacity(
                          opacity: _showButtons?1.0:0.0,
                          duration: Duration(milliseconds: 200),
                          child: Visibility(
                            visible: _showButtons,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      FloatingActionButton(
                                        heroTag: "btn1",
                                        onPressed: ()async{
                                          setState(() {
                                            _isLoading=true;
                                          });
                                          await fetchHostelLocations();
                                        },child: Image.asset("assets/hostel.png",width: 30,height: 30,color: Colors.white,),),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child: Center(
                                          child: Text("Hostels",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      FloatingActionButton(
                                        heroTag: "btn2",
                                        onPressed: ()async{
                                          setState(() {
                                            _isLoading=true;
                                          });
                                          await fetchFoodLocations();
                                        },child: Image.asset("assets/restaurant.png",width: 25,height: 25,color: Colors.white,),),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        width: 85,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child: Center(
                                          child: Text("Restaurants",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      FloatingActionButton(
                                        heroTag: "btn3",
                                        onPressed: ()async{
                                          setState(() {
                                            _isLoading=true;
                                          });
                                          await fetchStationaryLocations();
                                        },child: Image.asset("assets/stationary.png",width: 25,height: 25,color: Colors.white,),),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        width: 85,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child: Center(
                                          child: Text("Stationary",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      FloatingActionButton(
                                        heroTag: "btn4",
                                        onPressed: ()async{
                                          setState(() {
                                            _isLoading=true;
                                          });
                                          await fetchPharmacyLocations();
                                        },child: Image.asset("assets/medical-equipment.png",width: 25,height: 25,color: Colors.white,),),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        width: 85,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child: Center(
                                          child: Text("Medicine",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        _isLoading?LinearProgressIndicator(color: Colors.blueAccent,):Container()
                      ],
                    );
                  },
                )
            ),

            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: ()async {
                setState(() {
                  _state=0;
                  range=40;
                  _isLoading=true;
                });
                await getLocatiom();

              },
            ),
          );
        }
        return Container();
      }
    );
  }
}