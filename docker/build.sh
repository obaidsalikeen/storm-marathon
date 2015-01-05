cd storm
docker build --no-cache -t=obaidsalikeen/storm:0.9.3 .
docker push obaidsalikeen/storm:0.9.3
cd ..


cd storm-nimbus
docker build --no-cache -t=obaidsalikeen/storm-nimbus:0.9.3 .
docker push obaidsalikeen/storm-nimbus:0.9.3
cd ..


cd storm-ui
docker build --no-cache -t=obaidsalikeen/storm-ui:0.9.3 .
docker push obaidsalikeen/storm-ui:0.9.3
cd ..


cd storm-supervisor
docker build --no-cache -t=obaidsalikeen/storm-supervisor:0.9.3 .
docker push obaidsalikeen/storm-supervisor:0.9.3
cd ..

