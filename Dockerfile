FROM continuumio/miniconda3

ARG USER_NAME=snake
ARG USER_ID=1000
ARG GROUP_ID=1000

COPY environment.yml /tmp/environment.yml
RUN conda env update -n base -f /tmp/environment.yml \
    && conda clean --all

RUN adduser --uid=${USER_ID} --gid=${GROUP_ID} --gecos "" ${USER_NAME} \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc \
    && mkdir -p /opt/workflow \
    && chown ${USER_ID}:${GROUP_ID} /opt/workflow
USER ${USER_NAME}
WORKDIR /opt/workflow
# COPY . /opt/workflow
