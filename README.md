# 使用步骤
1. 先 sh ca.sh 生成根证书, 其中 国家/省 填了之后必须记住
2. 再运行 sh server.sh 生成服务器证书 其中 国家/省 和上面一致

# 以下是原作者信息

本地环境生成https证书脚本

**1. 克隆库,cd 进入目录**
```sh
git clone https://github.com/chuchur-china/local-cert-generator.git
cd local-cert-generator
```
**2. 运行脚本以创建根证书：**
```
sh createRootCA.sh
```
**3 . 将刚刚生成的根证书添加到可信证书列表中。此步骤取决于您运行的操作系统：**

macOS：打开Keychain Access并将根证书导入您的系统钥匙串。然后将证书标记为受信任。
windows：只需要将根证书添加至信任库即可
```sh
keytool -import -v -file D:/根证书路径 -keystore E:\导出信任库路径/xxx.keystore
```
>注意：您可能需要重新启动浏览器才能正确加载新受信任的根证书。

**4.运行脚本以创建域证书localhost：**

```sh
sh createSelfSigned.sh
```
**5. 拷贝server.key和server.crt 到项目对应的目录 在相关配置启用即可**

**Node中的使用**
```js
var path = require('path')
var fs = require('fs')
var express = require('express')
var https = require('https')

var certOptions = {
  key: fs.readFileSync(path.resolve('build/cert/server.key')),
  cert: fs.readFileSync(path.resolve('build/cert/server.crt'))
}

var app = express()

var server = https.createServer(certOptions, app).listen(443)
```

**devServer中的使用**
```js
const fs = require('fs')
const path = require('path');

devServer: {
    // http2: true, //这里可以开启http2
    https: {
        key: fs.readFileSync(path.join(__dirname + "/server.key")),
        cert: fs.readFileSync(path.join(__dirname + "/server.crt")),
        ca: fs.readFileSync(path.join(__dirname + "/rootCA.pem")),
    },
    ....
}
```
