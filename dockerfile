FROM ros:jazzy-ros-core

WORKDIR /ros2_ws

# パッケージソースをコピー
COPY src src

# 依存関係を解決してビルド
RUN apt-get update && rosdep update && \
    rosdep install --from-paths src --ignore-src -y && \
    colcon build --symlink-install

# 環境設定
ENV ROS_WS=/ros2_ws
RUN echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc
