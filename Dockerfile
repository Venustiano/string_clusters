FROM quay.io/jupyter/datascience-notebook

# Copy the requirements files to the container
COPY requirements.txt /tmp/requirements.txt
COPY install.R /tmp/install.R

# Install Python packages
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Install R packages
RUN Rscript /tmp/install.R

# Ensure permissions are correct for the jovyan user
USER root
RUN chown -R ${NB_UID}:${NB_GID} /home/jovyan
USER ${NB_USER}
