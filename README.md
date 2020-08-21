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

### ActiveHash
- Prefecture


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
- has_many               :order_record_products, dependent: :destroy
- has_many               :product_toppings, dependent: :destroy
- has_many               :toppings, through: :product_topping
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
- has_many :product_toppings
- ham_many :products, through: :product_topping


## product_toppings テーブル

| Column  | Type       | Options                                   |
| ------- | ---------- | ----------------------------------------- |
| product | references | null: false index: true foreign_key: true |
| topping | references | null: false index: true foreign_key: true |

### Association

- belongs_to :product
- belongs_to :topping


## order_records テーブル

| Column | Type       | Options                                                |
| ------ | ---------- | ------------------------------------------------------ |
| user   | references | null: false unique: true index: true foreign_key: true |

### Association

- belongs_to :user
- has_many   :order_record_products, dependent: :destroy
- has_many   :products, through: :order_record_products
- has_one    :reservation


## order_record_products テーブル

| Column       | Type       | Options                                   |
| ------------ | ---------- | ----------------------------------------- |
| order_record | references | null: false index: true foreign_key: true |
| product      | references | null: false index: true foreign_key: true |

### Association

- belongs_to :product
- belongs_to :order_record


## reservations テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| day             | date       | index: true |
| time_zone_id    | integer    | index: ture |
| count_person_id | integer    | index: true |
| order_record    | references | index: true |

### Association

- belongs_to :order_record, optional: true

### ActiveHash
- TimeZone
- Count_Person

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
