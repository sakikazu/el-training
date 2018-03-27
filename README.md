# README

## 概要
https://github.com/everyleaf/el-training
のメンター用のリポジトリ

## ステップごとの留意事項

### ステップ1: Railsの開発環境を構築しよう
- ruby version: 最新でOK
- rails version: 5系の最新でOK
- PostgreSQLではなく、MySQLを指定すること(herokuではデフォルトPostgreSQLだがMySQLでも良い)

### ステップ2: GitHubにリポジトリを作成しよう
Githubは、あしたのチーム用アカウントではなく、個人用の方で良い。

### ステップ3: Railsプロジェクトを作成しよう
1. プロジェクト作成
```$ rails new el-training -T -d mysql```

2. 設定
- slim, rspec, database, gitignore, dev-tools
- ```$ bin/rails g rspec:install```

※PostgreSQLではなく、MySQLを指定すること

### ステップ5: データベースの接続設定（周辺設定）をしましょう
- ステップごとにブランチを切ってそこで作業する
- プルリクレビューはステップ19から行う

### ステップ8: テスト（feature spec）を書こう
- scaffoldを使わずにやる
- Circle CI、slack通知などは今は不要

### ステップ11: タスク一覧を作成日時の順番で並び替えましょう
featureスペックがうまく書けるかどうかが肝心。

### ステップ12: バリデーションを設定してみよう
-locales/*.ymlの定義次第で、翻訳ができることを知る。（エラーメッセージ、日付、submitボタン）

### ステップ13: デプロイをしよう（heroku）
1. herokuでGemfile.lockを参照するため更新する
  - pgとrails_12factorをbundle install
  - bundle installのためにpostgresqlをMacにも入れておく必要がある
    - ```$ brew install postgresql```
1. cliインストール
  - $ brew install heroku/brew/heroku
1. heroku login
1. heroku create (appname)
1. git push heroku master
1. heroku addons:add heroku-postgresql
1. heroku run rails db:migrate
1. heroku open

- URL: https://eltraining-in-at.herokuapp.com

### ステップ15: ステータスを追加して、検索できるようにしよう
- オプション要件のgemについて（余裕があれば）
  - gemを何のために導入するのか、その選定などの学習になる
  - ステートマシン：aasmなど
    - https://qiita.com/satour/items/fe838dc21dc95df95c62
  - 検索フォームを便利に作成できるようにする：ransack
    - https://qiita.com/nishina555/items/2c1f8bae980e426519bc

### ステップ19まで
- ここまで来たら初めてレビュー。
- これ以降はPR出して適宜レビュー。


