#!/bin/sh

ADDITIONAL_LIBS_DIR=/opt/additional_libs/

# path to default extensions stored in image
EXTENSIONS_PATH=/opt/extensions/
VT_PLUGIN_PATH=$EXTENSIONS_PATH"vectortiles"
WPS_PLUGIN_PATH=$EXTENSIONS_PATH"wps"
IMG_MOSAIC_PLUGIN_PATH=$EXTENSIONS_PATH"imagemosaic-jdbc"
ORACLE_DS_PLUGIN_PATH=$EXTENSIONS_PATH"oracle"

# VECTOR TILES
if [ "$USE_VECTOR_TILES" == 1 ]; then
  echo "Copy Vector Tiles extension to our GeoServer lib directory";
  ls -la $VT_PLUGIN_PATH
  cp $VT_PLUGIN_PATH/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/
fi
# WPS
if [ "$USE_WPS" == 1 ]; then
  echo "Copy WPS extension to our GeoServer lib directory";
  ls -la $WPS_PLUGIN_PATH
  cp $WPS_PLUGIN_PATH/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/
fi
# IMAGE MOSAIC JDBC
if [ "$USE_IMG_MOSAIC" == 1 ]; then
  echo "Copy Imagemosaic JDBC extension to our GeoServer lib directory";
  ls -la $IMG_MOSAIC_PLUGIN_PATH
  cp $IMG_MOSAIC_PLUGIN_PATH/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/
fi
# ORACLE DATASTORE
if [ "$USE_ORACLE_DS" == 1 ]; then
  echo "Copy Oracle Datastore extension to our GeoServer lib directory";
  ls -la $ORACLE_DS_PLUGIN_PATH
  cp $ORACLE_DS_PLUGIN_PATH/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/
fi

# copy additional geoserver libs before starting the tomcat
if [ -d "$ADDITIONAL_LIBS_DIR" ]; then
    echo "Copy additional geoserver libs before starting the tomcat";
    cp $ADDITIONAL_LIBS_DIR/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/
fi

# ENABLE CORS
if [ "$USE_CORS" == 1 ]; then
  echo "Enabling CORS for GeoServer"
  echo "Copy a modified web.xml to $CATALINA_HOME/geoserver/WEB-INF/";
  cp /opt/web-cors-enabled.xml $CATALINA_HOME/webapps/geoserver/WEB-INF/web.xml
fi

# start the tomcat
$CATALINA_HOME/bin/catalina.sh run
