FROM registry.screamtrumpet.csie.ncku.edu.tw/pros_images/pros_jetson_driver_image

# 複製 oradar_ros 資料夾到容器內的 /workspaces/src
COPY ./oradar_ros /workspaces/src/oradar_ros

# 設定工作目錄
WORKDIR /workspaces

# 設定預設的 shell 指令，所有RUN指令都會自動載入 ROS2環境
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN source /opt/ros/humble/setup.bash && \
    colcon build --symlink-install

# source colcon build 後的環境
RUN echo "source /workspaces/install/setup.bash" >> ~/.bashrc

# 預設啟動 bash
CMD ["bash"]
