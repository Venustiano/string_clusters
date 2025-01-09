FROM quay.io/jupyter/datascience-notebook:x86_64-python-3.11

# Switch to root for installing system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    default-jdk \
    libpoppler-cpp-dev \
    gdal-bin \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libxml2-dev \
    libcurl4-openssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
    
# Set JAVA_HOME environment variable (optional)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"
# Switch back to the default user
USER ${NB_USER}
# Install from the requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install R packages
COPY --chown=${NB_UID}:${NB_GID} install.R /tmp/install.R
RUN Rscript /tmp/install.R && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
# Ensure permissions are correct for the jovyan user
USER root
RUN chown -R ${NB_UID}:${NB_GID} /home/jovyan
USER ${NB_USER}
