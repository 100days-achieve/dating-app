.PHONY: help build up down restart logs shell console db-create db-migrate db-seed db-reset test clean test-setup test-reset solid-queue-setup master-key-setup env-setup

# デフォルトターゲット
help: ## このヘルプメッセージを表示
	@echo "利用可能なコマンド:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Dockerイメージをビルド
	docker compose build

up: ## アプリケーションを起動
	docker compose up

up-d: ## アプリケーションをバックグラウンドで起動
	docker compose up -d

down: ## アプリケーションを停止
	docker compose down

restart: ## アプリケーションを再起動
	docker compose restart

logs: ## ログを表示
	docker compose logs -f

shell: ## webコンテナのシェルに接続
	docker compose exec web bash

console: ## Railsコンソールを起動
	docker compose exec web rails console

db-create: ## データベースを作成
	docker compose exec web rails db:create

db-migrate: ## マイグレーションを実行
	docker compose exec web rails db:migrate

db-seed: ## シードデータを投入
	docker compose exec web rails db:seed

db-reset: ## データベースをリセット
	docker compose exec web rails db:reset

db-setup: ## データベースの初期セットアップ（作成→マイグレーション→シード）
	make db-create
	make db-migrate
	make db-seed

test: ## テストを実行
	docker compose exec web rails test

test-setup: ## テスト環境のセットアップ（テスト用DB作成→マイグレーション）
	docker compose exec web rails db:environment:set RAILS_ENV=test
	docker compose exec web rails db:create RAILS_ENV=test
	docker compose exec web rails db:migrate RAILS_ENV=test

test-reset: ## テスト用データベースをリセット
	docker compose exec web rails db:environment:set RAILS_ENV=test
	docker compose exec web rails db:drop RAILS_ENV=test
	docker compose exec web rails db:create RAILS_ENV=test
	docker compose exec web rails db:migrate RAILS_ENV=test

clean: ## 不要なDockerリソースを削除
	docker compose down -v
	docker system prune -f

env-setup: ## .env.exampleファイルの生成
	@if [ ! -f .env.example ]; then \
		echo "# Rails暗号化キー（必須）" > .env.example; \
		echo "RAILS_MASTER_KEY=" >> .env.example; \
		echo "" >> .env.example; \
		echo "# データベース設定" >> .env.example; \
		echo "DATABASE_URL=postgres://postgres:password@db:5432/dating_app_development" >> .env.example; \
		echo "TEST_DATABASE_URL=postgres://postgres:password@db:5432/dating_app_test" >> .env.example; \
		echo "" >> .env.example; \
		echo "# Rails設定" >> .env.example; \
		echo "RAILS_ENV=development" >> .env.example; \
		echo "RAILS_MAX_THREADS=5" >> .env.example; \
		echo "" >> .env.example; \
		echo "# サーバー設定" >> .env.example; \
		echo "WEB_CONCURRENCY=2" >> .env.example; \
		echo "" >> .env.example; \
		echo "# オプション設定" >> .env.example; \
		echo "SOLID_QUEUE_IN_PUMA=false" >> .env.example; \
		echo "CI=false" >> .env.example; \
		echo "" >> .env.example; \
		echo "# 本番環境用（本番デプロイ時に設定）" >> .env.example; \
		echo "DATING_APP_DATABASE_PASSWORD=" >> .env.example; \
		echo ".env.exampleファイルを生成しました"; \
	else \
		echo ".env.exampleファイルは既に存在します"; \
	fi

master-key-setup: ## master.keyファイルの生成
	@if [ ! -f config/master.key ]; then \
		echo "master.keyファイルを生成中..."; \
		docker compose run --rm web bash -c "EDITOR=touch rails credentials:edit"; \
	else \
		echo "master.keyファイルは既に存在します"; \
	fi

solid-queue-setup: ## Solid Queueのセットアップ（テーブル作成）
	docker compose run --rm web rails runner "load 'db/queue_schema.rb'"

setup: ## 初回セットアップ（ビルド→起動→env設定→master.key→DB設定→Solid Queue→テスト環境準備）
	make build
	make up-d
	sleep 10
	make env-setup
	make master-key-setup
	make db-setup
	make solid-queue-setup
	make test-setup
	@echo "セットアップ完了！ http://localhost:3002 でアクセスできます"
	@echo "テスト実行: make test"
	@echo ""
	@echo "📝 次のステップ:"
	@echo "1. .env.exampleを参考に.envファイルを作成してください"
	@echo "2. .envファイルにRAILS_MASTER_KEYの値を設定してください"
	@echo "3. docker compose restart でアプリケーションを再起動してください"

dev: ## 開発環境を起動（ビルド→バックグラウンド起動→ログ表示）
	make build
	make up-d
	make logs 