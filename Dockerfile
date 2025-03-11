FROM registry.screamtrumpet.csie.ncku.edu.tw/pros_images/pros_jetson_driver_image:latest
ENV ROS_DISTRO=humble
ARG THREADS=4
ARG TARGETPLATFORM
SHELL ["/bin/bash", "-c"]
COPY oradar_ros /workspaces/src/oradar_ros
# System Upgrade
RUN apt update && \
    apt upgrade -y && \
    apt autoremove -y && \
    apt autoclean -y && \
    pip3 install --no-cache-dir --upgrade pip
RUN rosdep update --rosdistro $ROS_DISTRO && \
    colcon mixin update && \
    colcon metadata update && \
    rosdep install -q -y -r --from-paths src --ignore-src
RUN colcon build --symlink-install --parallel-workers ${THREADS} --mixin release && \
    rm -rf /tmp/* && \
    rm -rf /temp/* && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/* && \
    rm -rf /temp/* && \
    rm -rf /var/lib/apt/lists/*

    ENTRYPOINT ["/ros_entrypoint.bash"]
    CMD ["bash", "-l"]