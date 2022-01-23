FROM mikkonecny/astonplc:base

RUN adduser plc
USER plc

# Install GHC and HLS using ghcup:
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=true
ENV BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=true
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

RUN chmod 755 ~plc
RUN chmod -R 755 ~plc/.ghcup

# RUN mv /root/.ghcup/ghc/8.10.7/bin/* /usr/local/bin
