FROM mikkonecny/astonplc:base

# Install GHC and HLS using ghcup:
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=true
ENV BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=true
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# RUN chmod 755 /root; chmod 755 /root/.ghcup; chmod 755 /root/.ghcup/bin
# RUN echo 'PATH="\/root/.ghcup/bin:\$PATH"' >> /etc/bash.bashrc

# RUN curl -sSL https://get.haskellstack.org/ | sh
# RUN stack setup --resolver lts-18.22
# RUN stack install stm

RUN adduser plc
