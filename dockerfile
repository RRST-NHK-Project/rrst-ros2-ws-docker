FROM ros:jazzy-ros-core

WORKDIR /ros2_ws

# rrst-ros2-ws 配下を src にコピー
COPY rrst-ros2-ws src

# 依存関係解決 & ビルド
RUN apt-get update && rosdep update && \
    rosdep install --from-paths src --ignore-src -y && \
    colcon build --symlink-install

# 環境変数
ENV ROS_WS=/ros2_ws
RUN echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc
