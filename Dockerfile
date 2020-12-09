FROM continuumio/miniconda3:4.7.10

LABEL "repository"="https://github.com/acesseonline/conda-package-publish-action"
LABEL "maintainer"="Jadson Ribeiro <contato@jadsonbr.com.br>"

RUN conda install -y anaconda-client conda-build

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
