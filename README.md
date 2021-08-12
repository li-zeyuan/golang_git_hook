### 代码检查
- goimports
  - 自动格式化导包
  - 格式化代码
- golint
  - 代码静态检查
- commit msg检查（未完成）
  - 以feat|fix|docs|chore开头
  - msg字数不少于10个字符
- 期待你的mr

### 安装
- 1、cd 到.git所在的目录
- 2、一键安装：`curl -kSL http://raw.githubusercontent.com/li-zeyuan/golang_git_hook/master/install.sh | sh`
- 3、提示`curl: (35) LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to raw.githubusercontent.com:443 `;重试即可

### 使用
- 正常commit即可
- 跳过代码检查：`git add . && git commit --no-verify`
    ```json
     1、紧急情况下使用
     2、你的--no-verify，意味着你的代码转移给其他童鞋verify
  
### 参考
- 利用git hook规范你的代码与commit message：https://github.com/razeencheng/git-hooks
- shell脚本基础：https://shellscript.readthedocs.io/zh_CN/latest/1-syntax/1-scriptstruct/index.html