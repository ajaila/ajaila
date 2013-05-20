$:.unshift File.expand_path("../", __FILE__)

require "gli"
include GLI::App
require "rio"
require "liquid"
require "tilt"

require "styling"
require "messager"
require "ajaila/root_definer"
require "console_helper"
require "initializers"
require "generators"
require "executors"
require "status"