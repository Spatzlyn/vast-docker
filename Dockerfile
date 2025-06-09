FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# 1. 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    python3 python3-pip git curl \
    && rm -rf /var/lib/apt/lists/*

# 2. pip 업그레이드
RUN pip3 install --upgrade pip

# 3. PyTorch 설치 (CUDA 12.1 대응)
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 4. Qwen3 요구사항 패키지 설치
RUN pip3 install \
    transformers>=4.51.0 \
    sentence-transformers>=2.7.0 \
    accelerate \
    auto-gptq \
    jupyter

# 5. Jupyter 노트북 서버 실행
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8080", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
