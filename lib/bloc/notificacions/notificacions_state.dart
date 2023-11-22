part of 'notificacions_bloc.dart';

class NotificacionsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notificacions;

  const NotificacionsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notificacions = const [],
  });

  NotificacionsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notificacions,
  }) {
    return NotificacionsState(
      status: status ?? this.status,
      notificacions: notificacions ?? this.notificacions,
    );
  }

  @override
  List<Object> get props => [status, notificacions];
}
