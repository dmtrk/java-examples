echo "Starting java process (JAVA_OPTS=$JAVA_OPTS)(PATH=$PATH)"
java -XX:+PrintFlagsFinal -XX:+PrintGCDetails $JAVA_OPTS -jar /opt/lib/app.jar