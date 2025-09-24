#! /bin/zsh

uv venv --python 3.8 .venv
source .venv/bin/activate
uv pip install -U pip setuptools wheel
uv pip install numpy==1.23.5 scipy open3d
uv pip install torch torchvision --torch-backend=cu118
uv pip install --no-build-isolation "chumpy==0.70"
uv pip install git+https://github.com/ZhengyiLuo/SMPLSim.git@master