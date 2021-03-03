FROM debian:buster

ADD image_pre_build_script.sh /image_pre_build_script.sh
RUN chmod +x /image_pre_build_script.sh

RUN ["/bin/bash", "-c", "/image_pre_build_script.sh"]

RUN ["/bin/bash"]
#ENTRYPOINT ["/bin/bash"]
