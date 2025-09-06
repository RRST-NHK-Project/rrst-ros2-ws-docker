FROM ros:jazzy-ros-core

WORKDIR /ros2_ws

# ビルドに必要なツールを追加
RUN apt-get update && apt-get install -y \
    python3-rosdep \
    python3-colcon-common-extensions \
    git \
    && rm -rf /var/lib/apt/lists/*

# rosdep 初期化
RUN rosdep init && rosdep update

# rrst-ros2-ws 配下を src にコピー
COPY rrst-ros2-ws src

# 依存関係解決 & ビルド
RUN rosdep install --from-paths src --ignore-src -r -y && \
    colcon build --symlink-install

# 環境変数
ENV ROS_WS=/ros2_ws
RUN echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc
