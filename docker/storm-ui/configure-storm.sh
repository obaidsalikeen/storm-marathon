sed -i -e "s/%zookeeper%/$MASTER_HOSTNAME/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$MASTER_HOSTNAME/g" $STORM_HOME/conf/storm.yaml

echo "storm.local.hostname: $MASTER_HOSTNAME" >> $STORM_HOME/conf/storm.yaml
echo "storm.local.dir: /ask/storm/local_dir" >> $STORM_HOME/conf/storm.yaml

/usr/bin/storm ui
