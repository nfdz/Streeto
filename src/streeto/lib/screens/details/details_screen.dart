import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:streeto/common/widgets/cached_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';
import 'package:streeto/common/format_helper.dart';
import 'package:streeto/common/texts/details_texts.dart';
import 'package:streeto/common/widgets/alert_content.dart';
import 'package:streeto/common/widgets/loading_bounce.dart';
import 'package:streeto/model/location_suggestion.dart';
import 'package:streeto/screens/details/bloc/details_bloc.dart';
import 'package:streeto/screens/details/bloc/details_event.dart';
import 'package:streeto/screens/details/bloc/details_state.dart';

final Logger _logger = Logger("DetailsScreen");

class DetailsScreen extends StatefulWidget {
  static const String route = "details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsBloc _bloc;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _bloc = DetailsBloc();
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
      LocationSuggestion location = ModalRoute.of(context).settings.arguments;
      if (location == null) {
        _logger.severe("Place screen initialized with NULL location");
        Navigator.pop(context);
      } else {
        // Determine map resolution depending screen
        final shortestSide = MediaQuery.of(context).size.shortestSide;
        double mapWidth = shortestSide;
        double mapHeight = shortestSide;
        _bloc.dispatch(DetailsEvent.loadDetails(location, mapWidth, mapHeight));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(DetailsTexts.title(context), style: kHeaderTextStyle),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, DetailsState state) {
          _logger.fine(state);
          final widgetBld = WidgetBuilder(context, _bloc);
          state.accept(widgetBld);
          return widgetBld.widget;
        },
      ),
    );
  }
}

class WidgetBuilder extends DetailsStateVisitor {
  final BuildContext _context;
  final DetailsBloc _bloc;
  Widget widget;

  WidgetBuilder(this._context, this._bloc);

  @override
  void visitDetails(DetailsContent content) {
    widget = ResponsiveDetails(
      content,
      onMapPressed: () {
        _bloc.dispatch(DetailsEvent.openNavigation());
      },
      onFavoritePressed: () {
        _bloc.dispatch(content.isFavorite ? DetailsEvent.removeFavorite() : DetailsEvent.addFavorite());
      },
    );
  }

  @override
  void visitLoadError() {
    widget = AlertContent(
      imageAsset: kErrorCircleImageAsset,
      message: DetailsTexts.loadError(_context),
      btnText: DetailsTexts.loadRetry(_context),
      onPressed: () => _bloc.dispatch(DetailsEvent.retryLoadDetails()),
    );
  }

  @override
  void visitLoading() {
    widget = Center(child: LoadingBounce());
  }
}

class ResponsiveDetails extends StatelessWidget {
  final VoidCallback onMapPressed;
  final VoidCallback onFavoritePressed;
  final DetailsContent content;
  ResponsiveDetails(
    this.content, {
    this.onMapPressed,
    this.onFavoritePressed,
  });
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final List<Widget> children = [
          Expanded(child: LocationMapImage(content.mapImageUrl, onMapPressed)),
          Expanded(child: DetailsColumn(content, onFavoritePressed)),
        ];
        return orientation == Orientation.portrait ? Column(children: children) : Row(children: children);
      },
    );
  }
}

class LocationMapImage extends StatelessWidget {
  final VoidCallback onPressed;
  final String mapImageUrl;
  LocationMapImage(this.mapImageUrl, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: FadeInCachedImage(
        width: double.infinity,
        height: double.infinity,
        image: mapImageUrl,
        placeholder: kTransparentImage,
        fit: BoxFit.contain,
      ),
    );
  }
}

class DetailsColumn extends StatelessWidget {
  final DetailsContent content;
  final VoidCallback onFavoritePressed;
  DetailsColumn(this.content, this.onFavoritePressed);
  @override
  Widget build(BuildContext context) {
    final boldStyle = kContentTextStyle.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: dimenDetailsTextContentPadding(getScreenType(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Use an independent column for text in order to keep baseline start fixed no matter the content of favorite button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Street and/or postal code could be empty depending on type of location (town, house, etc)
              if (content.details.street.isNotEmpty)
                Text(DetailsTexts.street(context), style: boldStyle),
              if (content.details.street.isNotEmpty)
                Text(content.details.street, style: kContentTextStyle, key: Key("details.street")),
              if (content.details.street.isNotEmpty)
                SizedBox(height: 6),
              if (content.details.postalCode.isNotEmpty)
                Text(DetailsTexts.postalCode(context), style: boldStyle),
              if (content.details.postalCode.isNotEmpty)
                Text(content.details.postalCode, style: kContentTextStyle, key: Key("details.postalCode")),
              if (content.details.postalCode.isNotEmpty)
                SizedBox(height: 6),
              Text(DetailsTexts.coordinates(context), style: boldStyle),
              Text("${content.details.lat}, ${content.details.lon}",
                  style: kContentTextStyle, key: Key("details.coordinates")),
              SizedBox(height: 6),
              Text(DetailsTexts.distance(context), style: boldStyle),
              Text(
                FormatHelper.formatDistance(content.distanceInMeters),
                style: kContentTextStyle,
                key: Key("details.distance"),
              ),
            ],
          ),
          SizedBox(height: 6),
          OutlineButton(
            key: Key("details.favorite_btn"),
            child: Text(
              content.isFavorite ? DetailsTexts.favoriteRemove(context) : DetailsTexts.favoriteAdd(context),
              key: Key("details.favorite_btn.text"),
            ),
            onPressed: onFavoritePressed,
          )
        ],
      ),
    );
  }
}
