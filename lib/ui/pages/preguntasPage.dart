import 'package:birmex/ui/widgets/preguntas.dart';
import 'package:flutter/material.dart';

class PreguntasPage extends StatefulWidget {
  Preguntas _preguntas = Preguntas();

  @override
  _PreguntasPageState createState() => _PreguntasPageState();
}

class _PreguntasPageState extends State<PreguntasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 42, 86,1.0),
        title: Image.asset("assets/icons/birmex.png"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Card(
                elevation: 4.0,
                child: ExpansionTile(
                  title: Text(widget._preguntas.pregunta1,style: TextStyle(
                    color: Color.fromRGBO(25, 42, 86,1.0),
                    fontSize: 20.0,
                  ),),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child:  Text("El Lorem Ipsum fue concebido como un texto de relleno, formateado de una cierta manera para permitir la presentación de elementos gráficos en documentos, sin necesidad de una copia formal. El uso de Lorem Ipsum permite a los diseñadores reunir los diseños y la forma del contenido antes de que el contenido se haya creado, dando al diseño y al proceso de producción más libertad.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color.fromRGBO(25, 42, 86,1.0),
                      fontSize: 20.0,
                    ),),
                    ),
                        
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}