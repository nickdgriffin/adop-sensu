FROM sstarcher/sensu:0.26.5 

# Enable Embedded Ruby
RUN sed -i -r 's/EMBEDDED_RUBY=false/EMBEDDED_RUBY=true/' /etc/default/sensu

# Install Mailer 2.5.4
RUN /opt/sensu/embedded/bin/gem install mail --version 2.5.4
RUN /opt/sensu/embedded/bin/gem install aws-ses

# Install plugins
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks --version 2.4.0
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-process-checks --version 2.4.0
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-memory-checks --version 3.0.2
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-network-checks --version 2.0.1
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-cpu-checks --version 1.1.2
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-filesystem-checks --version 1.0.0
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-load-checks --version 2.0.0
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-uptime-checks --version 1.1.0
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-io-checks --version 1.0.1

# Bake config & checks in
COPY resources/conf.d/* /etc/sensu/conf.d/
COPY resources/check.d/ /etc/sensu/check.d/
COPY resources/handlers/* /etc/sensu/handlers/
COPY resources/plugins /etc/sensu/plugins/
RUN chmod -R +x /etc/sensu/plugins
