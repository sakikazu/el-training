# README

## 概要
https://github.com/everyleaf/el-training
のメンター用のリポジトリ

## ステップごとの留意事項

### ステップ2
Githubは、あしたのチーム用アカウントではなく、個人用の方で良い。

### ステップ3
1. プロジェクト作成
```$ rails new el-training -T -d mysql```

2. 設定
slim, rspec, database, gitignore, dev-tools
```$ bin/rails g rspec:install```

※PostgreSQLではなく、MySQLを指定すること

### ステップ5
プルリクレビューはステップ19から行う

### ステップ8
scaffoldを使わずにやる
Circle CI、slack通知などは今は不要

### ステップ11
featureスペックがうまく書けるかどうかが肝心。

### ステップ12
・locales/*.ymlの定義次第で、翻訳ができることを知る。（エラーメッセージ、日付、submitボタン）

### ステップ13: デプロイをしよう（heroku）
1. cliインストール
  - $ brew install heroku/brew/heroku
1. heroku login
1. heroku create (appname)
1. git push heroku master
1. heroku addons:add heroku-postgresql
1. heroku run rails db:migrate
1. heroku open

- URL: https://eltraining-in-at.herokuapp.com


### ステップ19まで
ここまで来たら初めてレビュー。
これ以降はPR出して適宜レビュー。


