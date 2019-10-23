import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/common/dialogs/navigation_provider.dart';
import 'package:streeto/common/texts/global_texts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';
import 'package:streeto/common/texts/favorites_text.dart';
import 'package:streeto/model/location_details.dart';
import 'package:streeto/screens/favorites/bloc/favorites_bloc.dart';
import 'package:streeto/screens/favorites/bloc/favorites_event.dart';
import 'package:streeto/screens/favorites/bloc/favorites_state.dart';

final Logger _logger = Logger("FavoritesScreen");

class FavoritesScreen extends StatefulWidget {
  static const String route = "favorites";

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesBloc _bloc;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _bloc = FavoritesBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      _isInitialized = true;
      // Determine map resolution depending screen
      final shortestSide = MediaQuery.of(context).size.shortestSide;
      double mapWidth = shortestSide;
      double mapHeight = shortestSide;
      _bloc.dispatch(FavoritesEvent.loadFavorites(mapWidth, mapHeight));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(FavoritesTexts.title(context), style: kHeaderTextStyle),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, FavoritesState state) {
          _logger.fine(state);
          return state is FavoritesContent ? ResponsiveContent(state, _bloc) : Container();
        },
      ),
    );
  }
}

class ResponsiveContent extends StatelessWidget {
  final FavoritesContent _state;
  final FavoritesBloc _bloc;
  ResponsiveContent(this._state, this._bloc);

  @override
  Widget build(BuildContext context) {
    final screen = getScreenType(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        final List<Widget> children = [
          if (_state.mapImageUrl?.isNotEmpty == true)
            Expanded(
              child: FavoritesMapImage(
                _state.mapImageUrl,
                onMapPressed: _state.selected != null
                    ? () async {
                        if (_state.navigationEnabled == true) {
                          _bloc.dispatch(FavoritesEvent.openNavigation());
                        } else {
                          final nav = await askNavigationDialog(context);
                          if (nav != null) {
                            _bloc.dispatch(FavoritesEvent.setNavigation(nav));
                            _bloc.dispatch(FavoritesEvent.openNavigation());
                          }
                        }
                      }
                    : null,
              ),
            ),
          Expanded(
              child: Scrollbar(
            child: ListView.builder(
              key: Key("favorites.list_view"),
              padding: dimenFavsListViewPadding(screen),
              itemCount: _state.locations.length,
              itemBuilder: (context, position) {
                final location = _state.locations[position];
                final isSelected = _state.selected?.locationId == location.locationId;
                return FavoriteEntry(
                  location,
                  isSelected,
                  dimenFavsLocationEntryPadding(screen),
                  onPressed: () => _bloc.dispatch(FavoritesEvent.selectLocation(isSelected ? null : location)),
                );
              },
            ),
          )),
        ];
        return orientation == Orientation.portrait ? Column(children: children) : Row(children: children);
      },
    );
  }
}

class FavoritesMapImage extends StatelessWidget {
  final VoidCallback onMapPressed;
  final String mapImageUrl;
  FavoritesMapImage(this.mapImageUrl, {this.onMapPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: dimenMapPadding(getScreenType(context)),
      child: GestureDetector(
        onTap: onMapPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FadeInImage.memoryNetwork(
                image: mapImageUrl,
                fadeInDuration: kFadeImageDuration,
                placeholder: kTransparentImage,
                fit: BoxFit.contain,
              ),
            ),
            if (onMapPressed != null) Text(GlobalTexts.mapClick(context), style: kSmallBoldTextStyle),
          ],
        ),
      ),
    );
  }
}

class FavoriteEntry extends StatelessWidget {
  final LocationDetails location;
  final VoidCallback onPressed;
  final bool isSelected;
  final EdgeInsets padding;
  FavoriteEntry(this.location, this.isSelected, this.padding, {this.onPressed}) : super(key: Key(location.locationId));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        color: isSelected ? kAccentColor : null,
        child: ListTile(
          title: Text("${location.label}", key: Key("favorites.location_entry.label")),
          subtitle: Text("${location.lat}, ${location.lon}"),
          onTap: onPressed,
        ),
      ),
    );
  }
}
