import requests
import json


url = 'https://api3-normal-c-lq.amemv.com/aweme/v2/douplus/ad/'
headers = {
  "Host": "api3-normal-c-lq.amemv.com",
  "user-agent": "com.ss.android.ugc.aweme/130800 (Linux; U; Android 10; zh_CN; GM1910; Build/QKQ1.190716.003; Cronet/TTNetVersion:58eeeb7f 2020-11-03 QuicVersion:47946d2a 2020-10-14)",
  "x-use-ppe": "1",
  "x-tt-env": "ppe_douyin_04",
  "Cookie": "sessionid=35332dd03957a9118962a4cd0cfc9c48"
}
data = {
  "seq_id": "",
  "device_id": "2418556899427624",
  "aid": "1128",
  "item_id": "6899768505390910733"
}

resp = requests.get(url, headers=headers, params=data).json()
json = json.dumps(resp, sort_keys=True, indent=4)
with open('ad.txt', 'w') as f:
    f.write(json)
    f.close()
