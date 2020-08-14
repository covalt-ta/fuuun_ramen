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

- has_one  :card
- has_one  :address
- has_one  :basket, dependent: :destroy
- has_one :order_record, dependent: :destroy
- has_many :order_record_products, through: :order_record
- has_many :comments
- has_many :likes


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


## baskets テーブル

| Column | Type       | Options                                                |
| ------ | ---------- | ------------------------------------------------------ |
| user   | references | null: false unique: true index: true foreign_key: true |

### Association

- belongs_to :user
- has_many   :basket_products, dependent: :destroy
- has_many   :products,        through: :basket_products


## basket_products テーブル

| Column  | Type       | Options                                   |
| ------- | ---------- | ----------------------------------------- |
| basket  | references | null: false index: true foreign_key: true |
| product | references | null: false index: true foreign_key: true |

### Association

- belongs_to :basket
- belongs_to :product


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
- has_many               :basket_products, dependent: :destroy
- has_many               :order_record_products, dependent: destroy
- has_many               :comments
- has_many               :likes


## toppings テーブル

| Column               | Type       | Options                       |
| -------------------- | ---------- | ----------------------------- |
| name                 | string     | null: false                   |
| price                | integer    | null: false                   |
| admin                | references | null: false foreign_key: true |

### Association

- belongs_to :admin
- belongs_to :order_record_product


## order_records テーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| user          | references | null: false foreign_key: true |

### Association

- belongs_to :user
- has_many   :order_record_products, dependent: :destroy
- has_many   :products, through: :order_record_products
- has_many   :reservations


## order_record_products テーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| order_record  | references | null: false foreign_key: true |
| product       | references | null: false foreign_key: true |
| topping       | references |             foreign_key: true |

### Association

- belongs_to :product
- belongs_to :order_record
- has_many   :toppings


## reservations テーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| order_date    | date       | null: false                   |
| order_time_id | integer    | null: false                   |
| order_record  | references | null: false foreign_key: true |

### Association

- belongs_to :order_record


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


## ActiveHash 

| model              |
| ------------------ |
| Category           |
| Prefecture         |

## Active Storage 
画像用テーブルはActive Storageを使用

### Gem / ツール
- active_storage
- imagemagick
- mini_magick
- image_processing

## PAY.JP
クレジットカード決済機能にはPAY.JPを用いて実装
