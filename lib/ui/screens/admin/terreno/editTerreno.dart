import 'dart:io';
import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/core/viewModels/crudTerrenoModel.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//variables para la imagen
File image;
String fileName;

class EditTerreno extends StatefulWidget {
  //Instancia del objeto de terreno
  final Terreno terreno;
  //constructor
  EditTerreno({this.terreno});
  _EditTerrenoState createState() => _EditTerrenoState();
}

class _EditTerrenoState extends State<EditTerreno> {
  //Global key para el formulario
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  //controladores de las cajas de texto
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _ubicacionController = TextEditingController();
  TextEditingController _medidasController = TextEditingController();

  //para la imagen
  String terrenoImage;
  //Método para elegir la camara
  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    //Si la imagen no es nula que la tome
    if (img != null) {
      image = image;
      setState(() {});
    }
  }

  //Método para elegir imagen de la galeria
  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    //validación en caso de elegir una imagen
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  //Metodo para inicializar los controles
  @override
  void initState() { 
    super.initState();
    _tituloController.text = widget.terreno.titulo;
    _precioController.text = widget.terreno.precio;
    _ubicacionController.text = widget.terreno.ubicacion;
    _medidasController.text = widget.terreno.medidas;
    _descripcionController.text = widget.terreno.descripcion;
  }

  @override
  Widget build(BuildContext context) {
    //variable para el manejo de la db
    var terrenoProvider = Provider.of<CrudTerrenoModel>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
          child: Text("Editar propiedad"),
        ),
        backgroundColor: Color.fromRGBO(25, 42, 86, 1.0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.white,
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 30.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      padding: new EdgeInsets.all(5.0),
                      child: image == null
                          ? Image.network(widget.terreno.imagen, fit: BoxFit.cover)
                          : Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  //Para llamar imagen de la galeria o capturarla de la camara
                  IconButton(
                    icon: new Icon(
                      Icons.add_a_photo,
                      color: Color.fromRGBO(25, 42, 86, 1.0),
                    ),
                    onPressed: pickerCam,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_to_photos,
                      color: Color.fromRGBO(25, 42, 86, 1.0),
                    ),
                    onPressed: pickerGallery,
                  ),
                ],
              ),
              //caja de texto del titulo
              Container(
                padding: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.title,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: _validateTitulo,
                            controller: _tituloController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Título",
                              focusColor: Color.fromRGBO(25, 42, 86, 1.0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
             //caja de texto de la descripción
              Container(
                padding: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: _validateDescripcion,
                            controller: _descripcionController,
                            maxLines: 3,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Descripción",
                              focusColor: Color.fromRGBO(25, 42, 86, 1.0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //caja de texto del precio
              Container(
                padding: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: _validatePrecio,
                            controller: _precioController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Precio",
                              focusColor: Color.fromRGBO(25, 42, 86, 1.0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
              //caja de texto de la ubicacion
              Container(
                padding: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: _validateUbicacion,
                            controller: _ubicacionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Ubicación",
                              focusColor: Color.fromRGBO(25, 42, 86, 1.0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
               //caja de texto de las medidas
               Container(
                padding: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: _validateMedidas,
                            controller: _medidasController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Medidas",
                              focusColor: Color.fromRGBO(25, 42, 86, 1.0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
              //Botón de guardar
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60.0,
                child:  FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Color.fromRGBO(243, 156, 18,1.0),
                
                onPressed: () async {
                  //Validar el estado del formulario
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if (image == null) {
                      _showDialogImageWarning(context);
                    }else{
                    
                  //obtengo el nombre a guardar en el archivo
                  var nameComplete = _tituloController.text;
                  var nameImageTrim = nameComplete.trim();
                  var nameImg = nameImageTrim.replaceAll(" ", "");
                  var now =
                      formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                  var fullImageName = '${nameImg}-$now' + '.jpg';

                  final StorageReference ref =
                      FirebaseStorage.instance.ref().child(fullImageName);

                  final StorageUploadTask task = ref.putFile(image);
                  print("Imagen subida");
                  final StorageTaskSnapshot downloadUrl =
                      (await task.onComplete);
                  final String urlImg =
                      (await downloadUrl.ref.getDownloadURL());
                  print('URL Is $urlImg');
                  //Se agregar a la bd
                  await terrenoProvider.updateTerreno(Terreno(
                    titulo: _tituloController.text,
                    precio: _precioController.text,
                    descripcion: _descripcionController.text,
                    ubicacion: _ubicacionController.text,
                    medidas: _medidasController.text,
                    imagen: urlImg,
                  ),widget.terreno.id);
                  print("Propiedad editada");
                    //eliminar imagen de la base de datos
                    String pathImage = widget.terreno.imagen.replaceAll(new 
                    RegExp(r'https://firebasestorage.googleapis.com/v0/b/birmex-875be.appspot.com/o/'), '').split('?')[0];
                    //se elimina de firebase
                    FirebaseStorage.instance.ref().child(pathImage).delete().then(
                      (_) => print("imagen eliminada"));
                  //limpiar
                  limpiarControles();
                  _showDialogSuccess(context);
                    }
                  }else{
                    setState(() {
                     _autoValidate = true; 
                    });
                  }
                },
                child: Text(
                  "Editar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              )
             
            ],
          ),
        ),
        ),
      ),
    );
  }
  //Método para limpiar la caja de texto y la imagen
  void limpiarControles(){
    _tituloController.text = "";
    _precioController.text = "";
    _descripcionController.text = "";
    _ubicacionController.text = "";
    _medidasController.text = "";
  }

  //Método para validar el titulo
  String _validateTitulo(String value){
    if (value.length == 0) {
      return "El título es obligatorio";
    } 
    return null;
  }
  //Método para validar el precio
  String _validatePrecio(String value){
    if (value.length == 0) {
      return "El precio es obligatorio";
    } 
    return null;
  }
  //Método para validar el descripción
  String _validateDescripcion(String value){
    if (value.length == 0) {
      return "La descripción es obligatoria";
    } 
    return null;
  }
  //Método para validar la ubicación
  String _validateUbicacion(String value){
    if (value.length == 0) {
      return "La ubicación es obligatoria";
    } 
    return null;
  }
  //Método para validar la medidas
  String _validateMedidas(String value){
    if (value.length == 0) {
      return "Las medidas son obligatorias";
    } 
    return null;
  }
  //Método que muestra el alert de datos guardados
  void _showDialogSuccess(context){
    Alert(
       context: context,
       title: "Los datos se han editado correctamente",
       image: Image.asset("assets/images/success.gif", fit: BoxFit.cover,),     
        buttons: [
        DialogButton(
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ], 
          ).show();
  }
  //Método para advertencia de imagen vacia
  void _showDialogImageWarning(context){
    Alert(
       context: context,
       title: "La imagen es obligatoria, favor de subir una imagen",
       image: Image.asset("assets/images/iconWarning.jpg", fit: BoxFit.cover,),     
        buttons: [
        DialogButton(
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ], 
          ).show();
  }

}
