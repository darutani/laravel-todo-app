## .docs directory

OpenAPI(Swagger)のjsonファイルをはじめとした、  
本番環境の動作に必要のないファイルを配置するためのディレクトリです。  
  
Laravel OpenAPI Generatorに関しては、docker-compose起動中に  
ホストPCから`make openapi-generate`を実行することで  
自動的に`openapi`ディレクトリにファイルが生成されます。  
