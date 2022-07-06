import 'package:hive/hive.dart';
import 'package:offline_persistancy_hive/models/picture_model.dart';

class HiveService {
  isImageExists() async {
    final openBox = await Hive.openBox<PictureModel>('pictureHive');
    int length = openBox.length;
    return length != 0;
  }

  Future<List<PictureModel>> getImageBoxes<PictureModel>() async {
    List<PictureModel> boxList = [];

    final openBox = await Hive.openBox<PictureModel>('pictureHive');
    int length = openBox.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i)!);
    }
    return boxList;
  }
}
