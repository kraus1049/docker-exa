FROM ekidd/rust-musl-builder as builder
LABEL maintainer="kraus1049 <kraus1049@gmail.com>"

ARG SRCDIR=https://github.com/ogham/exa
ARG SOFTWARE_NAME=exa
RUN git clone ${SRCDIR} && \
    cd ./${SOFTWARE_NAME} && \
    cargo build --release && \
    mkdir /home/rust/work && \
    strip ./target/x86_64-unknown-linux-musl/release/${SOFTWARE_NAME}

FROM scratch as runner
#FROM alpine as runner
COPY --from=builder /home/rust/src/exa/target/x86_64-unknown-linux-musl/release/exa /exa
COPY --from=builder /home/rust/work /work
ENV PATH=/:PATH
WORKDIR /work

CMD ["/exa"]