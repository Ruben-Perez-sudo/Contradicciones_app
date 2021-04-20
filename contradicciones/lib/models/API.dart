
class Usuarios{
  String Usuario;
  String Contrasena;

  static Usuarios fromJson (Map <String,dynamic> json){
    Usuarios usuario = Usuarios();
    usuario.Usuario = json["Nom"];
    usuario.Contrasena = json["Contrasena"];
    return usuario;
  }
}

class Mensajes {
  String posts;

static Mensajes fromJson (Map <String,dynamic>json) {
  Mensajes mensaje = Mensajes();
  mensaje.posts = json["posts"];
  return mensaje;
} 
}