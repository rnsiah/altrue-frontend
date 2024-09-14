import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_statistics_model.dart';

class AltrueStatisticsRepository{
  NonAuthenticatedApiProvider apiProvider = NonAuthenticatedApiProvider();

  Future<AltrueStatistics> getStatistics()async {
    final response  = await apiProvider.get('api/altruestatistics/');
    print(response);
    AltrueStatistics stats =  AltrueStatistics.fromJson(response);
    print(stats);
    return stats;
  }

  Future<List<AltrueAction>> getPromotedActions()async{
    List<AltrueAction> actions =[];
    final responses = await apiProvider.get('api/promoted-actions');
    for(var response in responses){
      actions.add(AltrueAction.fromJson(response));
    }
    return actions;
    
  }

}