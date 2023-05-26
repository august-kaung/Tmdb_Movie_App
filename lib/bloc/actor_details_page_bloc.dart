import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';

import '../data/apply/tmdb_apply.dart';
import '../data/apply/tmdb_apply_impl.dart';

class ActorDetailsBLoc extends ChangeNotifier {
  final TMDBApply _tmdbApply = TMDBApplyImpl();

  ActorDetailsVO? _actorDetailsVO;
  bool _dispose = false;

  ActorDetailsVO? get getActorDetailsVO => _actorDetailsVO;

  ActorDetailsBLoc(int actorID) {
    ///Fetch Actor Details Info from Network
    _tmdbApply.getActorDetailsFromNetwork(actorID);

    ///Listen Actor Details From Database
    _tmdbApply.getActorDetailsFromDataBase(actorID).listen((event) {
      if (event != null) {
        _actorDetailsVO = event;
      } else {
        _actorDetailsVO = null;
      }
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}
