# This (application.conf.single-system.tpl) is a configuration template for the Trusted Analytics Toolkit.
# Copy this to application.conf and edit to suit your system.
# Comments begin with a '#' character.
# Default values are 'commented' out with //.
# To configure for your system, look for configuration entries below with the word
# REQUIRED in all capital letters - these
# MUST be configured for the system to work.

# BEGIN REQUIRED SETTINGS

# Memory should be same or lower than what is listed as available in Cloudera Manager.
# Values should generally be in gigabytes, e.g. "8g"
trustedanalytics.atk.engine.spark.conf.properties.spark.executor.memory = "2g"
trustedanalytics.atk.giraph.mapreduce.map {
  memory.mb = 2048
  java.opts = "-Xmx2g"
}

# In a single machine configuration, all services are on the same host.
# This configuration uses the HOSTNAME environment variable (which is preconfigured
# in the startup scripts of the rest server) as the name for all the service hosts.

trustedanalytics.atk {

  # The host name for the Postgresql database in which the metadata will be stored
  metastore.connection-postgresql.host = ${HOSTNAME}

  engine {

    # The hdfs URL where the trustedanalytics folder will be created
    # and which will be used as the starting point for any relative URLs
    fs.root = "hdfs://"${HOSTNAME}"/user/atkuser"

    # The (comma separated, no spaces) Zookeeper hosts that
    # Titan needs to be able to connect to HBase
    titan.load.storage.hostname = ${HOSTNAME}
    titan.query.storage.hostname = ${trustedanalytics.atk.engine.titan.load.storage.hostname}

    spark {
      # Yarn Cluster mode
      #master = "yarn-cluster"
      # Spark Standalone mode: the URL for connecting to the Spark master server
      master = "spark://"${HOSTNAME}":7077"

      # Preferably spark.yarn.jar is installed in HDFS
      # In Cloudera Manager,
      #   1) Make sure the SPARK setting "spark_jar_hdfs_path" is set to this value
      #   2) Use "Actions" -> "Upload Spark Jar" to install jar in HDFS, if it is not already there
      //spark.yarn.jar = "hdfs://invalid-hdfs-host/user/spark/share/lib/spark-assembly.jar"
      //spark.yarn.jar = "/opt/cloudera/parcels/CDH-5.4.2-1.cdh5.4.2.p0.2/lib/spark/assembly/lib/spark-assembly-1.3.0-cdh5.4.2-hadoop2.6.0-cdh5.4.2.jar"
    }
  }
}

# END REQUIRED SETTINGS
