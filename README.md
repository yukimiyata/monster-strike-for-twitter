# モンストマルチforTwitter

![Untitled Diagram](https://user-images.githubusercontent.com/57031163/100539770-f8b66000-327b-11eb-90f4-66248dec593a.png)

## サービス概要
知らない人とモンスト*でマルチプレイを快適に楽しみたい人に
納得のいくマッチングを提供する
マルチプレイ募集アプリです。

*ミクシィ社が提供するモンスターストライク(略称：モンスト)は育てたモンスターを自分の指で引っ張って敵モンスターに当てて倒す新感覚アクションRPGです。

[画面遷移図](https://xd.adobe.com/view/cf8d6620-bb2b-4b1f-5817-a464fc1ac21d-b9bc/)

## 登場人物
### エンドユーザー
ツイッターを使用しているモンストユーザー
モンスト配信をしているモンストユーザー

### 管理者
ユーザーとマルチ募集の管理者

## ユーザーが抱える課題
モンストマルチプレイを楽しみたいが、現状は募集する際はユーザーやゲームキャラクターを指定できない。参加する場合も自分が参加すべき最も適切なキャラクターが分かりづらい。
配信者が募集する際に、参加側が早い者勝ちになる。

## 解決方法
マルチ募集アプリにユーザーのお気に入り機能や、ブロック機能、詳細なキャラクター指定機能を追加する。
配信者が募集する際に、抽選式のマッチングにする。

## こだわった点
・参加希望者がリアルタイムに確認できる
マルチプレイ募集アプリは即時に参加希望者が確認できる必要があると考えました。ユーザーがリロードを行って確認するといった事は避けました。そこで、Ajaxを利用してポーリングする事によって、参加希望者を確認できるようにしました。

・詳細な募集(キャラクター指定、能力値指定)ができる

・マッチしたユーザーのお気に入り、ブロック機能がある

## プロダクト
マルチ募集アプリが快適にできるwebアプリケーション

## マーケット
twitterを使用しているモンストユーザー

## 使用技術
RubyonRails HTML CSS Javascript MySQL AWS(VPC, EC2, RDS, Elastic IP, Route53, S3)
