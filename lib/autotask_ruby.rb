# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash'
require 'savon'
require 'nokogiri'
require 'autotask_ruby/configuration'
require 'autotask_ruby/constants'
require 'autotask_ruby/query'
require 'autotask_ruby/query_xml'
require 'autotask_ruby/association'
require 'autotask_ruby/response'
require 'autotask_ruby/query_response'
require 'autotask_ruby/create_response'
require 'autotask_ruby/delete_response'
require 'autotask_ruby/update_response'
require 'autotask_ruby/threshold_and_usage_info_response'
require 'autotask_ruby/zone_info'
require 'autotask_ruby/entity'
require 'autotask_ruby/client'
require 'autotask_ruby/resource'
require 'autotask_ruby/account'
require 'autotask_ruby/contact'
require 'autotask_ruby/account_to_do'
require 'autotask_ruby/appointment'
require 'autotask_ruby/action_type'
require 'autotask_ruby/task'
require 'autotask_ruby/ticket'
require 'autotask_ruby/project'
require 'autotask_ruby/service_call'
require 'autotask_ruby/service_call_ticket'
require 'autotask_ruby/service_call_ticket_resource'
