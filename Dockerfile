FROM python:3.9-slim-bullseye

WORKDIR /src

# Install system dependencies and scientific packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    g++ \
    gfortran \
    git \
    wget \
    liblapack-dev \
    libblas-dev \
    libfftw3-dev \
    libopenmpi-dev \
    gnuplot \
    xcrysden && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python scientific packages
RUN pip install --no-cache-dir \
    numpy \
    scipy \
    sympy \
    matplotlib \
    jupyter \
    jupyterlab

# Install Quantum Espresso (if available in the repositories)
RUN apt-get update && \
    apt-get install -y --no-install-recommends quantum-espresso wannier90 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the PATH environment variable
ENV PATH="/opt/q-e/bin:${PATH}"

# Default command when container starts
CMD ["/bin/bash"]