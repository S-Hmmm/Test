# -*- coding: utf-8 -*-

import pytest
import subprocess


pytest.main()
subprocess.call('allure generate allure_report/allure_json -o allure_report/allure_html --clean', shell=True)
# subprocess.call('allure serve -h 127.0.0.1 allure_report/allure_json', shell=True)
