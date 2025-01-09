FROM quay.io/jupyter/datascience-notebook:x86_64-python-3.11

# Install from the requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
COPY --chown=${NB_UID}:${NB_GID} install.R /tmp/install.R
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install R packages
RUN Rscript /tmp/install.R 

# Ensure permissions are correct for the jovyan user
USER root
RUN chown -R ${NB_UID}:${NB_GID} /home/jovyan
USER ${NB_USER}
