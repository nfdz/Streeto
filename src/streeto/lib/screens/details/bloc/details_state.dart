import 'package:meta/meta.dart';
import 'package:streeto/model/location_details.dart';

@immutable
abstract class DetailsState {
  static DetailsState loading() => Loading();
  static DetailsState detailsContent(
          LocationDetails details, double distanceInMeters, String mapImageUrl, bool isFavorite) =>
      DetailsContent(details, distanceInMeters, mapImageUrl, isFavorite);
  static DetailsState loadDetailsError() => LoadDetailsError();

  void accept(DetailsStateVisitor visitor);
}

class Loading extends DetailsState {
  @override
  void accept(DetailsStateVisitor visitor) => visitor.visitLoading();
}

class LoadDetailsError extends DetailsState {
  @override
  void accept(DetailsStateVisitor visitor) => visitor.visitLoadError();
}

class DetailsContent extends DetailsState {
  final LocationDetails details;
  final double distanceInMeters;
  final String mapImageUrl;
  final bool isFavorite;
  DetailsContent(this.details, this.distanceInMeters, this.mapImageUrl, this.isFavorite);

  @override
  void accept(DetailsStateVisitor visitor) => visitor.visitDetails(this);
}

// (visitor pattern)
abstract class DetailsStateVisitor {
  void visitLoading();
  void visitLoadError();
  void visitDetails(DetailsContent content);
}
