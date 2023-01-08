import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ATmega1());
}

class ATmega1 extends StatelessWidget {
  const ATmega1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseActivity(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirebaseActivity extends StatelessWidget {
  const FirebaseActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ATmega Flutter + Firebase Firestore Read Demo"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) =>
              GridView.count(
            crossAxisCount: 2,
            children: snap.data != null
                ? List.generate(
                    snap.data!.docs.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            snap.data!.docs[index]['image'],
                          ),
                        ),
                      ),
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            snap.data!.docs[index]['title'],
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : [
                    Shimmer.fromColors(
                      child: SizedBox(),
                      baseColor: Colors.blue.shade700,
                      highlightColor: Colors.red,
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
