import 'package:forge/application/services/health_connect_client_base.dart';

import 'health_connect_client_stub.dart'
    if (dart.library.io) 'health_connect_client_io.dart'
    as impl;

export 'health_connect_client_base.dart';

HealthConnectClient createHealthConnectClient() => impl.createPlatformClient();
