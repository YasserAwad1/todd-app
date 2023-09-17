import 'package:get_it/get_it.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';



final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<LocalRepo>(() => LocalRepo());
}
