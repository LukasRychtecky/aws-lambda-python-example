PYTHON = python2
VAR_DIR = $(CURDIR)/var
VIRTUAL_ENV = $(VAR_DIR)/ve
PYTHON_BIN = $(VIRTUAL_ENV)/bin
DEPLOY_DIR = $(VAR_DIR)/deploy

pack: cleandeploydir
	mkdir -p $(VAR_DIR)/deploy
	cp -R $(CURDIR)/wget_py $(DEPLOY_DIR)
	cp -R $(VIRTUAL_ENV)/lib/python2.7/site-packages/* $(DEPLOY_DIR)
	cp $(CURDIR)/main.py $(DEPLOY_DIR)/
	find $(DEPLOY_DIR) -name "*.pyc" -delete;
	cd $(DEPLOY_DIR) && zip -r9 $(VAR_DIR)/wget-py.zip *


deploy: pack
	aws lambda update-function-code \
	--function-name wget_py \
	--zip-file fileb://$(VAR_DIR)/wget-py.zip \
	--profile user \


firstdeploy: pack
	aws lambda create-function \
	--function-name wget_py \
	--zip-file fileb://$(VAR_DIR)/wget-py.zip \
	--handler main.lambda_handler \
	--runtime python2.7 \
	--profile user \
	--timeout 10 \
	--memory-size 1024 \
	--role arn:aws:iam::725043218116:role/service-role/myRole1

install:
	mkdir -p $(VIRTUAL_ENV)
	virtualenv -p $(PYTHON) --no-site-packages $(VIRTUAL_ENV)
	$(PYTHON_BIN)/pip install --upgrade pip -r requirements.txt

clean:
	rm -Rf $(VAR_DIR)

cleandeploydir:
	rm -Rf $(DEPLOY_DIR)
