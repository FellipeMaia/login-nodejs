
NAME=login
SUFFIX=financial
PWD=$(shell pwd)
APPDIR=/app


dev.setup-image: Dockerfile
	docker build --target development --tag ${SUFFIX}/$(NAME):development .

dev.remove-image:
ifeq ($(shell docker images -q ${SUFFIX}/${NAME}development 2> /dev/null | wc -l | bc), 0)
	@docker rmi $(NAME):development
endif

dev.check-if-image-exist:
ifeq ($(shell docker images -q ${SUFFIX}/${NAME}:development 2> /dev/null | wc -l | bc), 0)
	@make dev.setup-image
endif

dev.start: dev.check-if-image-exist
	@docker run -it -v ${PWD}:${APPDIR} --network=host --env-file=.env -p 5001:5001 -w ${APPDIR} --name=inst-${NAME} ${SUFFIX}/${NAME}:development
