import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:graphql/client.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> setupGraphQLServiceLocator() async {
  getIt.registerLazySingleton<GraphQLClient>(() {
    final link = HttpLink(AppConfig.graphqlUrl);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  });

  getIt.registerLazySingleton<DarkoffQLService>(
    () => DarkoffQLService(
      client: getIt<GraphQLClient>(),
      logger: getIt<Logger>(),
    ),
  );
}
