# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'uri'

require_relative 'service/persistence'

require_relative 'contract_hunt/site'
require_relative 'contract_hunt/item'

require_relative 'contract_hunt/sites/37signals'
require_relative 'contract_hunt/sites/github'
require_relative 'contract_hunt/sites/indeed'
require_relative 'contract_hunt/sites/job_mote'
require_relative 'contract_hunt/sites/rails_jobs_in'
require_relative 'contract_hunt/sites/ruby_forum'
require_relative 'contract_hunt/sites/ruby_inside'
require_relative 'contract_hunt/sites/ruby_now'
require_relative 'contract_hunt/sites/stack_overflow'
require_relative 'contract_hunt/sites/startuply'
require_relative 'contract_hunt/sites/technojobs'
require_relative 'contract_hunt/sites/top_ruby_jobs'
require_relative 'contract_hunt/sites/work_in_startups'
require_relative 'contract_hunt/sites/working_with_rails'
