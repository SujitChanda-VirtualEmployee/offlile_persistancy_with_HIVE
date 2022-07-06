

import 'package:hive/hive.dart';
import 'package:offline_persistancy_hive/services/base_api/api_url.dart';
import 'package:offline_persistancy_hive/services/hive_service.dart';

part 'picture_model.g.dart';



@HiveType(typeId: 1)
class PictureModel {
  PictureModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  @HiveField(0)
  int? albumId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? thumbnailUrl;

  APIService apiService =  APIService();
  HiveService hiveService =  HiveService();
  List<PictureModel> pictures = [];
  List<PictureModel> get pictureList => pictures;


  Future<List<PictureModel>> getPictureData() async {
    bool exists = await hiveService.isImageExists();
    if (exists) {
      pictures = await hiveService.getImageBoxes();
    } else {
      var result = await apiService.fetchImageData();

      (result as List).map((json) {
        PictureModel data = PictureModel(
          albumId: json["albumId"],
          id: json["id"],
          thumbnailUrl: json["thumbnailUrl"],
          title: json["title"],
          url: json["url"],
        );
        pictures.add(data);
      }).toList();
      await (List<PictureModel> items) async {
        final openBox = await Hive.openBox<PictureModel>('pictureHive');
        await openBox.clear();
        Hive.box<PictureModel>('pictureHive').addAll(items);
      }(pictures);
    }

    return pictures;
  }
}
