
# [サービス名]
酒飲みチェッカー

## サービス概要
飲んだお酒の量を記録して、他人と比較できるサービス

## 想定されるユーザー層
自分が他の人と比べて、どのくらいお酒がの飲めるのか気になる人
お酒を飲むのが好きで、他人とお酒の量を競ったり自慢したい人


## サービスコンセプト
私自身、お酒が強いと言われることが多々あり、世間の人の中だとどのくらいなのかと疑問に思ったことや
前職で、よくお酒を飲む機会があり、お酒が強い人も多く、私自身も含めどれだけ飲んだなどの話をすることが多々ありました。
そこで、飲んだ量を記録しランキング形式にすることで、お酒をよく飲む人の楽しみの一つにしてもらったり、飲み仲間同士でも盛り上がれるようにとこのサービスを考えました。


## 実装を予定している機能
### MVP
・会員登録

・ログイン

・飲酒量確認画面

・飲酒量確認画面

  グラフの表示
  
  飲んだお酒の純アルコール量の表示（1日・1週間・1ヶ月）
  
・飲酒量登録画面

  カレンダーから選択した日にちに、飲んだお酒の種類、量を登録する
  
・ランキング

  1日・1週間・1ヶ月でランキングづけ
  
・アプリ内通知機能

  1日・1週間・1ヶ月 終わった際に結果を通知

### その後の機能

・友人やお気に入りの人の登録

・友人やお気に入りの人の中でのランキング機能

・googleログイン

・x投稿機能

### 機能の実装方針予定
Ruby: 3.0系

Rails: 7.0系

ユーザー登録・ログイン機能 socerry

グラフ表示 chartkick

カレンダー表示 SimpleCalendar

cssフレームワーク　　bootstrap

画像登録　carrierwave


本リリース
通知機能 ActionCable

ユーザーの検索機能 オートコンプリート rails-autocomplete

### 使用技術
バックエンド
 ・Ruby　3.2.2
 ・Ruby on Rails 7.0.5
　　・gem
  ・sorcery
  ・simple_calendar
  ・carrierwave
  ・chartkick
  ・ransack
  ・kaminari
  
 
 

フロントエンド
 ・Bootstrap5
 ・Hotwire(Turbo, Stimulus)

データベース
　・PostgreSQL

インフラ

　・fly.io

 ＃＃　ER図
 ![er](https://github.com/gahyu3/heavy_drinker_app/assets/62708936/a05aae4b-06b9-47a5-a889-968a912a20ec)



画面編纂図
https://www.figma.com/file/I8V9dur9CCKc7NP3l0uT4x/Untitled?type=design&node-id=3%3A3&mode=design&t=mQ7d7jsqGEWmQkHc-1
