# アプリケーション名
■■■■■■■■

# アプリケーション概要
■■■■■■■■

# URL
■■■■■■■■

# テスト用アカウント
■■■■■■■■

# 利用方法
■■■■■■■■

# アプリケーションを作成した背景
■■■■■■■■

# 洗い出した要件
■■■■■■■■

# 実装した機能についての画像やGIFおよびその説明
■■■■■■■■

# 実装予定の機能
■■■■■■■■

# データベース設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :dogs
- has_many :posts
- has_many :comments

## dogsテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| dog_name     | string     | null: false                    |
| dog_birthday | date       | null: false                    |
| breed_id     | integer    | null: false                    |
| gender_id    | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## postsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| prefecture_id | integer    | null: false                    |
| place_name    | string     | null: false                    |
| category_id   | integer    | null: false                    |
| people_num    | integer    | null: false                    |
| dogs_num      | integer    | null: false                    |
| rating_id     | integer    | null: false                    |
| review        | text       | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_many   :conditions, through: :post_conditions

## conditionsテーブル

| Column   | Type       | Options          |
| -------- | ---------- | ---------------- |
| category | string     |                  |

### Association

- has_many   :posts, through: :post_conditions

## post-conditionsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| post      | references | null: false, foreign_key: true |
| condition | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :condition

## commentsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| post      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

# 画面遷移図
■■■■■■■■

# 開発環境
■■■■■■■■

# ローカルでの動作方法
■■■■■■■■

# 工夫したポイント
■■■■■■■■

# 改善点
■■■■■■■■

# 制作時間

2023/8/22〜　■■■■■■■■