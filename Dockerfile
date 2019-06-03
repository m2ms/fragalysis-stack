FROM xchem/fragalysis-backend:latest

ENV APP_ROOT /code
ENV APP_USER_ID 2000
RUN useradd -c 'Container user' --user-group --uid ${APP_USER_ID} --home-dir ${APP_ROOT} -s /bin/bash frag

# RUN apt-get update -y
RUN apt-get install -y wget gnupg bzip2
# Add in the frontend code
RUN git clone https://github.com/xchem/fragalysis-frontend ${APP_ROOT}/frontend

# Install yarn (instead of npm)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y && apt-get install -y yarn

# Install nodejs
RUN apt-get install -y nodejs

# Now build the code
RUN cd ${APP_ROOT}/frontend && yarn install
RUN cd ${APP_ROOT}/frontend && yarn run build

ADD docker-entrypoint.sh ${APP_ROOT}/docker-entrypoint.sh

# Symlink these
RUN mkdir ${APP_ROOT}/static
RUN ln -s ${APP_ROOT}/frontend/bundles/ ${APP_ROOT}/static/bundles

RUN chmod 755 ${APP_ROOT}/docker-entrypoint.sh
RUN chmod 755 ${APP_ROOT}/makemigrations.sh
RUN chmod 755 ${APP_ROOT}/launch-stack.sh

RUN chown -R ${APP_USER_ID} ${APP_ROOT} /run /var

WORKDIR ${APP_ROOT}
CMD ["./docker-entrypoint.sh"]
