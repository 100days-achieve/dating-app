# Dating App

This is a Ruby on Rails dating application.

## Docker Setup (Recommended)

### Prerequisites
- Docker
- Docker Compose (v2 or later)
- Make (optional, but recommended)

### Quick Start with Makefile

1. Clone the repository
2. Run the setup command:
   ```bash
   make setup
   ```
3. Access the application at `http://localhost:3002`

### Makefile Commands

- `make help` - 利用可能なコマンドを表示
- `make setup` - 初回セットアップ（ビルド→起動→DB設定）
- `make dev` - 開発環境を起動
- `make up` - アプリケーションを起動
- `make down` - アプリケーションを停止
- `make logs` - ログを表示
- `make console` - Railsコンソールを起動
- `make shell` - webコンテナのシェルに接続
- `make test` - テストを実行
- `make clean` - 不要なDockerリソースを削除

### Manual Docker Setup

1. Clone the repository
2. Build and start the application:
   ```bash
   docker compose up --build
   ```

3. In another terminal, set up the database:
   ```bash
   docker compose exec web rails db:create
   docker compose exec web rails db:migrate
   docker compose exec web rails db:seed  # if you have seed data
   ```

4. Access the application at `http://localhost:3002`

### Useful Docker Commands

- Start the application: `docker compose up`
- Stop the application: `docker compose down`
- View logs: `docker compose logs`
- Access Rails console: `docker compose exec web rails console`
- Run tests: `docker compose exec web rails test`
- Reset database: `docker compose exec web rails db:reset`

### Notes

- This project uses Docker Compose v2 syntax (`docker compose` instead of `docker-compose`)
- The application runs on port 3002 (mapped from container port 3000)
- PostgreSQL database runs on port 5432

## Development Guidelines

### Commit Message Format

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

## Local Development (Without Docker)

Things you may want to cover:

* Ruby version: 3.3.0

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
