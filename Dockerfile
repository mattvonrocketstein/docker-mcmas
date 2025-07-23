# MCMAS v1.3.0 
# Usage: mcmas [OPTIONS] FILE 
# Example: mcmas -v 3 -u myfile.ispl
# Options: 
#   -s 	 	 Interactive execution
#   -v Number 	 verbosity level ( 1 -- 5 )
#   -u 	 	 Print BDD statistics 
#   -e Number 	 Choose the way to generate reachable state space (1 -- 3, default 2)
#   -o Number 	 Choose the way to order BDD variables (1 -- 4, default 2)
#   -g Number 	 Choose the way to group BDD variables (1 -- 3, default 3)
#   -d Number 	 Choose the point to disable dynamic BDD reordering (0 -- 3, default 3)
#   -nobddcache 	 Disable internal BDD cache
#   -k 	 	 Check deadlock in the model
#   -a 	 	 Check arithmetic overflow in the model
#   -c Number 	 Choose the way to display counterexamples/witness executions (1 -- 3)
#   -p Path 	 Choose the path to store files for counterexamples
#   -exportmodel 	 Export model (states and transition relation) to a file in dot format
#   -f Number 	 Choose the level of generating ATL strategies (1 -- 4)
#   -l Number 	 Choose the level of generating ATL counterexamples (1 -- 2)
#   -w 	 	 Try to choose new states when generating ATL strategies
#   -atlk Number 	 Choose ATL semantics when generating ATL strategies (0 -- 2, default 0)
#   -uc Number 	 Choose the interval to display the number of uniform strategies processed
#   -uniform 	 Use uniform semantics for model checking
#   -ufgroup Name	 Specify the name of the group to generate uniform strategies
#   -n 	 	 Disable comparison between an enumeration type and its strict subset
#   -h 	 	 This screen

# WARNING: Compilation fails with newer debian due to conflicting bison version
FROM debian:stretch
RUN echo "deb http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -qq -y --force-yes gcc g++ git tree curl make flex bison

# For MCMAS source, use the tarball from this folder by default
COPY mcmas-1.3.0.tgz /opt/mcmas.tgz

# Or official URL or mirror URL
# RUN curl https://sail.doc.ic.ac.uk/mcmas-download.tgz -sSf > /opt/mcmas.tgz
# RUN curl https://github.com/mattvonrocketstein/mcmas/archive/refs/tags/1.3.0.tar.gz -sSf > /opt/mcmas.tgz

RUN cd /opt/ && tar -zxvf mcmas.tgz && rm mcmas.tgz && mv mcmas-* mcmas
WORKDIR /opt/mcmas
RUN make
RUN cp ./mcmas /usr/local/bin/mcmas
ENTRYPOINT ["/usr/local/bin/mcmas"]