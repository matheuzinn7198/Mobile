# json_shared_preferences

A new Flutter project.


Shared Preferences (Armazenamento Interno do Aplicativo)

Armazanamento Chave -> Valor
                    "congig" -> "Texto" texto em formato Json

O que é um Texto em Formato Json ->
[
    config:{
        "NomedoUsuario" : "nome do usuário",
        "IdadedoUsuario" : 25,
        "TemaEscuro" ; true,
    }
]

dart -> Linguagem de Proframação do Flutter não lê JSON
     -> converter => ( json.decode => convert Texto:Json em Map:Dart)
                  => (json.encode => convert Map:Dart em Text:Json)

final //posso trocar uma unica vez
late //atribuir o valor depois