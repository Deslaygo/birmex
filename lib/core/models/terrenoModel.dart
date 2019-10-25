class Terreno{
  //propiedades
  String id;
  String titulo;
  String precio;
  String descripcion;
  String ubicacion;
  String medidas;
  String imagen;

  //constructor
  Terreno({this.id,this.titulo,this.precio,this.descripcion,this.ubicacion,this.medidas,this.imagen});

  //mapeo a json
  Terreno.fromMap(Map snapshot, String id):
  id = id  ?? '',
  titulo = snapshot['titulo'] ?? '',
  precio = snapshot['precio'] ?? '',
  descripcion = snapshot['descripcion'] ?? '',
  ubicacion = snapshot['ubicacion'] ?? '',
  medidas = snapshot['medidas'] ?? '',
  imagen = snapshot['imagen'] ?? '';

  //retorna en formato json
  toJson(){
    return {
      "titulo":titulo,
      "precio": precio,
      "descripcion": descripcion,
      "ubicacion": ubicacion,
      "medidas": medidas,
      "imagen": imagen,
    };
  }
}