// import 'dart:developer';

// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }


// class _MainScreenState extends State<MainScreen> {
//   late InAppWebViewController inAppWebViewController;

//   InAppLocalhostServer localhostServer = InAppLocalhostServer(
//       directoryIndex: 'index.html', documentRoot: 'assets', shared: true);

//   @override
//   void initState() {
//     localhostServer.start();
//     getDevice();
//     runCamera();
//     WidgetsFlutterBinding.ensureInitialized();

//     super.initState();
//   }

//   getDevice() async {
//     final session = await AudioSession.instance;
//     List<AudioDevice> audioDevices = (await session.getDevices()).toList();
//     log(audioDevices.toString());
//   }

// // [AudioDevice(id:9,name:Nokia G11,isInput:false,isOutput:true,type:AudioDeviceType.telephony),
// //  AudioDevice(id:2,name:Nokia G11,isInput:false,isOutput:true,type:AudioDeviceType.builtInEarpiece), 
// //  AudioDevice(id:3,name:Nokia G11,isInput:false,isOutput:true,type:AudioDeviceType.builtInSpeaker), 
// //  AudioDevice(id:14,name:Nokia G11,isInput:true,isOutput:false,type:AudioDeviceType.builtInMic),
// //   AudioDevice(id:15,name:Nokia G11,isInput:true,isOutput:false,type:AudioDeviceType.builtInMic),
// //    AudioDevice(id:21,name:Nokia G11,isInput:true,isOutput:false,type:AudioDeviceType.remoteSubmix),
// //     AudioDevice(id:16,name:Nokia G11,isInput:true,isOutput:false,type:AudioDeviceType.telephony),
// //      AudioDevice(id:19,name:Nokia G11,isInput:true,isOutput:false,type:AudioDeviceType.fmTuner)]
//   @override
//   void dispose() {
//     localhostServer.close();
//     super.dispose();
//   }

//   runCamera() async {
//     await Permission.camera.request();
//     await Permission.microphone.request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.only(top: 30.0),
//             child: InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: Uri.parse(
//                   'http://localhost:8080/#/',
//                 ),
//               ),
//               initialOptions: InAppWebViewGroupOptions(
//                 android: AndroidInAppWebViewOptions(
//                   useHybridComposition: true,
//                   useShouldInterceptRequest: true,
//                 ),
//                 crossPlatform: InAppWebViewOptions(
//                   javaScriptCanOpenWindowsAutomatically: true,
//                   javaScriptEnabled: true,
//                   mediaPlaybackRequiresUserGesture: false,
//                   preferredContentMode: UserPreferredContentMode.MOBILE,
//                 ),
//               ),
//               androidOnPermissionRequest: (InAppWebViewController controller,
//                   String origin, List<String> resources) async {
//                 log('Саалламамламлмаллалмалм');

//                 return PermissionRequestResponse(
//                   resources: resources,
//                   action: PermissionRequestResponseAction.GRANT,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
