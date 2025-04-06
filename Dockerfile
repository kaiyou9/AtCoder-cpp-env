FROM gcc:12.2

# 必要なパッケージのインストール
RUN apt update && apt install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    jq \
    gdb \
    vim \
    && rm -rf /var/lib/apt/lists/*
    
# AtCoder用ツールのインストール    
RUN pip3 install online-judge-tools && \
    npm install -g atcoder-cli && \
    acc config default-task-choice all

# タイムゾーンを日本時間に設定
ENV TZ=Asia/Tokyo    
    
#設定ファイルのコピー
COPY .config/alias.sh /etc/profile.d/alias.sh
COPY .config/bash_custom.sh /etc/profile.d/bash_custom.sh

#大文字小文字を区別せずに補完
# bash設定ファイルの作成
RUN echo 'set completion-ignore-case on' >> /etc/inputrc && \
    cat /etc/profile.d/alias.sh >> /etc/bash.bashrc && \
    cat /etc/profile.d/bash_custom.sh >> /etc/bash.bashrc
