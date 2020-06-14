# README
# ヒヤリ・事故報告書管理システム
このアプリケーションは、実際に介護現場で使用されているヒヤリハット・事故報告書を参考に開発しました。報告書をより簡潔に作成・管理・分析・集計し、重大事故の防止に役立てることができます。また個人情報管理に欠かせないセキュリティ問題を、二段階認証を用いることで対応しています。

## 介護現場におけるヒヤリハット・事故とは
ヒヤリハットとは、 例えば介護をしていて「ヒヤッとする場面」です。事故は「起きてしまった事故」のことを指します。介護現場では、このヒヤリハット・事故報告書を積極的に活用することで、介護事故のリスクマネジメントを行い、大きな事故を未然に防ぐ工夫をしています。

***ヒヤリ・事故報告書管理システム***　[https://hiyari-system.herokuapp.com/](https://hiyari-system.herokuapp.com/)

![TOP画面](https://github.com/hayaminahiro/hiyari-system/blob/master/app/assets/images/top_readme.png)

## Specification
* 要件定義書<br>
[https://docs.google.com/spreadsheets/d/1FYmopdcnR0Voty-uRsZbDPVvxn-ZmCsi_5xR5YiLvyY/edit#gid=0](https://docs.google.com/spreadsheets/d/1FYmopdcnR0Voty-uRsZbDPVvxn-ZmCsi_5xR5YiLvyY/edit#gid=0)

* 説明動画<br>
ー掲載予定ー

## Version
* Ruby 2.6.3

## Fw
* Ruby on Rails 5.2.3
* Bootstrap 4

## Database
* psql (PostgreSQL) 12.3

## Environment
* 開発環境：macOS Catalina, RubyMine 2020.1
* 本番環境：heroku

## Version control tool
* Git
* GitHub

## Task Management
* issue(GitHub)

## 対応端末
* PC

## 対応ブラウザ
* Chrome

## Security
**Google Authenticator（二段階認証）**
-お試しで簡単ログインできるアカウントは準備-

![認証画面](https://github.com/hayaminahiro/hiyari-system/blob/master/app/assets/images/qr_readme.png)

## 主な機能一覧
* 施設新規登録/Login Logout機能(bcrypt), Google Login
* 二段階認証(Google Authenticator)
* ヒヤリハット事故報告書の月別管理
* ヒヤリハット事故報告書の利用者別管理
* ヒヤリハット事故報告書のCRUD機能
* ヒヤリハット事故報告書の管理者捺印機能
* 介護職員のCRUD機能(施設利用者と連動)
* 施設利用者のCRUD機能(介護職員と連動)
* ヒヤリハット事故の表集計・分析(Google Charts)

## 使用API
* Google API(Login)
* Google Charts



