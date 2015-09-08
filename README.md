# benchmark


salt "*bench*" pkg.install build-essential
salt "*bench*" pkg.install git
salt "*bench*" pkg.install libssl-dev
salt "*bench*" cmd.run "git clone https://github.com/wg/wrk.git && cd wrk && make"
salt "*bench*" cmd.run "git clone https://github.com/TheBoxLtd/benchmark.git"



