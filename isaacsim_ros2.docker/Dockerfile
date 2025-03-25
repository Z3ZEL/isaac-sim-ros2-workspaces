FROM nvcr.io/nvidia/isaac-sim:4.5.0

RUN /isaac-sim/python.sh -m pip install opencv-python omegaconf hydra-core

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata apt-utils && \
    rm -rf /var/lib/apt/lists/*


# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    software-properties-common \
    curl \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --allow-downgrades libbrotli1=1.0.9-2build6
# setup keys
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO humble

# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-humble-desktop\
    ros-humble-vision-msgs \
    ros-humble-ackermann-msgs    \
    python3-pytest-cov \
    python3-rosinstall-generator \
    ros-dev-tools \
    wget \
    && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository universe
RUN /isaac-sim/python.sh -m pip install netifaces skyfield zfpy numba gdown pandas empy lark

# isaac ros2_bridge config
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/isaac-sim/exts/omni.isaac.ros2_bridge/humble/lib
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp

# setup entrypoint
COPY ../humble_ws/fastdds.xml /etc/fastdds.xml
COPY isaacsim_ros2.docker/entrypoint.sh /
COPY isaacsim_ros2.docker/setup_ros2_ws.sh /usr/local/bin/setup_ros2_ws.sh

RUN chmod +x /usr/local/bin/setup_ros2_ws.sh
RUN echo "alias setup_ros2_ws='/usr/local/bin/setup_ros2_ws.sh'" >> /.bashrc


ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
