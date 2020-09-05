# 概要
架空のラーメン店「Fuuun Ramen」のWebサイトです。
管理者機能とユーザー機能に別れています。

「実店舗が集客・売上をオンラインから得る」

そのファーストステップを考えたWebサイトを作成しました。

URL: http://46.51.231.102/

![WEBサイトのイメージ](app/assets/images/site_image.png)

# 環境・使用技術

### フロントエンド

- HTML, CSS
- JavaScript, Ajax
- Bootstrap4

### バックエンド

- Ruby 2.6.5
- Ruby on Rails 6.0.3.2
- MySQL2

### 開発環境

- Docker/docker-compose
- MySQL2

### 本番環境

- AWS(EC2, S3)
- MariaDB
- Nginx, Unicorn

### インフラ構成図

- 準備中

### テスト

- 準備中

### その他使用技術

- Action Mailer
- Rubocop
- Capistrano
- 外部API（PAY.JP）
- その他準備中

# ER図

- 準備中

# 機能一覧
- ユーザー機能（お客様）
  - ユーザー情報の登録（住所、クレジットカードなど）
  - 商品の購入（メイン商品とトッピング商品の選択）
  - 予約（来店日時の選択）
  - 選択商品を買い物かご保存
  - お問い合わせ(ログイン不要)
  - パンくずリスト
  - 購入後の店舗とのチャット（準備中）
  - 商品にイイね（準備中）
  - 商品にコメント投稿（準備中）


- 管理者機能（店舗）
  - 店舗情報の登録（定休日、休日の設定）
  - 商品追加、編集(メイン商品、トッピング商品、販売停止)
  - トップページに最新情報の投稿
  - 予約の通知
  - 売上分析(準備中)

# 制作背景
前職では長年、店舗運営に関わるビジネスを行って参りました。
管理面でのIT化は進みつつありましたが、この度のコロナ禍によって「集客・売上」を得ることを目的としたITツールの活用は最重要課題として認識されたと感じていました。

オンライン集客・売上を得る為、「ECサイトでの売上軸の確立」が最終目標と捉えました。
そのファーストステップとして、Webサイトへの訪問を日常的に行ってもらう必要があると考えました。

「今、実店舗に来店されるお客様に、Webサイトへのログインをしてもらう」

そこからオンラインでの売上軸の獲得を見えてると考えてアプリケーションを作成しました。


# About me
都内でアミューズメント施設を運営する会社に14年間勤めておりました。
エリアマネージャーとして、インターネットカフェ店舗5店舗、カプセルホテル店舗2店舗の企画・運営・新規出店・マネージメント業務を担当しておりました。

2020年7月からWebエンジニアを目指してプログラミングスクールに通い勉強中です。


# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday        | date   | null: false |

### Association

- has_one  :card, dependent: :destroy
- has_one  :address, dependent: :destroy
- has_one  :basket, dependent: :destroy
- has_one :order_record, dependent: :destroy
- has_many :order_record_products, through: :reservations
- has_many :comments
- has_many :likes

## admins テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :products
- has_many :toppings
- has_many :informations
- has_many :notices, dependent: :destroy


# cardsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| card_token      | string     | null: false                    |
| customer_token  | string     | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to  :user


## addresses テーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| postal_code   | string     | null: false                   |
| prefecture_id | integer    | null: false                   |
| city          | string     | null: false                   |
| block         | string     | null: false                   |
| building      | string     |                               |
| phone_number  | string     | null: false                   |
| user          | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to_active_hash :prefecture

### ActiveHash
- Prefecture


## baskets テーブル

| Column | Type       | Options                                                |
| ------ | ---------- | ------------------------------------------------------ |
| user   | references | null: false unique: true index: true foreign_key: true |

### Association

- belongs_to :user
- has_many   :basket_products, dependent: :destroy
- has_many   :product_toppings, through: :basket_products


## basket_products テーブル

| Column          | Type       | Options                                   |
| --------------- | ---------- | ----------------------------------------- |
| basket          | references | null: false index: true foreign_key: true |
| product_topping | references | null: false index: true foreign_key: true |

### Association

- belongs_to :basket
- belongs_to :product_topping


## products テーブル

| Column      | Type       | Options                       |
| ----------- | ---------- | ----------------------------- |
| name        | string     | null: false                   |
| text        | text       | null: false                   |
| price       | integer    | null: false                   |
| category_id | integer    | null: false                   |
| admin       | references | null: false foreign_key: true |

### Association

- belongs_to_active_hash :category
- belongs_to             :admin
- has_one_attached       :image
- has_many               :produts
- has_many               :comments
- has_many               :likes

### ActiveHash
- Category


## toppings テーブル

| Column               | Type       | Options                       |
| -------------------- | ---------- | ----------------------------- |
| name                 | string     | null: false                   |
| price                | integer    | null: false                   |
| admin                | references | null: false foreign_key: true |

### Association

- belongs_to :admin
- has_many :product_topping_relations, dependent: :destroy
- ham_many :product_toppings, through: :product_topping_relations


## product_toppings テーブル

| Column  | Type       | Options                                   |
| ------- | ---------- | ----------------------------------------- |
| product | references | null: false index: true foreign_key: true |

### Association
- belongs_to :product
- has_many   :basket_products, dependent: :destroy
- has_many   :order_record_products, dependent: :destroy
- has_many   :product_topping_relations, dependent: :destroy
- has_many   :toppings, through: :product_topping_relations


## product_topping_relations テーブル

| Column          | Type       | Options                       |
| --------------- | ---------- | ----------------------------- |
| product_topping | references | index: true foreign_key: true |
| topping         | references | index: true foreign_key: true |

### Association
- belongs_to :product_topping
- belongs_to :topping


## order_records テーブル

| Column | Type       | Options                                                |
| ------ | ---------- | ------------------------------------------------------ |
| user   | references | null: false unique: true index: true foreign_key: true |

### Association

- belongs_to :user
- has_one    :reservation
- has_many   :order_record_products, dependent: :destroy
- has_many   :product_toppings, through: :order_record_products


## order_record_products テーブル

| Column          | Type       | Options                                   |
| --------------- | ---------- | ----------------------------------------- |
| product_topping | references | null: false index: true foreign_key: true |
| order_record    | references | null: false index: true foreign_key: true |
| reservation     | references | null: false index: true foreign_key: true |

### Association

- belongs_to :product_topping
- belongs_to :order_record
- belongs_to :reservation

## reservations テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| day             | date       | index: true |
| time_zone_id    | integer    | index: ture |
| count_person_id | integer    | index: true |
| user            | references | index: true |

### Association

- belongs_to :user
- has_many :order_record_products, optional: true
- has_many :product_toppings, through: :order_record_products
- has_many :notices, dependent: :destroy

## notices テーブル

| Column      | Type       | Options                                   |
| ----------- | ---------- | ----------------------------------------- |
| action      | string     | default: '' null: false                   |
| checked     | boolean    | default: false null: false                |
| admin       | references | null: false index: true foreign_key: true |
| reservation | references | index: true foreign_key: true             |

### Association

- belongs_to :admin
- belongs_to :reservation, optional: true


### ActiveHash
- TimeZone
- Count_Person

## informations テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| title  | string     | null: false                   |
| text   | text       | null: false                   |
| admin  | references | null: false foreign_key: true |

### Association

- belongs_to :admin
- has_one_attached :image

## shops テーブル

| Column              | Type       | Options                       |
| ------------------- | ---------- | ----------------------------- |
| name                | string     | null: false                   |
| email               | string     | null: false                   |
| open_time_zone_id   | integer    | null: false                   |
| close_time_zone_id  | integer    | null: false                   |
| holiday             | integer    |                               |
| postal_code         | string     | null: false                   |
| prefecture_id       | integer    | null: false                   |
| city                | string     | null: false                   |
| block               | string     | null: false                   |
| building            | string     |                               |
| phone_number        | string     | null: false                   |
| admin               | references | null: false foreign_key: true |


### Association

- belongs_to :admin
- has_many :holidays

### ActiveHash
- TimeZone


## holidays テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| day    | date       | null: false                   |
| shop   | references | null: false foreign_key: true |


### Association

- belongs_to :shop


## contacts テーブル

| Column       | Type   | Options     |
| ------------ | ------ | ----------- |
| name         | string | null: false |
| email        | string | null: false |
| text         | text   | null: false |
| phone_number | string |             |


## comments テーブル

| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| comment | text       | null: false                   |
| product | references | null: false foreign_key: true |
| user    | references | null: false foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user


## likes テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| product   | references | null: false foreign_key: true |
| user      | references | null: false foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user


## Active Storage
画像用テーブルはActive Storageを使用

### Gem / ツール
- active_storage
- imagemagick
- mini_magick
- image_processing

## PAY.JP
クレジットカード決済機能にはPAY.JPを用いて実装
