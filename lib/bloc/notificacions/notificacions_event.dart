part of 'notificacions_bloc.dart';

sealed class NotificacionsEvent extends Equatable {
  const NotificacionsEvent();

  @override
  List<Object> get props => [];
}

class NotificacionStatusChanged extends NotificacionsEvent {
  final AuthorizationStatus status;
  const NotificacionStatusChanged(this.status);
}
