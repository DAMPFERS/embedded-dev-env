# Берем официальный образ с уже установленным ESP-IDF v5.4
FROM espressif/idf:release-v5.4

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Доустанавливаем нужные инструменты (AVR, отладчики, утилиты, код-анализаторы)
# Базовый образ уже содержит python3, pip, git, cmake, ninja и build-essential
RUN apt-get update && apt-get install -y \
    python3-pip \
    gcc-avr avr-libc avrdude \
    gdb-multiarch openocd \
    tio minicom picocom \
    usbutils dfu-util \
    clang-format clang-tidy cppcheck doxygen graphviz \
    binwalk tmux htop tree ripgrep jq \
    sudo vim nano \
    && apt-get clean

# Устанавливаем Python-библиотеки
# Устанавливаем Python-библиотеки
RUN python3 -m pip install --break-system-packages \
    pyserial numpy matplotlib pandas platformio pyocd

# Скачиваем и устанавливаем ARM Toolchain
RUN mkdir -p /opt/toolchains && \
    wget -q https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/arm.tar.xz && \
    tar -xf /tmp/arm.tar.xz -C /opt/toolchains && \
    rm /tmp/arm.tar.xz
ENV PATH="/opt/toolchains/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin:${PATH}"

# Скачиваем RISC-V xPack Toolchain
RUN wget -q https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v15.2.0-1/xpack-riscv-none-elf-gcc-15.2.0-1-linux-x64.tar.gz -O /tmp/riscv.tar.gz && \
    mkdir -p /opt/riscv && \
    tar -xzf /tmp/riscv.tar.gz -C /opt/riscv --strip-components=1 && \
    rm /tmp/riscv.tar.gz
ENV PATH="/opt/riscv/bin:${PATH}"

# Создаем пользователя и добавляем в нужные группы
RUN useradd -ms /bin/bash developer && \
    usermod -aG dialout,sudo developer

WORKDIR /home/developer
USER developer

# В официальном образе ESP-IDF находится в /opt/esp/idf
# Переменные среды уже настроены, но для интерактивного bash можно добавить source
RUN echo "source /opt/esp/idf/export.sh >/dev/null" >> ~/.bashrc







# FROM ubuntu:24.04

# ENV DEBIAN_FRONTEND=noninteractive
# ENV TZ=UTC
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     cmake \
#     ninja-build \
#     ccache \
#     git \
#     curl \
#     wget \
#     unzip \
#     zip \
#     tar \
#     xz-utils \
#     sudo \
#     vim \
#     nano \
#     python3 \
#     python3-pip \
#     python3-venv \
#     python3-dev \
#     gdb \
#     gdb-multiarch \
#     openocd \
#     avrdude \
#     gcc-avr \
#     binutils-avr \
#     avr-libc \
#     tio \
#     minicom \
#     picocom \
#     usbutils \
#     dfu-util \
#     srecord \
#     clang-format \
#     clang-tidy \
#     cppcheck \
#     doxygen \
#     graphviz \
#     binwalk \
#     tmux \
#     htop \
#     tree \
#     ripgrep \
#     jq \
#     udev \
#     && apt-get clean

# RUN useradd -ms /bin/bash developer

# RUN usermod -aG dialout developer

# WORKDIR /home/developer

# RUN pip3 install --break-system-packages \
#     pyserial \
#     numpy \
#     matplotlib \
#     pandas \
#     platformio \
#     pyocd


# RUN mkdir /opt/toolchains
# RUN wget -q \
# https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz \
# -O /tmp/arm.tar.xz
# RUN tar -xf /tmp/arm.tar.xz -C /opt/toolchains
# ENV PATH="/opt/toolchains/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin:${PATH}"

# RUN wget -q \
# https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v15.2.0-1/xpack-riscv-none-elf-gcc-15.2.0-1-linux-x64.tar.gz \
# -O /tmp/riscv.tar.gz
# RUN mkdir /opt/riscv
# RUN tar -xzf /tmp/riscv.tar.gz \
# -C /opt/riscv \
# --strip-components=1
# ENV PATH="/opt/riscv/bin:${PATH}"


# RUN git clone \
# -b v5.4 \
# --recursive \
# https://github.com/espressif/esp-idf.git \
# /opt/esp-idf

# RUN /opt/esp-idf/install.sh all
# ENV IDF_PATH=/opt/esp-idf
# RUN echo "source /opt/esp-idf/export.sh >/dev/null" >> /etc/bash.bashrc




# FROM ubuntu:24.04

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt update && apt install -y \
#     build-essential \
#     cmake \
#     ninja-build \
#     git \
#     gcc-avr \
#     avr-libc \
#     avrdude \
#     gcc-arm-none-eabi \
#     openocd \
#     gdb-multiarch \
#     python3 \
#     python3-pip \
#     tio \
#     minicom \
#     picocom \
#     usbutils \
#     && apt clean

# RUN pip3 install --break-system-packages \
#     platformio \
#     pyserial