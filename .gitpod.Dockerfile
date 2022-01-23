FROM mikkonecny/astonplc:base

# Install GHC and HLS using ghcup:
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=true
ENV BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=true
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

RUN mv /root/.ghcup/bin/* /usr/local/bin

RUN adduser plc
