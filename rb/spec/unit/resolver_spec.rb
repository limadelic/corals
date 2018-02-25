require 'spec_helper'

describe 'Resolver' do

  subject { Corals::Resolver.new }

  let(:loader) { hashie load: :loaded_rules }
  let(:runner) { hashie run: :results }

  before do
    stub(Corals::Loader).new { loader }
    stub(Corals::Runner).new { runner }
    stub(subject).applicable { :applicable_rules }
  end

  after { subject.resolve }

  context 'defaults' do

    it('loads') { mock(loader).load :applicable_rules }

    it('runs') { mock(runner).run :loaded_rules, {} }

  end

end