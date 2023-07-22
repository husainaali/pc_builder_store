import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder_store/grid_view_page.dart';
import 'package:pc_builder_store/photo_viewer_slider.dart';

import 'cart_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 181, 161, 103),
        title: Text(title),
      ),
      drawer: MediaQuery.of(context).size.width < 1040
          ? Drawer(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle home item tap
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Cart'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Handle settings item tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    onTap: () {
                      // Handle about item tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('Login'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => LoginDialog(),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Builder(
        builder: (context) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 6,
                ),
                child: Visibility(
                  visible: MediaQuery.of(context).size.width > 1040,
                  child: Container(
                    color: const Color.fromARGB(255, 255, 227, 151),
                    child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home'),
                          onTap: () {
                            // Handle home item tap
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.shopping_cart),
                          title: const Text('Cart'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Settings'),
                          onTap: () {
                            // Handle settings item tap
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('About'),
                          onTap: () {
                            // Handle about item tap
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.login),
                          title: const Text('Login'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => LoginDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  children: [
                    const Text(
                      'Welcome to the PC Builder Store!',
                      style: TextStyle(fontSize: 24),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Choose according to your budget.',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                1.2,
                                        child: FutureBuilder<List<PhotoData>>(
                                          future: loadPhotosFromJson(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return const Text(
                                                    'Error loading photos');
                                              } else {
                                                return PhotoViewerSlider(
                                                  photos: snapshot.data!,
                                                );
                                              }
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Best Selling',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                2.2,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.2,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("photo1.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  width: double.infinity,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  child: const Text(
                                                    "630 BHD",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  width: double.infinity,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  child: const Text(
                                                    "photo.name",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
 const SizedBox(

                            height: 30.0,
                            
                            child: Text("All Products")),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: GridViewPage(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<PhotoData>> loadPhotosFromJson() async {
    String jsonPhotos = await rootBundle.loadString('datasource.json');

    List<dynamic> jsonData = json.decode(jsonPhotos);
    List<PhotoData> loadedPhotos = [];

    for (var item in jsonData) {
      loadedPhotos.add(PhotoData.fromJson(item));
    }

    return loadedPhotos;
  }
}

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isRegistering ? 'Register' : 'Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          if (_isRegistering) ...[
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'City'),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _isRegistering = !_isRegistering;
            });
          },
          child: Text(_isRegistering ? 'Back to Login' : 'Register'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform login or registration logic here
            // For now, simply close the dialog
            Navigator.of(context).pop();
          },
          child: Text(_isRegistering ? 'Register' : 'Login'),
        ),
      ],
    );
  }
}
