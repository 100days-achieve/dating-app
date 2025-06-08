# LoveConnect - Dating App

Ruby on Railsで作成されたマッチングアプリ「LoveConnect」です。

## 🚀 クイックスタート

### ⚡ セットアップ

```bash
# 1. リポジトリをクローン
git clone <repository-url>
cd dating-app

# 2. 自動セットアップ実行
make setup

# 3. 環境変数を設定
cp .env.example .env
# .envファイルのRAILS_MASTER_KEYに config/master.key の内容をコピー

# 4. アプリケーション再起動
docker compose restart

# 5. ブラウザでアクセス
open http://localhost:3002
```

## 🛠️ 開発環境

### 技術スタック

* **Ruby**: 3.3.0
* **Rails**: 8.0.2
* **データベース**: PostgreSQL
* **CSS**: Tailwind CSS
* **ジョブキュー**: Solid Queue（Rails 8の新機能）
* **コンテナ**: Docker & Docker Compose

### 🔧 Makefileコマンド一覧

#### 基本コマンド
- `make help` - 利用可能なコマンドを表示
- `make setup` - **初回セットアップ（完全自動化）**
- `make dev` - 開発モードで起動（バックグラウンド起動＋ログ表示）
- `make up` - アプリケーションを起動（フォアグラウンド）
- `make up-d` - アプリケーションをバックグラウンドで起動
- `make down` - アプリケーションを停止
- `make restart` - アプリケーションを再起動
- `make logs` - ログを表示

#### 開発用コマンド
- `make console` - Railsコンソールを起動
- `make shell` - webコンテナのシェルに接続

#### データベース関連
- `make db-create` - データベースを作成
- `make db-migrate` - マイグレーションを実行
- `make db-seed` - シードデータを投入
- `make db-reset` - データベースをリセット
- `make db-setup` - データベースの初期セットアップ

#### テスト関連
- `make test` - テストを実行
- `make test-setup` - テスト環境のセットアップ
- `make test-reset` - テスト用データベースをリセット

#### セットアップ関連
- `make env-setup` - .env.exampleファイルの生成
- `make master-key-setup` - master.keyファイルの生成
- `make solid-queue-setup` - Solid Queueテーブルの作成

#### その他
- `make clean` - 不要なDockerリソースを削除

### 🔐 環境変数の設定

#### 初回セットアップ後の手順

1. **環境変数ファイルをコピー**
   ```bash
   cp .env.example .env
   ```

2. **RAILS_MASTER_KEYを設定**
   ```bash
   # config/master.keyの内容を確認
   cat config/master.key
   
   # .envファイルを編集してRAILS_MASTER_KEYに値を設定
   nano .env
   ```

3. **アプリケーションを再起動**
   ```bash
   docker compose restart
   ```

#### 環境変数の説明

- `RAILS_MASTER_KEY`: Rails暗号化キー（**必須**）
- `DATABASE_URL`: 開発用データベースURL
- `TEST_DATABASE_URL`: テスト用データベースURL
- `RAILS_ENV`: Rails環境（development/test/production）
- `SOLID_QUEUE_IN_PUMA`: Solid Queueの設定

### 🏗️ 手動でのDocker環境セットアップ

自動セットアップを使わない場合：

```bash
# 1. ビルド・起動
docker compose up --build -d

# 2. 環境変数設定
make env-setup
make master-key-setup

# 3. データベースセットアップ
make db-setup

# 4. Solid Queueセットアップ
make solid-queue-setup

# 5. テスト環境準備
make test-setup
```

### 🧪 テスト実行

```bash
# テスト実行
make test

# テスト環境リセット（必要に応じて）
make test-reset
```

### 📱 アプリケーション機能

#### 実装済み機能
- **ユーザー認証**: Devise使用
- **ダッシュボード**: 統計表示、マッチ情報、おすすめユーザー
- **レスポンシブデザイン**: Tailwind CSS使用

#### 今後の実装予定
- プロフィール管理
- マッチング機能
- メッセージング機能
- 写真アップロード

### 🔍 トラブルシューティング

#### よくある問題

1. **Solid Queueエラー**
   ```bash
   make solid-queue-setup
   ```

2. **master.key関連エラー**
   ```bash
   make master-key-setup
   # .envファイルにRAILS_MASTER_KEYを設定
   ```

3. **データベース接続エラー**
   ```bash
   make db-reset
   ```

4. **テスト環境エラー**
   ```bash
   make test-reset
   ```

### 🌐 アクセス情報

- **アプリケーション**: http://localhost:3002
- **データベース**: localhost:5432
- **コンテナ内ポート**: 3000（アプリ）、5432（DB）

## 📋 開発ガイドライン

### コミットメッセージの形式

このプロジェクトでは以下の接頭語を使用してコミットメッセージを統一しています：

- `feat:` - 新機能・機能追加・機能改善
- `fix:` - バグ修正・問題解決  
- `chore:` - その他（環境設定、ドキュメント更新、リファクタリングなど）

#### 例：
```
feat: ユーザー登録機能の追加
fix: ログイン時のエラーハンドリングの修正
chore: Docker環境のセットアップ
```

### 開発フロー

1. **機能ブランチを作成**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **開発・テスト**
   ```bash
   make test
   ```

3. **コミット**
   ```bash
   git add .
   git commit -m "feat: 新機能の追加"
   ```

4. **プルリクエスト作成**

## 🚀 本番環境デプロイ

詳細は追って記載予定...

## 📞 サポート

問題が発生した場合は、以下を確認してください：

1. `make help` でコマンド一覧を確認
2. `make logs` でエラーログを確認
3. `make clean` で環境をクリーンアップ
4. `make setup` で再セットアップ
