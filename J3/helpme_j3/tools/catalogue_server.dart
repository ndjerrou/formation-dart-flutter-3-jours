import 'dart:io';
Future<void> main(List<String> args)async{
 final mode=args.isEmpty?'ok':args.first;
 final serveur=await HttpServer.bind(InternetAddress.loopbackIPv4,8787);
 stdout.writeln('Catalogue : http://127.0.0.1:8787/artisans ; mode $mode');
 await for(final requete in serveur){
  requete.response.headers.set('Access-Control-Allow-Origin','*');
  requete.response.headers.contentType=ContentType.json;
  if(mode=='erreur'){requete.response.statusCode=503;requete.response.write('{"message":"Indisponible"}');}
  else if(mode=='json'){requete.response.write('{"tarif":"invalide"}');}
  else{requete.response.write(await File('assets/catalogue.json').readAsString());}
  await requete.response.close();
 }
}
