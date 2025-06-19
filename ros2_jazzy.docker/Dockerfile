ARG BASE_IMAGE=osrf/ros:jazzy-desktop-full
FROM ${BASE_IMAGE}

ENV ROS_PYTHON_VERSION=3

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
		cmake \
		build-essential \
		curl \
		wget \
		gnupg2 \
		lsb-release


# Upgrade installed packages
RUN apt update && apt upgrade -y && apt clean

# Install Python3.11
RUN apt update && \
    apt install --no-install-recommends -y build-essential software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install --no-install-recommends -y python3.11 python3.11-dev python3.11-distutils

# Setting up locale stuff
RUN apt update && apt install locales

RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

# Set default Python3 to python3.11

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2

# Pip install stuff
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py --force-reinstall && \
    rm get-pip.py

RUN pip3 install setuptools==70.0.0

RUN apt update && apt install -y \
  python3-pip \
  python3-pytest-cov \
  python3-rosinstall-generator \
  ros-dev-tools \
  libbullet-dev \
  libasio-dev \
  libtinyxml2-dev \
  libcunit1-dev \
  libacl1-dev 

RUN python3 -m pip install --ignore-installed -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  lark \
  netifaces

# RUN python3.11 -m pip uninstall numpy  -y
RUN python3.11 -m pip install --upgrade pip
RUN python3.11 -m pip install "numpy<2"

# Next, build the additional workspace 
RUN cd ${WORKDIR} && mkdir jazzy_ws
COPY ../jazzy_ws jazzy_ws
COPY ros2_jazzy.docker/entrypoint.sh /
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/workspace/jazzy_ws/fastdds.xml
ENV ROS_DISTRO=jazzy
RUN /bin/bash -c "source /opt/ros/jazzy/setup.sh && cd jazzy_ws && rosdep update && rosdep install --from-paths src --ignore-src -r -y && colcon build --cmake-args ' -DPython3_EXECUTABLE=/usr/bin/python3.11' --merge-install"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]