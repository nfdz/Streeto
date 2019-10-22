import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';
import 'package:streeto/common/texts/global_texts.dart';
import 'package:streeto/common/texts/main_texts.dart';
import 'package:streeto/common/widgets/alert_content.dart';
import 'package:streeto/common/widgets/loading_bounce.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/persistences/preferences/preferences.dart';
import 'package:streeto/screens/details/details_screen.dart';
import 'package:streeto/screens/favorites/favorites_screen.dart';
import 'package:streeto/screens/main/bloc/main_bloc.dart';
import 'package:streeto/screens/main/bloc/main_event.dart';
import 'package:streeto/screens/main/bloc/main_state.dart';
import 'package:streeto/screens/main/location_entry.dart';
import 'package:streeto/screens/main/search_box.dart';

final Logger _logger = Logger("MainScreen");

class MainScreen extends StatefulWidget {
  static const String route = "main";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MainBloc();
    _bloc.dispatch(MainEvent.checkLocation());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalTexts.appName(context), style: kHeaderTextStyle),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<SuggestionsSort>(
            onSelected: (sort) => _bloc.dispatch(MainEvent.sortSuggestions(sort)),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<SuggestionsSort>(
                  value: SuggestionsSort.BY_NAME,
                  child: Text(MainTexts.sortName(context)),
                ),
                PopupMenuItem<SuggestionsSort>(
                  value: SuggestionsSort.BY_DISTANCE,
                  child: Text(MainTexts.sortDistance(context)),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, MainState state) {
          _logger.fine(state);
          final widgetBld = WidgetBuilder(context, _bloc);
          state.accept(widgetBld);
          return widgetBld.widget;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: Key("main.favorites_fab"),
        icon: Icon(Icons.favorite),
        label: Text(MainTexts.favorites(context)),
        backgroundColor: kAccentColor,
        onPressed: () => Navigator.pushNamed(context, FavoritesScreen.route),
      ),
    );
  }
}

class WidgetBuilder extends MainStateVisitor {
  final BuildContext _context;
  final MainBloc _bloc;
  Widget widget;

  WidgetBuilder(this._context, this._bloc);

  @override
  void visitSearchError() {
    widget = SearchContent(
      bloc: _bloc,
      child: AlertContent(imageAsset: kErrorCircleImageAsset, message: MainTexts.error(_context)),
    );
  }

  @override
  void visitInitial() {
    widget = SearchContent(bloc: _bloc, child: Container());
  }

  @override
  void visitLoading() {
    widget = SearchContent(bloc: _bloc, child: LoadingBounce());
  }

  @override
  void visitLocationError() {
    widget = AlertContent(
      imageAsset: kMapLocationImageAsset,
      message: MainTexts.locationError(_context),
      btnText: MainTexts.locationRetryBtn(_context),
      onPressed: () => _bloc.dispatch(MainEvent.checkLocation()),
    );
  }

  @override
  void visitPermissionsNeeded() {
    widget = AlertContent(
      imageAsset: kPolicemanImageAsset,
      message: MainTexts.permissionsNeeded(_context),
      btnText: MainTexts.permissionsBtn(_context),
      onPressed: () => _bloc.dispatch(MainEvent.requestPermissions()),
      auxBtnText: MainTexts.permissionsBtnAux(_context),
      onPressedAux: () => _bloc.dispatch(MainEvent.checkSystemSettings()),
    );
  }

  @override
  void visitSearchResult(List<LocationSuggestion> locations) {
    ScreenType screen = getScreenType(_context);
    final entryPadding = dimenMainLocationEntryPadding(screen);
    widget = SearchContent(
      bloc: _bloc,
      child: locations?.isNotEmpty == true
          ? Scrollbar(
              child: ListView.builder(
                key: Key("main.list_view"),
                padding: dimenMainListViewPadding(screen),
                itemCount: locations.length,
                itemBuilder: (context, position) {
                  final location = locations[position];
                  return LocationEntry(
                    location: location,
                    padding: entryPadding,
                    onPressed: () {
                      Navigator.pushNamed(context, DetailsScreen.route, arguments: location);
                    },
                  );
                },
              ),
            )
          : AlertContent(message: MainTexts.emptyResult(_context), imageAsset: kEmptyBoxImageAsset),
    );
  }
}

class SearchContent extends StatelessWidget {
  final Widget child;
  final MainBloc bloc;
  SearchContent({@required this.bloc, @required this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SearchBox(onChanged: (query) => bloc.dispatch(MainEvent.searchLocations(query))),
        Expanded(child: this.child),
      ],
    );
  }
}
