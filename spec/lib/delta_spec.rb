require 'spec_helper'

describe Dydx::Delta do
  it { expect(d.class).to eq(Delta) }
  it { expect(dx.class).to eq(Delta) }
  it { expect(dx.var).to eq(:x) }
  it { expect(dx(y).class).to eq(Delta) }
  it { expect(dx(y).var).to eq(:x) }
  it { expect(dx(y).function).to eq(:y) }
  it { expect { dxy }.to raise_error(NameError) }

  before { reset }

  it 'ex1' do
    $y = x ** n
    expect(d/dx($y)).to eq( n * ( x ** ( n - 1 ) ))
  end

  it 'ex2' do
    $y = x ** (x * 2)
    expect(
      eval((d/dx($y)).to_s)
    ).to eq(
     ( ( x ** ( 2 * x ) ) * ( 2 * ( 1 + log( x ) ) ) )
    )
  end

  it 'ex3' do
    $y = (t ** 2) / 2
    expect(dy/dt).to eq(t)
  end

  it 'ex4' do
    $y = 2 * (e ** (2 * z))
    expect(dy/dz).to eq(4 * ( e ** ( 2 * z ) ))
  end

  it 'ex5' do
    $y = 2 ** x
    expect(dy/dx).to eq(( 2 ** x ) * log( 2 ))
  end

  it 'ex6' do
    $y = x ** x
    expect(dy/dx).to eq(x ** x * (log(x) + 1))
  end
end
