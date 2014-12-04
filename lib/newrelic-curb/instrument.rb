require 'curb'
require 'newrelic_rpm'

::Curl::Easy.class_eval do
  URI_CLASS = defined?(::Addressable) ? ::Addressable::URI : URI
  def host
    if self.url.respond_to?(:host)
      self.url.host
    else
      URI_CLASS.parse("#{self.url.start_with?('http') ? '' : 'http://'}#{self.url}").host
    end
  end

  def perform_with_newrelic_trace(*args, &block)
    metrics = ["External/#{host}/Curl::Easy","External/#{host}/all","External/all"]
    if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
      metrics << "External/allWeb"
    else
      metrics << "External/allOther"
    end
    if self.class.respond_to?(:trace_execution_scoped)
      self.class.trace_execution_scoped metrics do
        perform_without_newrelic_trace(*args, &block)
      end
    else
      perform_without_newrelic_trace(*args, &block)
    end
  end
  alias perform_without_newrelic_trace perform
  alias perform perform_with_newrelic_trace
end
