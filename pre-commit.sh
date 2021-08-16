#!/bin/sh

has_errors=0

# 获取git暂存的所有go代码
all_go_files=$(git diff --cached --name-only --diff-filter=ACM | grep '.go$')

declare -a go_files
declare -a go_dirs
for file in ${all_go_files[*]}; do
    # 过滤vendor、prootobuf自动生产的文件
    if [[ $file == "vendor"* || $file == *".pb.go" ]];then
        continue
    else
        go_files+=("$file")

        # 文件夹去重
        exist_dir=0
        dir=`echo "$file" |xargs -n1 dirname|sort -u`
        for somedir in ${go_dirs[*]}; do
            if [[ $dir == $somedir ]]; then
                exist_dir=1
                break
            fi
        done

        if [[ $exist_dir -eq 0 ]]; then
            go_dirs+=("$dir")
        fi
    fi
done

[ -z "$go_files" ] && exit 0

# goimports 自动导包
echo "goimports start..."
if goimports >/dev/null 2>&1; then  # 检测是否安装
  import_error=false
  for file in ${go_files[*]} ; do
    import_result="$(goimports -w $file)"
    if test -n "$import_result" ; then
      echo "goimports -w '$file':\n$import_result"
      import_error=true
      has_errors=1
    fi
  done

  if [ import_error = true ] ; then
		echo "\n"
	fi
else
	echo 'Error: goimports not install. Run: "go get -u golang.org/x/tools/cmd/goimports"' >&2
	exit 1
fi

# golangci-lint 代码规范检测
echo "golangci-lint start..."
if golangci-lint >/dev/null 2>&1; then  # 检测是否安装
	lint_errors=false
	for dir in ${go_dirs[*]} ; do
		lint_result="$(golangci-lint run $dir)" # run golangci-lint
		if test -n "$lint_result" ; then
			echo "golangci-lint run '$dir':\n$lint_result"
			lint_errors=true
			has_errors=1
		fi
	done

	if [ $lint_errors = true ] ; then
		echo "\n"
	fi
else
	echo 'Error: golangci-lint not install. See: https://golangci-lint.run/usage/install/#local-installation' >&2
	exit 1
fi

exit $has_errors