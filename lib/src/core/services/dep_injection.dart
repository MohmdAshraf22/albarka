import 'package:get_it/get_it.dart';

import '../../modules/authenticaion/data_layer/data_sources/auth_remote_data_sources.dart';
import '../../modules/authenticaion/data_layer/repositories/auth_repository.dart';
import '../../modules/authenticaion/domain_layer/repsitories/base_auth_repository.dart';
import '../../modules/delivery/data_layer/data_sources/order_remote_data_sources.dart';
import '../../modules/delivery/data_layer/repositories/order_repository.dart';
import '../../modules/delivery/domain_layer/repsitories/base_order_repository.dart';
import '../../modules/menu/data_layer/data_sources/menu_remote_data_source.dart';
import '../../modules/menu/data_layer/repositories/menu_repository.dart';
import '../../modules/menu/domain_layer/repsitories/base_menu_repository.dart';



final sl = GetIt.instance;

class ServiceLocator {
  void init() async {
    /// menu
    BaseMenuRemoteDataSource baseMenuRemoteDataSource = MenuRemoteDataSource();
    sl.registerLazySingleton(() => baseMenuRemoteDataSource);

    BaseMenuRepository baseMenuRepository = MenuRepository(sl());
    sl.registerLazySingleton(() => baseMenuRepository);

    /// auth
    BaseAuthRemoteDataSource baseAuthRemoteDataSource = AuthRemoteDataSource();
    sl.registerLazySingleton(() => baseAuthRemoteDataSource);

    BaseAuthRepository baseAuthRepository = AuthRepository(sl());
    sl.registerLazySingleton(() => baseAuthRepository);

    /// user
    BaseOrderRemoteDataSource baseOrderRemoteDataSource = OrderRemoteDataSource();
    sl.registerLazySingleton(() => baseOrderRemoteDataSource);

    BaseOrderRepository baseOrderRepository = OrderRepository(sl());
    sl.registerLazySingleton(() => baseOrderRepository);

  }
}

