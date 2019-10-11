class Terreno{
  //propiedades
  String id;
  String titulo;
  String descripcion;
  String ubicacion;
  String medidas;
  String imagen;

  //constructor
  Terreno({this.id,this.titulo,this.descripcion,this.ubicacion,this.medidas,this.imagen});

  //mapeo a json
  Terreno.fromMap(Map snapshot, String id):
  id = id  ?? '',
  titulo = snapshot['titulo'] ?? '',
  descripcion = snapshot['descripcion'] ?? '',
  ubicacion = snapshot['ubicacion'] ?? '',
  medidas = snapshot['medidas'] ?? '',
  imagen = snapshot['imagen'] ?? '';

  //retorna en formato json
  toJson(){
    return {
      "titulo":titulo,
      "descripcion": descripcion,
      "ubicacion": ubicacion,
      "medidas": medidas,
      "imagen": imagen,
    };
  }
}