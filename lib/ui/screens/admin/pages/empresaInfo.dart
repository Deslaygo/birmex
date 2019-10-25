import 'package:custom_chewie/custom_chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class EmpresaInfoPage extends StatefulWidget {
  EmpresaInfoPage({Key key}) : super(key: key);

  _EmpresaInfoPageState createState() => _EmpresaInfoPageState();
}

class _EmpresaInfoPageState extends State<EmpresaInfoPage> {
  //controlador del video
  VideoPlayerController _videoController;

  //inicializar el widget
  @override
  void initState() { 
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/birmex-875be.appspot.com/o/Video%20de%20publicidad%201.mp4?alt=media&token=24c69dd4-4716-4ae8-9767-947a2230da71')..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    //inicializar el video 
  }
  //Método de dispose para el widget
  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Image.asset("assets/icons/birmex.png"),
            ),
            Center(
              child: Text("Datos de contacto", style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,1.0),
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),),
            ),
            Center(
              child: Text("Tel: 2231057622", style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),),
            ),
            Center(
              child: Text("Tel: 2231064891", style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),),
            ),
            Center(
              child: Text("Tel: 2491495923", style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),),
            ),
            Center(
              child: Text("Dir: Av. Morelos Sur No. 215. Tepeaca,Puebla", 
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,0.9),
              
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                
              ),),
            ),
             Center(
              child: Text("Video", style: TextStyle(
                color: Color.fromRGBO(25, 42, 86,1.0),
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),),
            ),
            //video de publicidad
            Center(
              child:_videoController.value.initialized
              ?  new Chewie(
                _videoController,
                aspectRatio: 3 / 2,
                  autoPlay: false,
                  looping: true,
              )
              : Container(
                height: 150.0,
                padding: EdgeInsets.only(top: 20.0),
                child: Center(child:SpinKitFadingCube(color: Color.fromRGBO(25, 42, 86,1.0),)),
              ),
            ),
           
          ],
        ),
      ),
      
    );
  }
}