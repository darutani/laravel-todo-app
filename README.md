# arsaga-server-laravel-template

アルサーガのサーバーサイドの公式テンプレート、Laravel版です。   

## このリポジトリについて

このリポジトリは、環境構築や、一部の脆弱性への対策、基底クラスの実装などがすでに行われている、  
Laravel開発向けのテンプレートリポジトリです。  
「当社におけるプロジェクト立ち上げに慣れている」もしくは「進行上の具体的な狙いがある」などの場合を除き、  
基本的にこのリポジトリを「Template repository」として選択し、PJにおける開発を開始することを推奨します。

### 修正したい箇所がある方へ

このリポジトリの実装内容に対して、  

- 修正を行いたい箇所がある方
- 追加で機能の実装を行いたい方
- 具体的な修正方法はわからないが、既存の実装に問題を確認した方

などなどいらっしゃいましたら、このリポジトリへIssueやPull Requestを作成いただければと思います。  
社内オープンソース的な形で長期的な視点でブラッシュアップしていけたらと思っていますので、ぜひご協力ください。  

## PJ立ち上げ時の利用方法

### 1. プロジェクト用のリポジトリを作成する

プロジェクト用のリポジトリを、**このリポジトリをtemplateとして**作成します。  
手順は下記のNotionページを確認してください。
  
https://www.notion.so/arsagajp/16b9a85f6a644a6f9c8cb2e2d3ebfda6?pvs=4#90483472daca43ac96b0965b98e36f56

### 2. .env.exampleとREADME.mdを編集し、リモートへpushする

まず`./.env.example` **および** `./src/.env.example`の下記の変数を、プロジェクトに合わせて最初に編集してください。  

```shell
# 「./.env.example」 と 「./src/.env.example」 で、変数の値が同じになるように設定してください。
PROJECT_NAME=hoge-pj

# なお、作成したリポジトリ名と完全に一致している必要はありません。  
# 具体的な例えとして、リポジトリ名が「hoge-pj-server」であるときは、  
# 「PROJECT_NAME」は「hoge-pj」のように、suffixを除いた短縮形式で問題ありません。(むしろこちらが推奨です)  
```
  
また、プロジェクトの内容に合わせて、**忘れずにこのREADMEを編集**しましょう。  

### 3. 環境構築を行う

下記「環境構築手順」にそって、アサインメンバーそれぞれ、環境構築を行ってください。

## 環境構築手順

### Macの場合

```sh
$ git clone git@github.com:arsaga-partners/{リポジトリ名}.git

$ cd {リポジトリ名}

$ make init
# 端末のユーザーのパスワードを打つ or touchIDで認証する (最大でも2, 3回)
```

### Windows(WSL + Linux)、Linux PCの場合

`make init`を一発で通すために必要な一部作業の自動化について、現時点で未対応の内容があります。  
追って対応を予定していますが、現状はご容赦ください。  

```sh
$ git clone git@github.com:arsaga-partners/{リポジトリ名}.git

$ cd {リポジトリ名}

# 〜手作業が必要な部分の例〜

# 
#「./.scripts/append-hosts.sh」の内容に沿ってWindows側のhostsファイル
# 「/c/Windows/System32/drivers/etc/hosts」を編集する
# 
# 例.) 
# 127.0.0.1 ${PROJECT_NAME}.test
# 127.0.0.1 api.${PROJECT_NAME}.test
# 127.0.0.1 admin.${PROJECT_NAME}.test
#

$ make init
```
