# info

psm = ''
# allure生成html报告的路径
allure_dir = 'allure_report/allure_json'
allure_report_dir = 'allure_report/allure_html'
# junit生成的xml报告的目录
junit_dir = 'output/result.xml'
# case目录
cases = '\tests'
# case错误后重试次数
rerun = 0
# case错误后重试间隔，单位秒
rerun_delay = 0
# case标签，默认boe
marks = boe

## help: Help for this project
help: Makefile
	@echo "Usage:\n  make [command]"
	@echo
	@echo "Available Commands:"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'


.PHONY: pip
## pip: pip3 安装依赖
pip:
	@pip3 install -r requirements.txt --trusted-host bytedpypi.byted.org


.PHONY: gen-report
## gen-report: 生成测试报告,会强制覆盖
gen-report:
	@allure generate ${allure_dir} -o ${allure_report_dir} --clean


.PHONY: scan
## scan: 执行测试用例 make run dir=cases/crm rerun=4 rerun_delay=0
scan:
	@pytest --collect-only


.PHONY: run
## run: 执行测试用例 例如 make run rerun=2 rerun_delay=1
run:
	@pytest -n 4 -v --alluredir=${allure_dir} --junitxml=${junit_dir} --reruns ${rerun} --reruns-delay ${rerun_delay}
	make gen-report


.PHONY: report
## report: 启动allure报告服务
report:
	@allure serve -h 127.0.0.1 ${allure_dir}


.PHONY: clean
## clean: 清理报告
clean:
	@erase ${allure_dir}\*
	@erase D:\WorkBench\automation\output\result.xml


.PHONY: init-env
## init-env: 初始化开发环境
init-env:
	@virtualenv venv --python=python3
	@pip3 install -r requirements.txt  --trusted-host bytedpypi.byted.org


#>##############################debug命令，可以自主修改################################
.PHONY: debug
## debug: 执行测试用例，  make debug rerun=2 rerun_delay=1  env='online' cases='cases/crm'
debug: clean pip
	@export RUNTIME_ENV=${env} && pytest -n 4 -v -m=${env}  --alluredir=${allure_dir} --junitxml=${junit_dir}  --reruns ${rerun} --reruns-delay ${rerun_delay} ${cases};make gen-report
