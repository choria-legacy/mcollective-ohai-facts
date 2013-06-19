#!/usr/bin/env rspec

require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../', 'facts', 'opscodeohai_facts.rb')

module MCollective
  module Facts
    describe Opscodeohai_facts do

      module Ohai;class System;end;end
      module Ohai;class Mash < Hash;end;end

      let(:ohai) { mock }
      let(:plugin) { Opscodeohai_facts.new }

      before do
        Log.stubs(:debug)
      end

      describe "#load_facts_from_source" do
        it "should load facts from source" do
          facts = {"fact1" => "value1"}
          Ohai::System.stubs(:new).returns(ohai)
          ohai.stubs(:all_plugins)
          ohai.stubs(:data).returns(facts)
          plugin.expects(:ohai_flatten).with("fact1", "value1", [], {}).returns({"fact1" => "value1"})

          plugin.load_facts_from_source
        end
      end

      describe "#ohai_flatten" do
        it "should flatten an Ohai structure" do
          result = {}
          plugin.send(:ohai_flatten, "foo", Mash.new({"bar" => [1,2,3]}), [], result)
          result.should == {"foo.bar" => "1, 2, 3"}
        end
      end
    end
  end
end
