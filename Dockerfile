FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    curl \
    wget \
    unzip \
    zip \
    tar \
    xz-utils \
    sudo \
    vim \
    nano \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    gdb \
    gdb-multiarch \
    openocd \
    avrdude \
    gcc-avr \
    binutils-avr \
    avr-libc \
    tio \
    minicom \
    picocom \
    usbutils \
    dfu-util \
    srecord \
    clang-format \
    clang-tidy \
    cppcheck \
    doxygen \
    graphviz \
    binwalk \
    tmux \
    htop \
    tree \
    ripgrep \
    jq \
    udev \
    && apt-get clean

RUN useradd -ms /bin/bash developer

RUN usermod -aG dialout developer

WORKDIR /home/developer

RUN pip3 install --break-system-packages \
    pyserial \
    numpy \
    matplotlib \
    pandas \
    platformio \
    pyocd


RUN mkdir /opt/toolchains
RUN wget -q \
https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz \
-O /tmp/arm.tar.xz
RUN tar -xf /tmp/arm.tar.xz -C /opt/toolchains
ENV PATH="/opt/toolchains/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin:${PATH}"

RUN wget -q \
https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/14.2.0-3/xpack-riscv-none-elf-gcc-14.2.0-3-linux-x64.tar.gz \
-O /tmp/riscv.tar.gz
RUN mkdir /opt/riscv
RUN tar -xzf /tmp/riscv.tar.gz \
-C /opt/riscv \
--strip-components=1
ENV PATH="/opt/riscv/bin:${PATH}"


RUN git clone \
-b v5.4 \
--recursive \
https://github.com/espressif/esp-idf.git \
/opt/esp-idf

RUN /opt/esp-idf/install.sh all
ENV IDF_PATH=/opt/esp-idf
RUN echo "source /opt/esp-idf/export.sh >/dev/null" >> /etc/bash.bashrc

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