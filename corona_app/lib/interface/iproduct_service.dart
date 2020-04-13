import 'dart:io';

//TODO: Integrate it with the Product service
class IProductService {
  Future<int> UploadData(Map uploadData) async {}
  Future<bool> UploadPic(String baseUrl, String name, File pic) async {}
  Future<List<Map>> DownloadProduct() async {}
}
