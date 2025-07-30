import 'package:geo_map_finder/models/address_model.dart';
import 'package:geo_map_finder/networks/naver_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'NaverRepository search test',
    // 통신은 비동기니까 테스트 할 함수에 async 달아주기!
    () async {
      NaverRepository naverRepository = NaverRepository();
      List<Address>? results = await naverRepository.search('양꼬치');
      expect(results != null, true);
      expect(results!.isNotEmpty, true);
      // 출력도 한번 해보기!
      for (var address in results) {
        print(address.toJson());
      }
    },
  );
}
