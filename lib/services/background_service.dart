
  // ================================= BACKGROUND SERVICE ==================================
/*
  void startServiceInPlatform({@required String contentTitle, @required String contentText}) async {
    if(Platform.isAndroid){
      var parameters = {"contentTitle":contentTitle, "contentText": contentText};
      var me
      hodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService", Map.from(parameters));
    }
  }

  void stopServiceInPlatform() async {
    if(Platform.isAndroid){
      var methodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("stopService");
    }
  }
*/


