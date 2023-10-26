# docker_jupyterlab

### Docker image for ML projects with GPU access

Docker-compose project with Jupyterlab as a service

Check jupyterlab_gpu/Dockerfile to see all libraries installed.

Mos important ones:

- scikit-learn
- fastgpu
- nbdev
- pandas
- transformers
- tensorflow-addons
- tensorflow
- pymongo
- emoji
- python-dotenv
- plotly
- torch
- torchvision
- torchaudio


To keep same user and permissions between docker and host, you have to run:

``echo -e "\nUID=$(id -u)\nGID=$(id -g)\nUSER=$(whoami)" >> .env``


