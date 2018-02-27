require 'spec_helper'

describe 'Resolver' do

  subject { Corals::Resolver.new }

  let(:loader) { hashie load: :loaded_rules }
  let(:runner) { hashie run: :results }
  let(:opts) {{}}
  let(:rules) {[]}

  before do
    stub(Corals::Loader).new { loader }
    stub(Corals::Runner).new { runner }
    stub(subject).applicable { :applicable_rules }
  end

  after { subject.resolve opts, rules }

  context 'defaults' do

    it('loads') { mock(loader).load :applicable_rules }

    it('runs') { mock(runner).run :loaded_rules, {} }

  end

  context 'with opts' do

    before do
      opts[:name] = :name
      stub(runner).compile { :compiled_rules }
    end

    it('compiles') { mock(runner).compile :loaded_rules }

    it('parses') { mock(Corals::Parser).parse opts, :compiled_rules }

  end

  context 'anonymous rules' do

    before { rules << anonymous_rules }

    let(:anonymous_rules) {{x:42}}

    it 'runs' do
      mock(runner).run anything, opts do |actual_rules, _|
        expect(actual_rules.rules.first.x).to eq 42
      end
    end

  end

end