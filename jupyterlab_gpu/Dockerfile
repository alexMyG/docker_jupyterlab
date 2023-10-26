FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

USER root

# Ubuntu packages
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y python3 python3-pip zsh wget python3-dev git curl nodejs
RUN python3 -m pip install --upgrade pip

# git global configuration
RUN git config --global pull.rebase true
RUN git config --global rebase.autoStash true 

RUN pip install --upgrade jupyter jupyterlab jupyter_contrib_nbextensions jupyterlab-git jupyterlab-quickopen aquirdturtle_collapsible_headings 

RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user
RUN jupyter nbextension enable collapsible_headings/main --user

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 14.18.1
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN jupyter lab build

# Environmental variables for wandb
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# General pip packages
RUN pip install --upgrade twine keyrings.alt pynvml fastgpu

# Add the user settings. These should be copied by child images to the user folders
ADD .jupyter/lab/user-settings /.jupyter/lab/user-settings

# Add ipython_config.py in /etc/ipython
RUN mkdir /etc/ipython

RUN echo "c.Completer.use_jedi = False" > /etc/ipython/ipython_config.py

# JUPYTERLAB additional extension for CPU, Memory, GPU usage and new themes
RUN pip3 install jupyterlab_nvdashboard jupyterlab-logout jupyterlab-system-monitor jupyterlab-topbar \
                 jupyterlab_theme_hale jupyterlab_theme_solarized_dark  \
                 jupyter-lsp jupyterlab-drawio jupyterlab_code_formatter black isort jupyterlab_latex \
                 xeus-python theme-darcula jupyterlab_materialdarker lckr-jupyterlab-variableinspector

RUN jupyter labextension install jupyterlab-chart-editor 

# Required for Dash 
RUN jupyter lab build 

RUN pip3 install scikit-learn fastgpu nbdev pandas transformers tensorflow-addons \
     tensorflow pymongo emoji python-dotenv plotly torch torchvision torchaudio

RUN pip3 install --upgrade jupyter-server

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh)"

ENV SHELL=/bin/zsh

RUN sed -i '/^ZSH_THEME/c\ZSH_THEME="agnoster"' ~/.zshrc

ADD .jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings /.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

ARG UID
ARG GID
ARG USER

RUN groupadd -g $GID $USER && \
    useradd -l -u $UID -g $GID $USER && \
    install -d -m 0755 -o $UID -g $GID /home/$USER

RUN mkdir -p /home/$USER/work && \
    chown $UID:$GID /home/$USER/work


RUN chown $UID:$GID /home/$USER/work


EXPOSE 8888
WORKDIR /home/$USER/work
CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--allow-root","--ContentsManager.allow_hidden=True"]
