0=${(%):-%N}
autoload-funcdir "${0:a:h}/functions"

if alias run-help > /dev/null; then
  unalias run-help
  autoload run-help
fi
