
import 'package:flutter/material.dart';
import 'package:wbcc/services/LocalStorageService.dart';
import 'package:wbcc/services/chauffeur_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _controllerEmail = TextEditingController();

  String? errorMessage = "";

  

  LocalStorageService lStorage =LocalStorageService();

  @override
  void initState() {
    super.initState();
    
  }

 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
        
        body: SafeArea(
          child: Padding(
            
        padding: EdgeInsets.only(left: 20.0,right: 20.0), 
         
          child: Column(
            
            children: [
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
              SizedBox(height: 10),
              Image.asset(
          'assets/logo.png',
          width: double.infinity,
          height: 200,
          
        ),
        SizedBox(height: 20), 
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  icon: Icon(Icons.email),
                ),
              ),
             
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  
                  ElevatedButton(
                    onPressed: () {
                      ChauffeurService().fetchAndSaveChauffeurByEmail(context, _controllerEmail.text);
                     
                    },
                    child: Text('Log In'),
                  ),
                  
                ],
              ),
              SizedBox(height: 20),
              Text(
                "You don't have an account?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  LocalStorageService.clearData("chauffeur");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SignUp()),
                  // );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
