# Dating App

Ruby on Railsで作成されたマッチングアプリです。

## Docker環境での開発（推奨）

### 必要なもの
- Docker
- Docker Compose (v2以降)
- Make（あると便利）

### Makefileを使った簡単セットアップ

1. リポジトリをクローン
2. セットアップコマンドを実行：
   ```bash
   make setup
   ```
3. `http://localhost:3002` でアプリにアクセス

### Makefileコマンド一覧

- `make help` - 利用可能なコマンドを表示
- `make setup` - 初回セットアップ（ビルド→起動→DB設定）
- `make dev` - 開発モードで起動（バックグラウンド起動＋ログ表示）
- `make up` - アプリケーションを起動（フォアグラウンド）
- `make down` - アプリケーションを停止
- `make logs` - ログを表示
- `make console` - Railsコンソールを起動
- `make shell` - webコンテナのシェルに接続
- `make test` - テストを実行
- `make clean` - 不要なDockerリソースを削除

### 手動でのDocker環境セットアップ

1. リポジトリをクローン
2. アプリケーションをビルド・起動：
   ```bash
   docker compose up --build
   ```

3. 別のターミナルでデータベースをセットアップ：
   ```bash
   docker compose exec web rails db:create
   docker compose exec web rails db:migrate
   docker compose exec web rails db:seed  # シードデータがある場合
   ```

4. `http://localhost:3002` でアプリにアクセス

### よく使うDockerコマンド

- アプリ起動: `docker compose up`
- アプリ停止: `docker compose down`
- ログ確認: `docker compose logs`
- Railsコンソール: `docker compose exec web rails console`
- テスト実行: `docker compose exec web rails test`
- DB初期化: `docker compose exec web rails db:reset`

### 補足

- Docker Compose v2構文（`docker compose`）を使用
- アプリケーションはポート3002で動作（コンテナ内は3000番ポート）
- PostgreSQLはポート5432で動作

## 開発ガイドライン

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

## ローカル開発（Dockerを使わない場合）

### 技術スタック

* Ruby バージョン: 3.3.0
* フレームワーク: Ruby on Rails 8.0.2
* データベース: PostgreSQL
* CSS: Tailwind CSS

### セットアップ手順

* システム依存関係のインストール
* 設定ファイルの準備
* データベース作成
* データベース初期化
* テストスイートの実行方法
* サービス（ジョブキュー、キャッシュサーバー、検索エンジンなど）
* デプロイ手順

詳細は追って記載予定...
