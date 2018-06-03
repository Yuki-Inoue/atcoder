#!/usr/bin/env ruby

require 'template'

describe 'Array#clip' do
  it 'working correctly' do
    a = [1, 2, 3]
    expect(a.clip 2).to eq [1]
    expect(a.clip 1).to eq [1, 2]
  end

  it 'working on big integer given' do
    a = [1, 2, 3]
    expect(a.clip 5).to eq []
  end

  it 'working on argument 0' do
    a = [1, 2, 3]
    expect(a.clip 0).to eq a
  end

  # Array#drop raises error, so we comply with it.
  it 'raises Argument Error' do
    a = [1, 2, 3]
    expect { a.clip(-1) }.to raise_error ArgumentError
  end
end
