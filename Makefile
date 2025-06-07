.PHONY: help build up down restart logs shell console db-create db-migrate db-seed db-reset test clean

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

clean: ## 不要なDockerリソースを削除
	docker compose down -v
	docker system prune -f

setup: ## 初回セットアップ（ビルド→起動→DB設定）
	make build
	make up-d
	sleep 10
	make db-setup
	@echo "セットアップ完了！ http://localhost:3002 でアクセスできます"

dev: ## 開発環境を起動（ビルド→バックグラウンド起動→ログ表示）
	make build
	make up-d
	make logs 