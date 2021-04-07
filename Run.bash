set -e
if [ ! -f ../bin/go ]; then
	exit 1
fi
eval $(../bin/go env)
export GOROOT
export GOPATH=/nonexist-gopath
unset CDPATH
export GOBIN=$GOROOT/bin
unset GOFLAGS
unset GO111MODULE
export GOHOSTOS
export CC
ulimit -c 0
[ "$(ulimit -H -n)" = "unlimited" ] || ulimit -S -n $(ulimit -H -n)
[ "$(ulimit -H -d)" = "unlimited" ] || ulimit -S -d $(ulimit -H -d)
if ulimit -T &> /dev/null; then
	[ "$(ulimit -H -T)" = "unlimited" ] || ulimit -S -T $(ulimit -H -T)
fi
exec ../bin/go tool dist test -rebuild "$@"
