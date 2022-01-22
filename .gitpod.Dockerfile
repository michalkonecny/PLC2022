# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.140.1/containers/java/.devcontainer/base.Dockerfile

# [Choice] Java version: 11, 14
ARG VARIANT="14"
FROM mcr.microsoft.com/vscode/devcontainers/java:0-${VARIANT}

# [Option] Install Maven
ARG INSTALL_MAVEN="false"
ARG MAVEN_VERSION=""
# [Option] Install Gradle
ARG INSTALL_GRADLE="false"
ARG GRADLE_VERSION=""
RUN if [ "${INSTALL_MAVEN}" = "true" ]; then su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install maven \"${MAVEN_VERSION}\""; fi \
    && if [ "${INSTALL_GRADLE}" = "true" ]; then su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install gradle \"${GRADLE_VERSION}\""; fi

# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# fix for expired signature; fix from https://github.com/yarnpkg/yarn/issues/7866
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential gnat clisp openjdk-11-jdk swi-prolog python g++ golang-go

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libffi-dev libffi6 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# Add colourised ls
# RUN cat /root/.bashrc | head -n -5 | tail -n 5  | sed "s/# //" >> /root/.bashrc

# Add history search key bindings
RUN echo "bind '\"\e[A\"':history-search-backward" >> /root/.bashrc
RUN echo "bind '\"\e[B\"':history-search-forward" >> /root/.bashrc

RUN adduser gitpod
USER gitpod

# Install GHC and HLS using ghcup:
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=true
ENV BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=true
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# RUN curl -sSL https://get.haskellstack.org/ | sh
# RUN stack setup --resolver lts-18.22
# RUN stack install stm