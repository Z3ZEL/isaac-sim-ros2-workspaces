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
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV ROS_DISTRO=humble

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

RUN apt update --fix-missing 

# isaac ros2_bridge config
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/isaac-sim/exts/omni.isaac.ros2_bridge/humble/lib
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp

# setup entrypoint
COPY ../humble_ws/fastdds.xml /etc/fastdds.xml

WORKDIR /workspace
RUN mkdir ros2_ws
COPY ./humble_ws ros2_ws

WORKDIR /workspace/ros2_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.sh && rosdep init && rosdep update && rosdep install --from-paths src --ignore-src -r -y"
RUN /bin/bash -c "source /opt/ros/humble/setup.sh && colcon build"


# Custom commands
RUN echo 'rid() { export ROS_DOMAIN_ID=$1; }' >> ~/.bashrc
RUN echo 'alias launch_isaacsim="/isaac-sim/isaac-sim.sh --allow-root"' >> ~/.bashrc
COPY ../common/entrypoint.sh /

RUN echo "echo '>>>>   [HUMBLE WS]   <<<<'" >> ~/.bashrc
RUN echo "echo ' - rid <domain_id> to set ROS_DOMAIN_ID'" >> ~/.bashrc
RUN echo "echo ' - launch_isaacsim to launch Isaac Sim'" >> ~/.bashrc
RUN echo "export PS1='\[\e[1;32m\]\u\[\e[0m\]@\h:\w\$ '" >> ~/.bashrc


ENV ENABLE_ISAAC=1
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
