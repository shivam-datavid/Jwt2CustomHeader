FROM kong:latest
# Label the image
LABEL description="Custom Kong image with Jwt2CustomHeader plugin"
# Install LuaRocks to manage Lua packages
USER root
RUN apt-get update && apt-get install -y unzip
# Copy the plugin directory
COPY .  /opt/Jwt2CustomHeader
# Set the working directory to where you've copied your plugin
WORKDIR /opt/Jwt2CustomHeader
# Install your plugin using LuaRocks
RUN luarocks make
# Return to the Kong's default working directory
WORKDIR /
# Add the custom plugin to the list of plugins Kong should load
ENV KONG_PLUGINS=bundled,jwt2customheader
