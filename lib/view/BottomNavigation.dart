import 'package:flutter/material.dart';
import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/view/SignIn.dart';
import 'package:wbcc/view/home.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;





  Map<String, dynamic>? mapData;
 
@override
  void initState() {
    super.initState();
    
    
  }

  final List<Widget> _pages = [
     HomePage(),
    // History(),
    // Informations(),
    // Profile(),
  ];

  final List<String> _pagesTitle = [
   
    "Home",
    "Suivi",
    "Nettoyage", 
    "Carburant",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text(_pagesTitle[_currentIndex],style: TextStyle( fontWeight: FontWeight.bold),),
      automaticallyImplyLeading: false,
      centerTitle: true, 
      backgroundColor: Colors.red,
      
        actions: <Widget>[
          
          
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              
            
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Deconection'),
                    content: Text('Confirmer la deconection'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          LocalStorageService.clearData("chauffeur");
                          LocalStorageService.clearData("vehicule");

              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );


            },
          ),
          ],) ,
      
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_point, size: 27),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services, size: 27),
            label: 'Informations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station,size: 27),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
