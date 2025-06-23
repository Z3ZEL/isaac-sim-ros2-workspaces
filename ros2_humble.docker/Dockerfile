ARG BASE_IMAGE=osrf/ros:humble-desktop-full-jammy
FROM ${BASE_IMAGE}

ENV ROS_PYTHON_VERSION=3
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Upgrade installed packages
RUN apt update
# Next, build the additional workspace 
RUN mkdir ros2_ws
COPY ./humble_ws ros2_ws
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/workspace/ros2_ws/fastdds.xml
ENV ROS_DISTRO=humble

WORKDIR /workspace/ros2_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.sh && rosdep update && rosdep install --from-paths src --ignore-src -r -y"
RUN /bin/bash -c "source /opt/ros/humble/setup.sh && colcon build"

# Custom commands
RUN echo 'rid() { export ROS_DOMAIN_ID=$1; }' >> ~/.bashrc
COPY ./common/entrypoint.sh /

RUN echo "echo '>>>>   [HUMBLE WS]   <<<<'" >> ~/.bashrc
RUN echo "echo ' - rid <domain_id> to set ROS_DOMAIN_ID'" >> ~/.bashrc
RUN echo "export PS1='\[\e[1;32m\]\u\[\e[0m\]@\h:\w\$ '" >> ~/.bashrc

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]