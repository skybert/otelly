#! /usr/bin/env bash

main() {
  local _cwd=
  _cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"


  export OTEL_SERVICE_NAME="$(basename "${_cwd}")"

  # Local jaeger, so no https
  export OTEL_EXPORTER_JAEGER_GRPC_INSECURE=true

  export OTEL_TRACES_EXPORTER=console,otlp,jaeger
  export OTEL_METRICS_EXPORTER=console
  # export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:16685
  # export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:14250


  # debug grpc
  # export GRPC_VERBOSITY=debug
  # export GRPC_TRACE=http,call_error,connectivity_state

  # Needed when using OTEL_TRACES_EXPORTER=jaeger
  export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
  pipenv run opentelemetry-instrument python3 main.py


}

main "$@"
