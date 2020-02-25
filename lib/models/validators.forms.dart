class Validators{

  static String nameValidator(String str){
    if (str.isEmpty || str.length < 2) {
      return "Insira seu nome completo";
    }else if (!str.contains(RegExp(r'^[a-zA-Z\s]+$'))) {
      return "Sem caracteres especiais";
    }else if(!str.contains(" ")){
      return 'Insira também o sobrenome';
    }else if(str.split(" ")[1].length < 2){
      return "Sobrenome muito curto";
    }
  }


  static String passValidator(String str) {
    if (str.isEmpty) {
      return "Repita a senha";
    } else if (str.length < 6) {
      return "No mínimo 6 dígitos";
    }
  }

  static String whatsValidator(String str) {
    if (str.isEmpty || str.length < 13) {
      return "Insira o WhatsApp";
    }
  }

  static String emailValidator(String str) {
    if (str.isEmpty || !str.contains("@")) {
      return "Insira seu endereço de e-mail";
    }
  }



}