FROM registry.screamtrumpet.csie.ncku.edu.tw/pros_images/pros_jetson_driver_image:latest

COPY oradar_ros /workspaces/src/oradar_ros

# 執行 colcon build 並設置環境
RUN . /opt/ros/humble/setup.bash && \
    colcon build --symlink-install && \
    echo "source /workspaces/install/setup.bash" >> ~/.bashrc