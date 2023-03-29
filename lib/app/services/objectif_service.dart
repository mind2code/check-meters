import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ObjectifService extends GetxService {
  final box = GetStorage();

  String objectifsKey = "objectifs";
  String objectifsR = "objectifs_realises";

  RxInt total = 0.obs;
  RxInt realises = 0.obs;

  init() async {
    getData();
    return this;
  }

  setObj(int _data) {
    box.write(objectifsKey, 100);
  }

  setObjR(int _data) {
    box.write(objectifsR, _data);
    getData();
  }


  getData() async {
    final res = await box.read(objectifsKey);
    total.value = res == null ? 0 : res;
  }

  Future<int> getObjR() async {
    final res = await box.read(objectifsR);
    realises.value = res == null ? 0 : res;
    print("realise =========> ${realises.value}");
    return realises.value;
  }

  remove() {
    box.remove(objectifsKey);
  }

  removeObj() {
    box.remove(objectifsR);
  }
}
