import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text("Fetch Data"),
       ),
       body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.active) {
             if (snapshot.hasData) {
               return ListView.builder(
                 itemCount: snapshot.data!.docs.length,
                 itemBuilder: (context, index) {
                   return ListTile(
                     leading: Text("${index + 1}"),
                     title: Text("${snapshot.data!.docs[index].data()["Title"]}"),
                     subtitle: Text("${snapshot.data!.docs[index]['Desc']}"),
                   );
                 },
               );
             } else if (snapshot.hasError) {
               return Center(child: Text("${snapshot.error.toString()}"));
             } else {
               return Center(child: Text("Data not found"));
             }
           } else {
             return const Center(child: CircularProgressIndicator());
             // Use const for a widget if the widget itself is immutable
           }
         },
       )

    );
  }
}
