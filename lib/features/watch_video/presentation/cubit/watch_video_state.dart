part of 'watch_video_cubit.dart';

abstract class WatchVideoState extends Equatable {
  const WatchVideoState();
}

class WatchVideoInitial extends WatchVideoState {
  @override
  List<Object> get props => [];
}

class WatchVideoLoading extends WatchVideoState {
  @override
  List<Object> get props => [];
}

class WatchVideoLoaded extends WatchVideoState {
  @override
  List<Object> get props => [];
}
class WatchVideoError extends WatchVideoState {
  final String failure;

  const WatchVideoError({required this.failure});
  @override
  List<Object> get props => [failure];
}
