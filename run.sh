#! /usr/bin/env bash

main() {
  local _cwd=
  _cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"


  export OTEL_SERVICE_NAME="$(basename "${_cwd}")"
  export OTEL_TRACES_EXPORTER=console,otlp #,jaeger
  export OTEL_METRICS_EXPORTER=console # ,jaeger
  export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:16685

  # export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

  # debug grpc
  # export GRPC_VERBOSITY=debug
  # export GRPC_TRACE=http,call_error,connectivity_state

  pipenv run opentelemetry-instrument python3 main.py


}

main "$@"
