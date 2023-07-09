import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDrawerOpen = false;

  void _handleDrawerStateChanged(bool isOpen) {
    setState(() {
      _isDrawerOpen = isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MediaQuery.of(context).size.width < 1040
          ? Drawer(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      // Handle home item tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Cart'),
                    onTap: () {
                      // Handle cart item tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle settings item tap
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      // Handle about item tap
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Builder(
        
        builder: (context) => Center(
          child:Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              
              Expanded(
              
                flex: 1,
                child:

                Visibility(
                             
                    visible: MediaQuery.of(context).size.width > 1040,
                    child: Container(
                      color: Colors.amber,
                             
                      child: ListView(
                            children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      // Handle home item tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Cart'),
                    onTap: () {
                      // Handle cart item tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle settings item tap
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      // Handle about item tap
                    },
                  ),
                            ],
                      ),
                    ),
                  ),
               
              
              ),

              Expanded(
                flex: 6,
                child:  Column(
                    children: [
                      Text(
                            'Welcome to the PC Builder Store!',
                            style: TextStyle(fontSize: 24),
                      ),

                    ],
                  ),
                ),
            
            ],
          ),
          

        ),
      ),
    );
  }
}
