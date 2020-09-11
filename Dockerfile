FROM thomasweise/texlive:latest

ARG UID=1000
ARG GID=1000

# Install latexmk and texlive italian
RUN apt-get update \
 && apt-get install -y \
        latexmk \
        texlive-lang-italian \
 && rm -rf /var/lib/apt/lists/*

# Add default user
RUN groupadd -g ${GID} tex \
 && useradd -u ${UID} -g tex tex
USER tex
