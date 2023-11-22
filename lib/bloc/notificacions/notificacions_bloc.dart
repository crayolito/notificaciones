import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification/domain/entities/push_message.dart';
import 'package:notification/firebase_options.dart';

part 'notificacions_event.dart';
part 'notificacions_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class NotificacionsBloc extends Bloc<NotificacionsEvent, NotificacionsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificacionsBloc() : super(const NotificacionsState()) {
    on<NotificacionStatusChanged>((event, emit) {
      emit(state.copyWith(status: event.status));
      _getFCMToken();
    });

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listene para notificaciones en Foreground
    _onForegroundMessage();
  }

  // NO TIENE ACCESO AL CONTEXT
  // STATIC QUIERE DECIR LO VA LLAMAR SIN TENER QUE INICIALIZAR LA CLASE O INSTANCIARLA
  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificacionStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final notificacion = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sendDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: message.notification!.android?.imageUrl ?? '');
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    add(NotificacionStatusChanged(settings.authorizationStatus));
  }
}
