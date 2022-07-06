import 'package:flutter/material.dart';
import 'package:offline_persistancy_hive/models/picture_model.dart';
import 'package:hive_flutter/hive_flutter.dart';




const String picHiveModel = 'pictureHive';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PictureModel? pictureModel;
  Box<PictureModel>? pictureBox;

  @override
  void initState() {
    super.initState();
    pictureBox = Hive.box<PictureModel>(picHiveModel);
    pictureModel = PictureModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Type Adaptor")),
      body: FutureBuilder(
          future: pictureModel!.getPictureData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PictureModel>> snapshot) {
            if (snapshot.hasData) {
              return pictureHiveBoxListener();
            }
            return const Center(
              child:  SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color:Colors.blueGrey)),
            );
          }),
    );
  }

  Widget pictureHiveBoxListener() {
    return ValueListenableBuilder(
        valueListenable: Hive.box<PictureModel>(picHiveModel).listenable(),
        builder: (context, Box<PictureModel> box, _) {
          Map<dynamic, dynamic> mapData = box.toMap();

          List keys = mapData.values.toList();

          return ListView.separated(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(keys[index].title),
                subtitle: Text(keys[index].id.toString()),
                leading: Image.network(keys[index].thumbnailUrl),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(),
              );
            },
          );
        });
  }
}
