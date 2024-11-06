FROM python:3.12

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    python3-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    x11-apps \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# uvのインストール
RUN pip install uv

# 作業ディレクトリの作成
WORKDIR /app

# requirements.txtをコピー
COPY pyproject.toml .

# uvを使用してパッケージをインストール
RUN uv sync

# アプリケーションファイルのコピー
COPY game.py .

# 環境変数の設定
ENV DISPLAY=:0

# コンテナ起動時のコマンド
CMD ["python", "game.py"]